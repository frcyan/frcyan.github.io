#!/bin/bash
set -e

echo "🏗 Building site with Jekyll..."
bundle exec jekyll build

echo "📂 Removing old archive folder and copying new archives..."
rm -rf 2025
cp -r _site/2025 ./2025
echo "✅ Archive folders copied."

echo "📥 Adding archive files to git..."
git add -A 2025

# Add any other changes as well
git add -A

# Commit and push only if there are changes
if git diff --cached --quiet; then
  echo "ℹ️ No changes to commit."
else
  git commit -m "Update site and archives"
  git push
  echo "🚀 Changes committed and pushed."
fi
