#!/bin/bash
set -euo pipefail

echo "🧹 Removing previously committed generated year folders (e.g. ./2025) and generated assets that cause conflicts..."
# remove root-level year folders like ./2023 ./2024 ./2025
for d in ./*/; do
  base=$(basename "$d")
  if [[ $base =~ ^[0-9]{4}$ ]]; then
    echo "  removing ./$(basename "$d")"
    rm -rf "./$base"
  fi
done

# remove generated CSS that conflicts with your SCSS (if you copied it earlier)
if [ -f assets/main.css ]; then
  echo "  removing assets/main.css"
  rm -f assets/main.css
fi

echo "🏗 Building site with Jekyll..."
bundle exec jekyll build

echo "📂 Copying freshly generated year folders from _site to repo root..."
for d in _site/*/; do
  base=$(basename "$d")
  if [[ $base =~ ^[0-9]{4}$ ]]; then
    echo "  copying $base"
    cp -r "_site/$base" "./$base"
  fi
done

echo "📥 Staging changes..."
git add -A

if git diff --cached --quiet; then
  echo "ℹ️ No changes to commit."
else
  git commit -m "Update generated archives"
  git push
  echo "🚀 Pushed updated archives."
fi