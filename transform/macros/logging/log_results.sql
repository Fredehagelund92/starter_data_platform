{% macro unpack_results(results) %}

    {% for res in results -%}
            (
                '{{ invocation_id }}',
                '{{ res.status }}',
                {{ "'" ~ res.timing[1].started_at ~ "'"  if res.timing|length > 0 else 'NULL'  }},
                {{ "'" ~ res.timing[1].completed_at ~ "'" if res.timing|length > 0 else 'NULL' }},
                '{{ res.node.unique_id }}',
                {{ res.execution_time }},
                {{ res.adapter_response.rows_affected if 'rows_affected' in res.adapter_response else 'NULL' }},
                '{{ run_started_at }}',
                {{ "'" ~ res.message ~ "'" if res.status == 'error' else 'NULL' }}
            ){{ "," if not loop.last }}
    {% endfor %}

{% endmacro %}

{% macro log_results() %}


    {# {% do log(unpack_results(results) , info=true) %} #}

    insert into {{ get_result_log_table() }} (
        result_id,
        status,
        started_at,
        completed_at,
        unique_id,
        execution_time,
        rows_affected,
        run_started_at,
        message
    )
    values {{ unpack_results(results) }};

    commit;


{% endmacro %}


