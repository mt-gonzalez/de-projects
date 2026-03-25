-- Macro to avoid concatenation of schemas in dbt-project schema definition for models

{% macro generate_schema_name(custom_schema_name, node) %}
    {{ custom_schema_name }}
{% endmacro %}