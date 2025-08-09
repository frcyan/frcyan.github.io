#!/bin/bash
set -e

echo "🏗 Building site with Jekyll..."
bundle exec jekyll build

echo "📂 Copying archive folders..."
# Copy archive folders from _site/YYYY/MM to repo root
find _site -type d -regex "_site/[0-9]{4}/[0-9]{2}" | while read dir; do
    mkdir -p "${dir#_site/}"
    cp -r "$dir"/* "${dir#_site/}"
done

echo "✅ Archive folders copied."

# Force add archive folders in case of .gitignore issues or untracked files
echo "📥 Adding archive folders to git..."
git add -f $(find . -type d -regex "./[0-9]{4}/[0-9]{2}")

# Also add any other changes like new posts or updates
git add .

# Commit if there are any changes
if git diff --cached --quiet; then
  echo "ℹ️ No changes to commit."
else
  git commit -m "Update site and archives"
  git push
  echo "🚀 Changes committed and pushed."
fi
