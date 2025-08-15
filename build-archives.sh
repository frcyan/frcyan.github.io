#!/bin/bash
set -e

YEAR=$(date +"%Y")

echo "🏗 Building site with Jekyll..."
bundle exec jekyll build

echo "📂 Updating archive folders for $YEAR..."
mkdir -p "./$YEAR"

# Copy all months from _site
for month_dir in _site/$YEAR/*/; do
    month=$(basename "$month_dir")
    mkdir -p "./$YEAR/$month"
    cp -r "$month_dir"/* "./$YEAR/$month/"
done

echo "✅ Archives for $YEAR updated."

echo "📥 Adding archive files to git..."
git add -f "$YEAR"

# Add any other changes as well
git add .

# Commit and push only if there are changes
if git diff --cached --quiet; then
  echo "ℹ️ No changes to commit."
else
  git commit -m "Update archives for $YEAR"
  git push
  echo "🚀 Changes committed and pushed."
fi