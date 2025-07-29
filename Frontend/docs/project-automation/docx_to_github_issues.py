import docx
import requests
import os

# CONFIG
GITHUB_REPO = "Amarsalim30/stocktrackpro"
GITHUB_TOKEN = os.getenv("GH_TOKEN")  # Save as environment variable GH_TOKEN
PROJECT_NUMBER = 9
DOCX_FILE = "rtm_stocktrackpro.docx"
GITHUB_API = "https://api.github.com"

# HEADERS
headers = {
    "Authorization": f"Bearer {GITHUB_TOKEN}",
    "Accept": "application/vnd.github+json"
}

def read_docx_table(path):
    doc = docx.Document(path)
    issues = []

    for row in doc.tables[0].rows[1:]:  # skip header row
        cells = [cell.text.strip() for cell in row.cells]
        issue = {
            "id": cells[0],
            "title": cells[1],
            "description": cells[2],
            "labels": [l.strip() for l in cells[7].split(',')],
            "status": cells[8],
            "iteration": cells[9]
        }
        issues.append(issue)
    return issues

def issue_exists(title):
    search_url = f"{GITHUB_API}/search/issues?q=repo:{GITHUB_REPO}+in:title+\"{title}\""
    response = requests.get(search_url, headers=headers)
    if response.status_code == 200:
        return response.json().get("total_count", 0) > 0
    return False

def create_issue(issue):
    title = f"{issue['id']}: {issue['title']}"
    if issue_exists(title):
        print(f"✅ Skipping (already exists): {title}")
        return

    body = f"**Requirement ID**: {issue['id']}\n\n**Description**:\n{issue['description']}"
    data = {
        "title": title,
        "body": body,
        "labels": issue["labels"]
    }

    print(f"🚀 Creating: {title}")
    response = requests.post(f"{GITHUB_API}/repos/{GITHUB_REPO}/issues", headers=headers, json=data)
    if response.status_code == 201:
        print(f"✅ Created issue #{response.json()['number']}")
    else:
        print(f"❌ Failed to create issue: {response.status_code}, {response.text}")

def main():
    issues = read_docx_table(DOCX_FILE)
    for issue in issues:
        create_issue(issue)

if __name__ == "__main__":
    main()
# This script reads a DOCX file containing requirements and creates GitHub issues for each requirement.
# Ensure you have the required libraries installed: `pip install python-docx requests`