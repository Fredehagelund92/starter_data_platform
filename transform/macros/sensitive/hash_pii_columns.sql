{% macro hash_pii_columns(source_table) %}

    {% set meta_columns = get_meta_columns(source_table, meta_key="contains_pii") %}

    {%- for column in meta_columns %}

        {{ hash_pii_column(column, salt=True) }}

    {% endfor %}

    {{ dbt_utils.star(from=ref(source_table), except=meta_columns) }}

{% endmacro %}
