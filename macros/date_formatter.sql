{% macro convert_to_date(column_name) %}
    CASE 
        WHEN TRY_TO_DATE({{ column_name }}, 'YYYY-MM-DD') IS NOT NULL 
            THEN TRY_TO_DATE({{ column_name }}, 'YYYY-MM-DD')
        WHEN TRY_TO_DATE({{ column_name }}, 'MM/DD/YYYY') IS NOT NULL 
            THEN TRY_TO_DATE({{ column_name }}, 'MM/DD/YYYY')
        WHEN TRY_TO_DATE({{ column_name }}, 'DD-MM-YYYY') IS NOT NULL 
            THEN TRY_TO_DATE({{ column_name }}, 'DD-MM-YYYY')
        ELSE NULL 
    END
{% endmacro %}
