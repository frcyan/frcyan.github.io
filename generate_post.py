from datetime import date
import os

# Create _posts directory if it doesn't exist
os.makedirs("_posts", exist_ok=True)

today = date.today()
filename = f"_posts/{today.isoformat()}-daily-post.md"
title = today.strftime("%B %d, %Y")

if not os.path.exists(filename):  # Prevent duplicate creation
    with open(filename, "w") as f:
        f.write(f"""---
layout: post
title: "Daily Post - {title}"
date: {today}
---

This is the automatically generated post for {title}.
""")
else:
    print(f"{filename} already exists.")
