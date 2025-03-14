WITH first_purchase AS (
    SELECT 
        t.customer_id,
        MIN(t.payment_month) AS first_purchase_date
    FROM {{ ref('transactions') }} t
    GROUP BY t.customer_id
),
new_logos AS (
    SELECT
        EXTRACT(YEAR FROM first_purchase_date) AS fiscal_year,
        COUNT(DISTINCT customer_id) AS new_customers
    FROM first_purchase
    GROUP BY fiscal_year
)
SELECT * FROM new_logos ORDER BY fiscal_year