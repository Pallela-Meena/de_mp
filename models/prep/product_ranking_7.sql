WITH product_ranking AS (
    SELECT
        product_id,
        product_family,
        product_sub_family,
        total_revenue,
        total_quantity,
        RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
    FROM {{ ref('product_sales') }}
SELECT * FROM product_ranking