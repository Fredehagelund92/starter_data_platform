
{% macro grant_delete_on_schemas(schemas, role) %}
  {% for schema in schemas %}
    grant usage on schema {{ schema }} to group {{ role }};
    grant delete on all tables in schema {{ schema }} to group {{ role }};
    grant delete on all views in schema {{ schema }} to group {{ role }};
  {% endfor %}
{% endmacro %}


{% macro grant_insert_on_schemas(schemas, role) %}
  {% for schema in schemas %}
    grant usage on schema {{ schema }} to group {{ role }};
    grant insert on all tables in schema {{ schema }} to group {{ role }};
  {% endfor %}
{% endmacro %}


{% macro grant_select_on_schemas(schemas, role) %}
  {% for schema in schemas %}
    grant usage on schema {{ schema }} to group {{ role }};
    grant select on all tables in schema {{ schema }} to group {{ role }};
  {% endfor %}
{% endmacro %}


{% macro grant_update_on_schemas(schemas, role) %}
  {% for schema in schemas %}
    grant usage on schema {{ schema }} to group {{ role }};
    grant update on all tables in schema {{ schema }} to group {{ role }};
  {% endfor %}
{% endmacro %}



{% macro grant_permissions(schemas, permissions, role) %}

    {% for permission in permissions %}

        {%- if permission == 'update' -%}
            {{ grant_update_on_schemas(schemas, role) }}
        {%- endif -%}

        {%- if permission == 'insert' -%}
            {{ grant_insert_on_schemas(schemas, role) }}
        {%- endif -%}

        {%- if permission == 'delete' -%}
            {{ grant_delete_on_schemas(schemas, role) }}
        {%- endif -%}

        {%- if permission == 'select' -%}
            {{ grant_select_on_schemas(schemas, role) }}
        {%- endif -%}

    {% endfor %}



{% endmacro %}