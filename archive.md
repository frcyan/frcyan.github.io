---
layout: base
title: Archive
---

<h1>Archive</h1>

<ul>
{% assign posts_by_month = site.posts | group_by_exp:"post", "post.date | date: '%Y-%m'" %}
{% for month_group in posts_by_month %}
  {% assign year = month_group.name | slice: 0,4 %}
  {% assign month = month_group.name | slice: 5,2 %}
  <li>
    <a href="/{{ year }}/{{ month }}/">{{ year }}-{{ month }}</a> ({{ month_group.items | size }} posts)
  </li>
{% endfor %}
</ul>
