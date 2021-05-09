{% macro get_logging_schema() %}

    {%- set default_schema = target.schema -%}
    {%- set new_schema = default_schema  ~ '_' ~ 'logging' | trim -%}

    {{ return(new_schema) }}

{% endmacro %}

{% macro get_event_log_table() %}


    {%- set log_schema=get_logging_schema() -%}

    {%- set event_log_table =
        api.Relation.create(
            database=target.database,
            schema=log_schema,
            identifier='dbt_event_log',
            type='table'
        ) -%}

    {{ return(event_log_table) }}

{% endmacro %}

{% macro get_result_log_table() %}


    {%- set log_schema=get_logging_schema() -%}

    {%- set result_log_table =
        api.Relation.create(
            database=target.database,
            schema=log_schema,
            identifier='dbt_result_log',
            type='table'
        ) -%}

    {{ return(result_log_table) }}

{% endmacro %}



{% macro create_logging_schema() %}

   {% do adapter.create_schema(api.Relation.create(
        database=target.database,
        schema=get_logging_schema())
    ) %}

{% endmacro %}

{% macro create_event_log_table() %}

    {% set required_columns = [
       ["event_id", "varchar"],
       ["event_name", "varchar"],
       ["event_timestamp", "timestamp"],
       ["event_schema", "varchar"],
       ["event_model", "varchar"],
       ["event_user", "varchar"],
       ["event_target", "varchar"],
       ["event_is_full_refresh", "boolean"],
    ] -%}

    {%- set table_relation=get_event_log_table() -%}

    {% do run_query(create_or_update_table(table_relation, required_columns)) %}

{% endmacro %}


{% macro create_result_log_table() %}

    {% set required_columns = [
       ["result_id", "varchar"],
       ["status", "varchar"],
       ["started_at", "timestamp"],
       ["completed_at", "timestamp"],
       ["unique_id", "varchar"],
       ["execution_time", "integer"],
       ["rows_affected", "integer"],
       ["run_started_at", "timestamp"],
       ["message", "varchar"],
    ] -%}

    {%- set table_relation=get_result_log_table() -%}

    {% do run_query(create_or_update_table(table_relation, required_columns)) %}

{% endmacro %}



{% macro setup_logging() %}



    {# Create logging schema #}
    {% do create_logging_schema() %}


   {# Create logging tables #}
   {% do create_event_log_table() %}
   {% do create_result_log_table() %}




{% endmacro %}
