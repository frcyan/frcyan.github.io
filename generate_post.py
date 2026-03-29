from datetime import date
import os

POSTS_DIR = "_posts"

os.makedirs(POSTS_DIR, exist_ok=True)

# -----------------------
# Delete untouched template posts
# -----------------------
TEMPLATE_MARKER = "This is the automatically generated post for"

for filename in os.listdir(POSTS_DIR):
    filepath = os.path.join(POSTS_DIR, filename)

    if os.path.isfile(filepath) and filename.endswith(".md"):
        try:
            with open(filepath, "r", encoding="utf-8") as f:
                content = f.read()

            if TEMPLATE_MARKER in content:
                os.remove(filepath)
                print(f"Deleted untouched template post: {filename}")

        except Exception as e:
            print(f"Skipped {filename}: {e}")

# -----------------------
# Create today's post
# -----------------------
today = date.today()
filename = f"{POSTS_DIR}/{today.isoformat()}-daily-post.md"
title = today.strftime("%B %d, %Y")

if not os.path.exists(filename):
    with open(filename, "w", encoding="utf-8") as f:
        f.write(f"""---
layout: post
title: "Daily Post - {title}"
date: {today}
---

This is the automatically generated post for {title}.
""")
else:
    print(f"{filename} already exists.")