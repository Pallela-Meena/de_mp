{{ config(materialized='table') }}

WITH source AS (
    SELECT 
        CUSTOMER_ID::INT AS customer_id,
        PRODUCT_ID::VARCHAR(100) AS product_id,
        {{ convert_to_date('PAYMENT_MONTH') }} AS payment_month,
        REVENUE_TYPE::INT AS revenue_type,
        REVENUE::FLOAT AS revenue,
        QUANTITY::INT AS quantity,
        DIMENSION_1::VARCHAR(100) AS dimension_1,
        DIMENSION_2::VARCHAR(100) AS dimension_2,
        DIMENSION_3::VARCHAR(100) AS dimension_3,
        DIMENSION_4::VARCHAR(100) AS dimension_4,
        DIMENSION_5::VARCHAR(100) AS dimension_5,
        DIMENSION_6::VARCHAR(100) AS dimension_6,
        DIMENSION_7::VARCHAR(100) AS dimension_7,
        DIMENSION_8::VARCHAR(100) AS dimension_8,
        DIMENSION_9::VARCHAR(100) AS dimension_9,
        DIMENSION_10::VARCHAR(100) AS dimension_10,
        COMPANIES::VARCHAR(100) AS companies
    FROM {{ source('staging_layer', 'transactions') }}
),

deduplicated AS (
    SELECT DISTINCT * FROM source
),

cleaned AS (
    SELECT *
    FROM deduplicated
    WHERE customer_id IS NOT NULL 
      AND product_id IS NOT NULL 
)

SELECT * FROM cleaned
