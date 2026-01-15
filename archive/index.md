---
layout: default
title: Archive
---

<ul>
  {% assign years = site.posts | group_by_exp:"post","post.date | date: '%Y'" %}
  {% for year in years %}
    <li>
      <strong>{{ year.name }}</strong>
      <ul>
        {% assign months = year.items | group_by_exp:"post","post.date | date: '%m'" %}
        {% for month in months %}
          <li>
            <a href="/{{ year.name }}/{{ month.name }}/">
              {{ year.name }}-{{ month.name }}
            </a>
            ({{ month.items | size }})
          </li>
        {% endfor %}
      </ul>
    </li>
  {% endfor %}
</ul>
