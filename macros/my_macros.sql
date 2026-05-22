{%macro usd_eur (col, scale=2)%}
   ({{ col }} * 0.86)::numeric(8, {{ scale }})
{% endmacro %}