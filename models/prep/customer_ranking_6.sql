


WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(total_revenue) AS total_revenue
    FROM {{ ref('customer_sales') }}
    GROUP BY customer_id
),
customer_ranking AS (
    SELECT
        c.customer_id,
        cs.region,
        c.total_revenue,
        cs.total_products_purchased,
        RANK() OVER (ORDER BY c.total_revenue) AS revenue_rank
    FROM customer_revenue c
    JOIN {{ ref('customer_sales') }} cs
        ON c.customer_id = cs.customer_id
)
SELECT * FROM customer_ranking
ORDER BY total_products_purchased DESC