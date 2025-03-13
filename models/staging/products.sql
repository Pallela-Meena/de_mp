{{ config(materialized='table') }}

WITH source AS (
    SELECT 
        PRODUCT_ID::VARCHAR(100) AS product_id,
        PRODUCT_FAMILY::VARCHAR(100) AS product_family,
        PRODUCT_SUB_FAMILY::VARCHAR(100) AS product_sub_family
    FROM {{ source('staging_layer', 'products') }}
),

deduplicated AS (
    SELECT DISTINCT * FROM source
),

cleaned AS (
    SELECT *
    FROM deduplicated
    WHERE product_id IS NOT NULL
)

SELECT * FROM cleaned
