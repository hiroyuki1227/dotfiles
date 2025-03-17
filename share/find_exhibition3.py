import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin
from tqdm import tqdm
import re


def fetch_exhibitor_list(url):
    """
    出展社一覧ページから各出展社の名称と詳細ページURLを取得する関数
    ※HTML構造に合わせてタグやクラス名の指定を変更してください
    """
    response = requests.get(url)
    response.encoding = "utf-8"
    soup = BeautifulSoup(response.text, "html.parser")

    exhibitors = []
    # 例として、一覧ページ内の各出展社が <a> タグでリンクされていると仮定
    # ※実際のサイト構造に合わせてセレクタ等を変更する必要があります。
    for a in soup.select("a"):
        name = a.get_text(strip=True)
        href = a.get("href")
        # 出展社名が空でなかったり、特定のURLパターンであればリストに追加
        if name and href and "exhibitor_detail" in href:
            full_url = urljoin(url, href)
            exhibitors.append({"name": name, "detail_url": full_url})
    return exhibitors


def fetch_exhibitor_details(detail_url):
    """
    出展社詳細ページから従業員数、資本金、企業URLを抽出する関数
    ※詳細情報のラベルやレイアウトに合わせて正規表現等のパース処理を調整してください
    """
    try:
        response = requests.get(detail_url)
        response.encoding = "utf-8"
        soup = BeautifulSoup(response.text, "html.parser")
    except Exception as e:
        print(f"詳細ページの取得エラー: {detail_url}\n{e}")
        return {"従業員数": "情報なし", "資本金": "情報なし", "企業URL": "情報なし"}

    # ページ全体のテキストを対象に、キーワードに続く値を抽出する例
    text = soup.get_text()
    employee_match = re.search(r"従業員数\s*[:：]\s*([\d,]+)", text)
    capital_match = re.search(r"資本金\s*[:：]\s*([\d億万]+)", text)
    url_match = re.search(r"企業URL\s*[:：]\s*(https?://\S+)", text)

    employee = employee_match.group(1) if employee_match else "情報なし"
    capital = capital_match.group(1) if capital_match else "情報なし"
    company_url = url_match.group(1) if url_match else "情報なし"

    return {"従業員数": employee, "資本金": capital, "企業URL": company_url}


def main():
    exhibitor_list_url = "https://www.medtecjapanreg.com/exh2025/exhibitor_list.cgi"
    print("出展社一覧ページから情報を取得中…")
    exhibitors = fetch_exhibitor_list(exhibitor_list_url)
    print(f"{len(exhibitors)} 件の出展社が検出されました。")

    results = []
    # tqdmを利用して進捗状況を表示
    for exhibitor in tqdm(exhibitors, desc="詳細情報取得中", unit="社"):
        name = exhibitor.get("name", "情報なし")
        detail_url = exhibitor.get("detail_url")
        # 詳細ページが取得できる場合、詳細情報を抽出
        if detail_url:
            details = fetch_exhibitor_details(detail_url)
        else:
            details = {
                "従業員数": "情報なし",
                "資本金": "情報なし",
                "企業URL": "情報なし",
            }
        results.append(
            {
                "企業名": name,
                "従業員数": details["従業員数"],
                "資本金": details["資本金"],
                "企業URL": details["企業URL"],
            }
        )

    # 結果を表形式で表示
    print("\n| 企業名 | 従業員数 | 資本金 | 企業URL |")
    print("|---|---|---|---|")
    for row in results:
        print(
            f"| {row['企業名']} | {row['従業員数']} | {row['資本金']} | {row['企業URL']} |"
        )


if __name__ == "__main__":
    main()
