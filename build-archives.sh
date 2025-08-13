#!/bin/bash
set -euo pipefail

echo "🏗 Building site..."
bundle exec jekyll build

echo "📂 Refreshing ./archives from _site (non-destructive)..."
rm -rf archives
mkdir -p archives

for d in _site/[0-9][0-9][0-9][0-9]; do
  [ -d "$d" ] || continue
  year=$(basename "$d")
  echo "  copying $year"
  cp -r "$d" "archives/$year"
done

echo "📥 Staging archives only..."
git add -A archives

# also stage real source changes (posts, etc.)
git add -A _posts || true

if git diff --cached --quiet; then
  echo "ℹ️ No changes to commit."
else
  git commit -m "Update generated archives"
  git push
  echo "🚀 Updated archives pushed."
fi