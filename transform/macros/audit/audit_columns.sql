{%- macro audit_columns(model_created_by, model_updated_by, model_created_at, model_updated_at) -%}

      '{{ model_created_by }}'::VARCHAR       AS model_created_by,
      '{{ model_updated_by }}'::VARCHAR       AS model_updated_by,
      '{{ model_created_at }}'::DATE          AS model_created_at,
      '{{ model_updated_at }}'::DATE          AS model_updated_at,
      now() at time zone 'utc'                AS dbt_updated_at,
      now() at time zone 'utc'                AS dbt_created_at

{%- endmacro -%}
