import requests
from bs4 import BeautifulSoup
import pandas as pd
import re
import time
import argparse
from urllib.parse import urljoin
import logging
from tqdm import tqdm
import os

# ロギング設定
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[logging.FileHandler("scraper.log"), logging.StreamHandler()]
)
logger = logging.getLogger(__name__)

class ExhibitorScraper:
    def __init__(self, base_url):
        self.base_url = base_url
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        })
        self.exhibitors = []
        self.total_links = 0
        self.processed_links = 0
        
    def get_soup(self, url):
        """URLからBeautifulSoupオブジェクトを取得"""
        try:
            response = self.session.get(url, timeout=30)
            response.raise_for_status()
            return BeautifulSoup(response.text, 'html.parser')
        except requests.exceptions.RequestException as e:
            logger.error(f"エラー: {url}の取得に失敗しました - {e}")
            return None
    
    def find_exhibitor_links(self):
        """出展企業一覧ページから各企業の詳細ページへのリンクを取得"""
        exhibitor_links = []
        soup = self.get_soup(self.base_url)
        if not soup:
            return []
        
        # 注: 実際のサイト構造に合わせて以下のセレクタを調整する必要があります
        link_patterns = [
            'a[href*="exhibitor"]', 'a[href*="company"]', 
            'a[href*="booth"]', 'a[href*="出展"]', 
            'a[href*="企業"]', '.exhibitor-list a'
        ]
        
        for pattern in link_patterns:
            links = soup.select(pattern)
            if links:
                logger.info(f"{pattern}パターンで{len(links)}個のリンクを検出")
                for link in links:
                    href = link.get('href')
                    if href:
                        full_url = urljoin(self.base_url, href)
                        exhibitor_links.append(full_url)
        
        # 重複を削除
        exhibitor_links = list(set(exhibitor_links))
        logger.info(f"合計{len(exhibitor_links)}個の出展企業リンクを検出")
        return exhibitor_links
    
    def extract_company_info(self, url):
        """企業詳細ページから情報を抽出"""
        soup = self.get_soup(url)
        if not soup:
            return None
        
        # 基本情報の抽出
        info = {
            '出展社名': '',
            '出展社社員数': '',
            '出展社資本金': '',
            '出展物': '',
            '出展物の詳細': '',
            'URL': url
        }
        
        # 企業名を探す - よくあるパターン
        name_patterns = [
            'h1', '.company-name', '.exhibitor-name', 
            '.booth-title', '[class*="company"]', '[class*="exhibitor"]'
        ]
        
        for pattern in name_patterns:
            elements = soup.select(pattern)
            if elements:
                info['出展社名'] = elements[0].get_text().strip()
                break
        
        # 社員数を探す
        employee_patterns = [
            '社員数', '従業員数', 'employees', 'staff'
        ]
        
        # 資本金を探す
        capital_patterns = [
            '資本金', 'capital'
        ]
        
        # 出展物を探す
        product_patterns = [
            '出展品', '展示品', '出展物', 'products', 'exhibits'
        ]
        
        # ページ内のすべてのテキストノードをチェック
        text_elements = soup.find_all(text=True)
        for text in text_elements:
            text = text.strip()
            if not text:
                continue
                
            # 社員数のチェック
            if not info['出展社社員数']:
                for pattern in employee_patterns:
                    if pattern in text.lower():
                        # 数値を含む行を抽出
                        match = re.search(r'[0-9,]+\s*人|[0-9,]+\s*名|[0-9,]+\s*employees', text)
                        if match:
                            info['出展社社員数'] = match.group(0).strip()
                        else:
                            # 次の要素も確認
                            next_elem = text.find_next(text=True)
                            if next_elem and re.search(r'[0-9,]+', next_elem.strip()):
                                info['出展社社員数'] = next_elem.strip()
            
            # 資本金のチェック
            if not info['出展社資本金']:
                for pattern in capital_patterns:
                    if pattern in text.lower():
                        # 金額を含む行を抽出
                        match = re.search(r'[0-9,.]+\s*円|[0-9,.]+\s*万円|[0-9,.]+\s*億円|¥[0-9,.]+', text)
                        if match:
                            info['出展社資本金'] = match.group(0).strip()
                        else:
                            # 次の要素も確認
                            next_elem = text.find_next(text=True)
                            if next_elem and re.search(r'[0-9,.]+', next_elem.strip()):
                                info['出展社資本金'] = next_elem.strip()
            
            # 出展物のチェック
            if not info['出展物']:
                for pattern in product_patterns:
                    if pattern in text.lower():
                        # 次の要素を出展物とみなす
                        next_elem = text.find_next(text=True)
                        if next_elem:
                            info['出展物'] = next_elem.strip()
                            
                            # さらに次の要素を詳細とみなす
                            detail_elem = next_elem.find_next(text=True)
                            if detail_elem:
                                info['出展物の詳細'] = detail_elem.strip()
        
        # 製品情報セクションを探す
        product_sections = soup.select('.product, .exhibit, [class*="product"], [class*="exhibit"]')
        if product_sections and not info['出展物']:
            products = []
            details = []
            
            for section in product_sections[:3]:  # 最初の3つまで取得
                product_name = section.select_one('h3, h4, .name, .title')
                product_desc = section.select_one('.description, .detail, p')
                
                if product_name:
                    products.append(product_name.get_text().strip())
                if product_desc:
                    details.append(product_desc.get_text().strip())
            
            if products:
                info['出展物'] = ', '.join(products)
            if details:
                info['出展物の詳細'] = ' / '.join(details)
        
        return info
    
    def update_progress(self):
        """進捗状況を更新して表示"""
        self.processed_links += 1
        progress_percent = (self.processed_links / self.total_links) * 100
        
        # 進捗バーの長さ
        bar_length = 50
        filled_length = int(bar_length * self.processed_links // self.total_links)
        
        # 進捗バーを作成
        bar = '█' * filled_length + '░' * (bar_length - filled_length)
        
        # 進捗情報を表示
        print(f'\r進捗状況: [{bar}] {self.processed_links}/{self.total_links} ({progress_percent:.1f}%)', end='')
        
        # 最後の企業の場合は改行
        if self.processed_links == self.total_links:
            print()
    
    def scrape_all_exhibitors(self):
        """すべての出展企業情報を取得"""
        links = self.find_exhibitor_links()
        
        if not links:
            logger.warning("出展企業リンクが見つかりませんでした。サイト構造を確認してください。")
            return []
        
        self.total_links = len(links)
        print(f"合計{self.total_links}社の出展企業情報を取得します...")
        
        for link in links:
            info = self.extract_company_info(link)
            if info:
                self.exhibitors.append(info)
            
            # 進捗状況を更新
            self.update_progress()
            
            # サーバーに負荷をかけないよう少し待機
            time.sleep(2)
        
        logger.info(f"合計{len(self.exhibitors)}件の企業情報を取得しました")
        return self.exhibitors
    
    def export_to_excel(self, output_file="exhibitors.xlsx"):
        """取得した企業情報をExcelに出力"""
        if not self.exhibitors:
            logger.warning("出力する企業情報がありません")
            return False
        
        df = pd.DataFrame(self.exhibitors)
        
        try:
            df.to_excel(output_file, index=False)
            logger.info(f"企業情報を{output_file}に出力しました")
            return True
        except Exception as e:
            logger.error(f"Excelへの出力中にエラーが発生しました: {e}")
            return False

def main():
    parser = argparse.ArgumentParser(description='展示会出展企業情報スクレイピングツール')
    parser.add_argument('url', help='展示会Webサイトの出展企業一覧ページURL')
    parser.add_argument('-o', '--output', help='出力するExcelファイル名', default='exhibitors.xlsx')
    args = parser.parse_args()
    
    logger.info(f"スクレイピング開始: {args.url}")
    scraper = ExhibitorScraper(args.url)
    
    try:
        print("展示会出展企業情報取得を開始します...")
        scraper.scrape_all_exhibitors()
        if scraper.export_to_excel(args.output):
            print(f"\n処理が完了しました。結果は {args.output} に保存されています。")
        else:
            print("\nExcel出力に失敗しました。ログを確認してください。")
    except Exception as e:
        logger.error(f"処理中にエラーが発生しました: {e}")
        print("\n処理中にエラーが発生しました。詳細はログを確認してください。")

if __name__ == "__main__":
    main()
