{% macro create_or_update_table(table_relation, columns) %}

    {% set table_exists = adapter.get_relation(table_relation.database, table_relation.schema, table_relation.name) -%}

    {% if table_exists -%}


        {%- set columns_to_create = [] -%}

        {%- set existing_columns = adapter.get_columns_in_relation(table_relation)|map(attribute='column')|list -%}

        {%- for required_column in columns -%}
            {%- if required_column[0] not in existing_columns -%}
                {%- do columns_to_create.append(required_column) -%}
            {%- endif -%}
        {%- endfor -%}

        {%- for column in columns_to_create -%}
            alter table {{ table_relation }}
            add column {{ column[0] }} {{ column[1] }}
            default null;
        {% endfor -%}

        {%- set required_columns = [] -%}
        {%- for required_column in columns -%}
            {%- do required_columns.append(required_column[0]) -%}
        {%- endfor -%}


        {%- set columns_to_delete = [] -%}
        {%- for existing_column in existing_columns -%}
            {%- if existing_column not in required_columns -%}
                {%- do columns_to_delete.append(existing_column) -%}
            {%- endif -%}
 
        {%- endfor -%}

        {%- for column in columns_to_delete -%}
            alter table {{ table_relation }} drop column {{ column }};
        {% endfor -%}



        {%- if columns_to_create|length > 0 or columns_to_delete|length > 0 %}
            commit;
        {% else -%}
            select 1
        {% endif -%}


    {%- else -%}
        create table {{ table_relation }}
        (
        {% for column in columns %}
            {{ column[0] }} {{ column[1] }}{% if not loop.last %},{% endif %}
        {% endfor %}
        );
        commit;

    {%- endif -%}
{% endmacro %}
