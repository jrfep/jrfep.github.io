---
layout: default
title: Presentaciones en eventos
---

Lista de eventos científicos en los que he participado:
<ul>
{% for eventos in site.eventos %}
    <li>
      <h2><a href="eventos/{{ eventos.code }}.html">{{ eventos.name }}</a></h2>
    </li>
  {% endfor %}
</ul>
