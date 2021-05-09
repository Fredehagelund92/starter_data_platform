{% macro hash_column(column, salt=False) %}
    {% if salt %}

        MD5(
            TRIM(
                LOWER(
                    {{column|lower}} || '{{ get_salt(column|lower) }}'
                )
            )
        ) AS {{column|lower}}_hash,

    {% else %}
        MD5(
            TRIM(
                LOWER(
                    {{column|lower}}
                )
            )
        ) AS {{column|lower}}_hash,

    {% endif %}




{% endmacro %}
