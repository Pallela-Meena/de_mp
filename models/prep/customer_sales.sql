{{ config(materialized='table') }}
SELECT
    c.customer_id as customer_id,
    c.region as region, 
    SUM(t.revenue) AS total_revenue,
    COUNT(DISTINCT t.product_id) AS total_products_purchased
FROM {{ ref('country_region') }} c
LEFT JOIN {{ ref('transactions') }} t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.region