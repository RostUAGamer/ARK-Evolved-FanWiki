#!/usr/bin/env python3
"""
Скрипт перевірки та оновлення посилань на зображення динозаврів у проекті ARK Evolved FanWiki.
Перевіряє доступність кожного URL, слідує за редіректами (301/302), перевіряє Content-Type
та оновлює застарілі URL на актуальні в коді lib/data/.
"""

import os
import re
import sys
import urllib.request
import urllib.error

USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

FILES_TO_CHECK = [
    "lib/data/dino_database.dart",
    "lib/data/breeding_database.dart",
]

def check_url(url):
    """Перевіряє URL, повертає (is_valid, final_url, status_code, content_type)"""
    try:
        req = urllib.request.Request(
            url,
            headers={
                "User-Agent": USER_AGENT,
                "Accept": "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8",
            }
        )
        with urllib.request.urlopen(req, timeout=15) as response:
            final_url = response.geturl()
            status_code = response.getcode()
            content_type = response.headers.get("Content-Type", "")
            is_image = "image" in content_type or final_url.endswith((".png", ".jpg", ".jpeg", ".webp", ".gif"))
            is_valid = (status_code == 200) and is_image
            return is_valid, final_url, status_code, content_type
    except urllib.error.HTTPError as e:
        return False, url, e.code, str(e.headers)
    except Exception as e:
        return False, url, 0, str(e)

def process_file(filepath):
    print(f"\n📂 Обробка файлу: {filepath}")
    if not os.path.exists(filepath):
        print(f"⚠️ Файл не знайдено: {filepath}")
        return 0, []

    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    # Пошук усіх imageUrl та backupImageUrl
    pattern = r"(imageUrl|backupImageUrl):\s*'([^']+)'"
    matches = list(re.finditer(pattern, content))
    print(f"🔍 Знайдено {len(matches)} посилань на зображення.")

    replacements = 0
    report_rows = []

    for match in matches:
        field_name = match.group(1)
        original_url = match.group(2)
        print(f"   Перевірка [{field_name}]: {original_url} ...", end=" ", flush=True)

        is_valid, final_url, status_code, content_type = check_url(original_url)

        if is_valid:
            print(f"✅ OK ({status_code}, {content_type.split(';')[0]})")
            # Якщо URL було редіректнуто (наприклад, з /4/42/Dossier_Rex.png на /Dossier_Rex.png)
            if final_url != original_url and "wiki.gg" in final_url:
                print(f"   🔄 Оновлення URL -> {final_url}")
                content = content.replace(f"'{original_url}'", f"'{final_url}'")
                replacements += 1
                report_rows.append((field_name, original_url, final_url, "Оновлено на прямий URL", "✅"))
            else:
                report_rows.append((field_name, original_url, final_url, "Доступний та валідний", "✅"))
        else:
            print(f"❌ ПОМИЛКА ({status_code})")
            report_rows.append((field_name, original_url, final_url, f"Помилка статусу: {status_code}", "❌"))

    if replacements > 0:
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"💾 Збережено зміни: {replacements} посилань оновлено в {filepath}")
    else:
        print(f"✨ Усі посилання в {filepath} актуальні, змін не потрібно.")

    return replacements, report_rows

def main():
    print("=" * 60)
    print("🦖 АВТОМАТИЧНА ПЕРЕВІРКА ТА ОНОВЛЕННЯ ЗОБРАЖЕНЬ ДИНОЗАВРІВ")
    print("=" * 60)

    total_replacements = 0
    all_reports = []

    for filepath in FILES_TO_CHECK:
        reps, reports = process_file(filepath)
        total_replacements += reps
        all_reports.extend(reports)

    # Генерація Markdown звіту для GitHub Summary
    report_md = "## 🦖 Звіт перевірки та оновлення зображень динозаврів\n\n"
    report_md += "| Статус | Поле | Оригінальний URL | Актуальний URL | Результат |\n"
    report_md += "|:---:|:---|:---|:---|:---|\n"
    for field, orig, final, note, status in all_reports:
        orig_short = orig.split("/")[-1]
        final_short = final.split("/")[-1]
        report_md += f"| {status} | `{field}` | `{orig_short}` | `{final_short}` | {note} |\n"

    report_md += f"\n\n**Загалом оновлено посилань:** {total_replacements}\n"

    step_summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
    if step_summary_path:
        with open(step_summary_path, "a", encoding="utf-8") as f:
            f.write(report_md)
        print("\n📊 Звіт додано до GITHUB_STEP_SUMMARY.")

    print("\n" + "=" * 60)
    print(f"🏁 Завершено! Усього оновлено посилань: {total_replacements}")
    print("=" * 60)

if __name__ == "__main__":
    main()
