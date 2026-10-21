import sqlite3
import csv
from pathlib import Path

project_folder = Path("/Users/mumi/Documents/AO3 Project")
database_file = project_folder / "ao3_project.db"
output_file = project_folder / "ao3_monthly_with_growth.csv"

connection = sqlite3.connect(database_file)

query = """
SELECT month, new_works, source
FROM ao3_monthly_master
ORDER BY month ASC;
"""

rows = connection.execute(query).fetchall()
connection.close()

results = []
previous_works = None

for month, new_works, source in rows:

    growth_rate = None

    if (
        new_works is not None
        and previous_works is not None
        and previous_works > 0
    ):
        growth_rate = (
            (new_works - previous_works)
            / previous_works
        ) * 100

    results.append([
        month,
        new_works,
        growth_rate,
        source
    ])
    previous_works = new_works

with output_file.open("w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)

    writer.writerow([
        "month",
        "new_works",
        "growth_rate_pct",
        "source"
    ])

    for row in results:
        writer.writerow(row)

print("Calculation complete")
print(f"Total months: {len(results)}")
print(f"Output saved to: {output_file}")
print(f"File exists: {output_file.exists()}")
