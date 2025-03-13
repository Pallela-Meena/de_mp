{{ config(materialized='table') }}

WITH source AS (
    SELECT 
        COMPANY::VARCHAR(100) AS company,
        CUSTOMER_ID::INT AS customer_id,
        CUSTOMERNAME::VARCHAR(100) AS customer_name
    FROM {{ source('staging_layer', 'customers') }}
),

deduplicated AS (
    SELECT DISTINCT * FROM source
),

cleaned AS (
    SELECT *
    FROM deduplicated
    WHERE customer_id IS NOT NULL 
)

SELECT * FROM cleaned
