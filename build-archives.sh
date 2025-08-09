#!/bin/bash

# Exit if any command fails
set -e

echo "🏗 Building site with Jekyll..."
bundle exec jekyll build

echo "📂 Copying archive folders..."
# Find all _site/year/month folders and copy to repo
find _site -type d -regex "_site/[0-9]{4}/[0-9]{2}" | while read dir; do
    mkdir -p "${dir#_site/}"
    cp -r "$dir"/* "${dir#_site/}"
done

echo "✅ Archive folders copied."

# Optional: commit and push
git add .
git commit -m "Update site and archives" || echo "No changes to commit."
git push

echo "🚀 Done."
