
{% macro log_event(event_name, schema, relation, user, target_name, is_full_refresh) %}

    insert into {{ get_event_log_table() }} (
        event_id,
        event_name,
        event_timestamp,
        event_schema,
        event_model,
        event_user,
        event_target,
        event_is_full_refresh
    )
    values (
        '{{ invocation_id }}',
        '{{ event_name }}',
        now() at time zone 'utc',
        {% if schema != None %} '{{ schema }}' {% else %} null::varchar(512){% endif %},
        {% if relation != None %} '{{ relation }}' {% else %} null::varchar(512){% endif %},
        {% if user != None %} '{{ user }}' {% else %} null::varchar(512){% endif %},
        {% if target_name != None %} '{{ target_name }}' {% else %} null::varchar(512){% endif %},
        {% if is_full_refresh %} TRUE {% else %} FALSE {% endif %}
    );

    commit;
{% endmacro %}



{% macro log_run_start_event() %}
    {{ log_event('run started', user=target.user, target_name=target.name, is_full_refresh=flags.FULL_REFRESH) }}
{% endmacro %}


{% macro log_run_end_event() %}
    {{
        log_event(
            'run completed',
            user=target.user,
            target_name=target.name,
            is_full_refresh=flags.FULL_REFRESH
        )
    }}
{% endmacro %}


{% macro log_model_start_event() %}
    {{ log_event(
        'model started', schema=this.schema, relation=this.name, user=target.user, target_name=target.name, is_full_refresh=flags.FULL_REFRESH
    ) }}
{% endmacro %}


{% macro log_model_end_event() %}
    {{ log_event(
        'model completed', schema=this.schema, relation=this.name, user=target.user, target_name=target.name, is_full_refresh=flags.FULL_REFRESH
    ) }}
{% endmacro %}

