---
layout: default
title: Presentaciones en eventos
---

Lista de eventos científicos en los que he participado:
<ul>
{% for EFG in site.EFGs %}
    <li>
      <h2><a href="eventos/{{ eventos.code }}">{{ eventos.name }}</a></h2>
    </li>
  {% endfor %}
</ul>
