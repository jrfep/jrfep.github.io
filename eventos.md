---
layout: default
title: Presentaciones en eventos
---

Lista de eventos científicos en los que he participado:
<ul>
{% for eventos in site.eventos %}
    <li>
      <a href="eventos/{{ eventos.code }}">{{ eventos.name }}</a>
      {{ eventos.lugar }}   {{ eventos.fini }}
    </li>
  {% endfor %}
</ul>
