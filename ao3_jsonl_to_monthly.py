
import json
import csv
from collections import Counter
from pathlib import Path

input_file = Path("/Users/mumi/Documents/AO3 Project/combined_metadata.jsonl")
output_file = Path("/Users/mumi/Documents/AO3 Project/ao3_monthly_jsonl.csv")

print("Checking input file...")

if not input_file.exists():
    print(f"Input file not found: {input_file}")
else:
    print(f"Input file found: {input_file}")
    monthly_counts = Counter()

    print("Reading JSONL file.")

    with input_file.open("r", encoding="utf-8") as f:
        for line_number, line in enumerate(f, start=1):
            if not line.strip():
                continue

            try:
                work = json.loads(line)
            except json.JSONDecodeError:
                print(f"Skipping invalid JSON on line {line_number}")
                continue

            published = work.get("metadata", {}).get("published")

            if published and len(published) >= 10:
                month = published[:7]

                if "2022-04" <= month <= "2025-02":
                    monthly_counts[month] += 1

            if line_number % 1_000_000 == 0:
                print(f"Processed {line_number:,} lines...")

    print("Finished reading file.")
    print(f"Months found: {len(monthly_counts)}")

    with output_file.open("w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["month", "new_works"])

        for month in sorted(monthly_counts):
            writer.writerow([month, monthly_counts[month]])

    print(f"Output file saved to:\n{output_file}")
    print(f"File exists: {output_file.exists()}")
