{{ config(materialized='table') }}

WITH source AS (
    SELECT 
        CUSTOMER_ID::INT AS customer_id,
        COUNTRY::VARCHAR(100) AS country,
        REGION::VARCHAR(100) AS region
    FROM {{ source('staging_layer', 'country_region') }}
),

deduplicated AS (
    SELECT DISTINCT * FROM source
),

cleaned AS (
    SELECT *
    FROM deduplicated
    WHERE country IS NOT NULL 
)

SELECT * FROM cleaned
