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
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[logging.FileHandler("scraper.log"), logging.StreamHandler()],
)
logger = logging.getLogger(__name__)


class ExhibitorScraper:
    def __init__(self, base_url):
        # トップページのURLを指定
        self.base_url = base_url
        self.session = requests.Session()
        self.session.headers.update(
            {
                "User-Agent": (
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                    "AppleWebKit/537.36 (KHTML, like Gecko) "
                    "Chrome/91.0.4472.124 Safari/537.36"
                )
            }
        )
        self.exhibitors = []
        self.total_links = 0
        self.processed_links = 0

    def get_soup(self, url):
        """指定URLからBeautifulSoupオブジェクトを取得する"""
        try:
            response = self.session.get(url, timeout=30)
            response.raise_for_status()
            return BeautifulSoup(response.text, "html.parser")
        except requests.exceptions.RequestException as e:
            logger.error(f"エラー: {url}の取得に失敗しました - {e}")
            return None

    def find_exhibitor_list_url(self):
        """
        トップページから「出展企業一覧ページ」へのリンクを取得する。
        リンクテキストに「出展企業一覧」や「出展企業」などのキーワードを探す。
        """
        soup = self.get_soup(self.base_url)
        if not soup:
            return None

        keywords = [
            "出展企業一覧",
            "出展企業",
            "出展社一覧",
            "出展社",
            "exhibitor",
            "exhibitors",
        ]
        for a in soup.find_all("a"):
            link_text = a.get_text().strip()
            if any(keyword in link_text for keyword in keywords):
                href = a.get("href")
                if href:
                    full_url = urljoin(self.base_url, href)
                    logger.info(f"出展企業一覧ページリンクを発見: {full_url}")
                    return full_url
        logger.warning(
            "トップページから出展企業一覧ページのリンクが見つかりませんでした。"
        )
        return None

    def find_exhibitor_links(self):
        """
        出展企業一覧ページから各企業の詳細ページへのリンクを抽出する。
        サイト構造に合わせて複数のセレクタパターンでリンクを取得する。
        """
        exhibitor_links = []
        soup = self.get_soup(self.base_url)
        if not soup:
            return []

        link_patterns = [
            'a[href*="exhibitor"]',
            'a[href*="company"]',
            'a[href*="booth"]',
            'a[href*="出展"]',
            'a[href*="企業"]',
            ".exhibitor-list a",
        ]
        for pattern in link_patterns:
            links = soup.select(pattern)
            if links:
                logger.info(f"{pattern}パターンで{len(links)}個のリンクを検出")
                for link in links:
                    href = link.get("href")
                    if href:
                        full_url = urljoin(self.base_url, href)
                        exhibitor_links.append(full_url)
        exhibitor_links = list(set(exhibitor_links))
        logger.info(f"合計{len(exhibitor_links)}個の出展企業リンクを検出")
        return exhibitor_links

    def find_homepage_url(self, soup):
        """
        出展企業詳細ページ内から企業のホームページURLを抽出する。
        リンクテキストに「ホームページ」や「公式サイト」などが含まれるものを対象とする。
        """
        keywords = ["ホームページ", "公式サイト", "Website", "Site"]
        for a in soup.find_all("a", href=True):
            text = a.get_text()
            if any(kw in text for kw in keywords):
                href = a.get("href")
                if href:
                    full_url = urljoin(self.base_url, href)
                    logger.info(f"企業ホームページURLを発見: {full_url}")
                    return full_url
        return None

    def extract_homepage_info(self, homepage_url):
        """
        企業ホームページから従業員数、資本金情報を抽出する。
        正規表現で数値情報を検索する（必要に応じてパターンは調整してください）。
        """
        soup = self.get_soup(homepage_url)
        if not soup:
            return {}

        homepage_info = {"出展社社員数": "", "出展社資本金": ""}
        employee_patterns = ["社員数", "従業員数", "employees", "staff"]
        capital_patterns = ["資本金", "capital"]
        text_elements = soup.find_all(text=True)
        for text in text_elements:
            text = text.strip()
            if not text:
                continue
            # 従業員数の抽出
            if not homepage_info["出展社社員数"]:
                for pattern in employee_patterns:
                    if pattern in text:
                        match = re.search(r"([0-9,]+\s*(人|名))", text)
                        if match:
                            homepage_info["出展社社員数"] = match.group(1).strip()
                            break
            # 資本金の抽出
            if not homepage_info["出展社資本金"]:
                for pattern in capital_patterns:
                    if pattern in text:
                        match = re.search(r"([0-9,.]+\s*円)", text)
                        if match:
                            homepage_info["出展社資本金"] = match.group(1).strip()
                            break
            if homepage_info["出展社社員数"] and homepage_info["出展社資本金"]:
                break
        return homepage_info

    def extract_company_info(self, url):
        """
        出展企業詳細ページから企業情報を抽出する。
        また、企業ホームページURLがあればそちらから追加情報（従業員数、資本金）を取得する。
        """
        soup = self.get_soup(url)
        if not soup:
            return None

        info = {
            "出展社名": "",
            "出展社社員数": "",
            "出展社資本金": "",
            "出展物": "",
            "出展物の詳細": "",
            "URL": url,
            "企業ホームページURL": "",
        }
        # 企業名の抽出
        name_patterns = [
            "h1",
            ".company-name",
            ".exhibitor-name",
            ".booth-title",
            '[class*="company"]',
            '[class*="exhibitor"]',
        ]
        for pattern in name_patterns:
            elements = soup.select(pattern)
            if elements:
                info["出展社名"] = elements[0].get_text().strip()
                break

        employee_patterns = ["社員数", "従業員数", "employees", "staff"]
        capital_patterns = ["資本金", "capital"]
        product_patterns = ["出展品", "展示品", "出展物", "products", "exhibits"]

        text_elements = soup.find_all(text=True)
        for text in text_elements:
            text = text.strip()
            if not text:
                continue

            if not info["出展社社員数"]:
                for pattern in employee_patterns:
                    if pattern in text:
                        match = re.search(r"([0-9,]+\s*(人|名))", text)
                        if match:
                            info["出展社社員数"] = match.group(1).strip()
                            break

            if not info["出展社資本金"]:
                for pattern in capital_patterns:
                    if pattern in text:
                        match = re.search(r"([0-9,.]+\s*円)", text)
                        if match:
                            info["出展社資本金"] = match.group(1).strip()
                            break

            if not info["出展物"]:
                for pattern in product_patterns:
                    if pattern in text:
                        next_elem = text.find_next(text=True)
                        if next_elem:
                            info["出展物"] = next_elem.strip()
                            detail_elem = next_elem.find_next(text=True)
                            if detail_elem:
                                info["出展物の詳細"] = detail_elem.strip()
                            break

        # 企業ホームページURLの抽出
        homepage_url = self.find_homepage_url(soup)
        if homepage_url:
            info["企業ホームページURL"] = homepage_url
            homepage_info = self.extract_homepage_info(homepage_url)
            if homepage_info.get("出展社社員数"):
                info["出展社社員数"] = homepage_info["出展社社員数"]
            if homepage_info.get("出展社資本金"):
                info["出展社資本金"] = homepage_info["出展社資本金"]
        else:
            info["企業ホームページURL"] = ""

        return info

    def update_progress(self):
        """進捗状況を表示する"""
        self.processed_links += 1
        progress_percent = (self.processed_links / self.total_links) * 100
        bar_length = 50
        filled_length = int(bar_length * self.processed_links // self.total_links)
        bar = "█" * filled_length + "░" * (bar_length - filled_length)
        print(
            f"\r進捗状況: [{bar}] {self.processed_links}/{self.total_links} ({progress_percent:.1f}%)",
            end="",
        )
        if self.processed_links == self.total_links:
            print()

    def scrape_all_exhibitors(self):
        """
        出展企業一覧ページから各企業の詳細情報を順次取得する。
        """
        links = self.find_exhibitor_links()
        if not links:
            logger.warning(
                "出展企業リンクが見つかりませんでした。サイト構造を確認してください。"
            )
            return []
        self.total_links = len(links)
        print(f"合計{self.total_links}社の出展企業情報を取得します...")
        for link in links:
            info = self.extract_company_info(link)
            if info:
                self.exhibitors.append(info)
            self.update_progress()
            time.sleep(2)  # サーバー負荷を軽減するため少し待機
        logger.info(f"合計{len(self.exhibitors)}件の企業情報を取得しました")
        return self.exhibitors

    def scrape_exhibitors_from_top(self):
        """
        トップページ内に直接記載されている出展企業情報を抽出する（サイトによりセレクタは調整してください）。
        """
        soup = self.get_soup(self.base_url)
        if not soup:
            return []
        exhibitors = []
        list_selectors = [".exhibitor-list", "#exhibitors", ".exhibitor-section"]
        for selector in list_selectors:
            section = soup.select_one(selector)
            if section:
                items = section.find_all(["li", "div"], recursive=True)
                for item in items:
                    name = item.get_text(strip=True)
                    if name:
                        exhibitors.append(
                            {
                                "出展社名": name,
                                "URL": self.base_url,
                                "出展社社員数": "",
                                "出展社資本金": "",
                                "出展物": "",
                                "出展物の詳細": "",
                                "企業ホームページURL": "",
                            }
                        )
                if exhibitors:
                    logger.info(
                        f"{selector}から直接{len(exhibitors)}件の出展企業情報を抽出"
                    )
                    break
        if not exhibitors:
            logger.warning("トップページから直接出展企業情報を抽出できませんでした。")
        self.exhibitors = exhibitors
        return exhibitors

    def export_to_excel(self, output_file="exhibitors.xlsx"):
        """取得した企業情報をExcelに出力する"""
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
    parser = argparse.ArgumentParser(
        description="展示会出展企業情報スクレイピングツール"
    )
    parser.add_argument("url", help="展示会WebサイトのトップページURL")
    parser.add_argument(
        "-o", "--output", help="出力するExcelファイル名", default="exhibitors.xlsx"
    )
    args = parser.parse_args()

    logger.info(f"スクレイピング開始: {args.url}")
    scraper = ExhibitorScraper(args.url)

    # トップページから出展企業一覧ページへのリンクを探す
    exhibitor_list_url = scraper.find_exhibitor_list_url()
    if exhibitor_list_url:
        logger.info(
            "出展企業一覧ページが見つかりました。そちらから詳細情報を取得します。"
        )
        scraper.base_url = exhibitor_list_url  # 一覧ページに切り替え
        scraper.scrape_all_exhibitors()
    else:
        logger.info(
            "出展企業一覧ページへのリンクが見つからなかったため、トップページから直接企業情報を取得します。"
        )
        scraper.scrape_exhibitors_from_top()

    if scraper.export_to_excel(args.output):
        print(f"\n処理が完了しました。結果は {args.output} に保存されています。")
    else:
        print("\nExcel出力に失敗しました。ログを確認してください。")


if __name__ == "__main__":
    main()
