WITH product_sales AS (
    SELECT 
        t.product_id,
        p.product_family,
        p.product_sub_family,
        SUM(t.revenue) AS total_revenue,
        SUM(t.quantity) AS total_quantity
    FROM {{ ref('transactions') }} t
    LEFT JOIN {{ ref('products') }} p
        ON t.product_id = p.product_id
    GROUP BY t.product_id, p.product_family, p.product_sub_family
)
SELECT * FROM product_sales