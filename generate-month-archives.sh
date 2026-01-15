#!/usr/bin/env bash
set -euo pipefail

echo "Generating month archive pages..."

# Loop over all posts
for post_file in _posts/*.md; do
  # Extract year and month from filename: 2025-08-18-title.md
  filename=$(basename "$post_file")
  year=${filename:0:4}
  month=${filename:5:2}

  # Create correct folder path: YYYY/MM
  dir="$year/$month"
  file="$dir/index.md"

  mkdir -p "$dir"

  # Only create index.md if it doesn't exist
  if [ ! -f "$file" ]; then
    cat > "$file" <<EOF
---
layout: month
year: "$year"
month: "$month"
---
EOF
    echo "Created $file"
  fi
done

echo "Month archive pages ready."
