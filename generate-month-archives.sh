#!/usr/bin/env bash
set -euo pipefail

echo "📅 Generating month archive source pages..."

# Find unique year-month pairs from posts
months=$(
  ls _posts \
  | sed -E 's/^([0-9]{4})-([0-9]{2})-.*/\1 \2/' \
  | sort -u
)

for ym in $months; do
  year=$(echo "$ym" | cut -d' ' -f1)
  month=$(echo "$ym" | cut -d' ' -f2)

  dir="$year/$month"
  file="$dir/index.md"

  mkdir -p "$dir"

  if [[ -f "$file" ]]; then
    echo "↪️  Exists: $file"
    continue
  fi

  cat > "$file" <<EOF
---
layout: month
year: "$year"
month: "$month"
---
EOF

  echo "✅ Created $file"
done

echo "🎉 Month archive pages generated."
