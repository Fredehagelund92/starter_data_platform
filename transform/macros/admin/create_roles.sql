{% macro create_roles(roles) %}

        {% for role in roles %}

            {%- call statement('get_roles', fetch_result=True) %}

                select
                    rolname
                from pg_catalog.pg_roles
                    where lower(rolname) = lower('{{role}}')

            {%- endcall -%}

            {%- set role_list = load_result('get_roles') -%}

            {%- if not role_list['data'] -%}
                create user {{ role }};
            {% else %}
                select 1; -- hooks will error if they don't have valid SQL in them, this handles that!
            {% endif %}

            commit;
        {% endfor %}
{% endmacro %}