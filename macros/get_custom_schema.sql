{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if target.name in ['prod'] -%}
        {%- if custom_schema_name is none -%}
            {{ target.schema }}
        {%- else -%}
            {{ custom_schema_name }}
        {%- endif -%}
    {%- elif target.name in ['default'] -%}
        {{ exceptions.raise_compiler_error('Invalid target name "' ~ target.name ~ '". Please change this to "prod" in Production.') }}
    {%- elif custom_schema_name is none -%}
        {{ target.name }}_{{ target.schema }}
    {%- else -%}
        {{ target.name }}_{{ custom_schema_name }}
    {%- endif -%}
{%- endmacro %}