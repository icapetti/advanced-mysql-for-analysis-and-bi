-- When it comes trending analysis the keys are:
-- - DATE functions (MONTH, YEAR, WEEK) used with
-- - Aggregation functions (COUNT, SUM)
-- - GROUP BY clauses

-- Before the assigment solution, one example of the using of DATE functions:
-- I want see the aggregation of sessions by year and week, showing the start date of the week
SELECT 
    YEAR(created_at) AS Year
    , WEEK(created_at) AS Week
    , MIN(DATE(created_at)) AS week_start
    , COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
GROUP BY 1,2

-- Pivot table
-- Let's say we need to see the count of orders with 1 item and the orders with 2 items by product
-- that is, count the orders of product X that has 1 item, that has 2 itens and the total of orders for product X
SELECT 
    primary_product_id
    , COUNT(DISTINCT CASE WHEN items_purchased = 1 THEN order_id ELSE NULL END) AS orders_w_1_item
    , COUNT(DISTINCT CASE WHEN items_purchased = 2 THEN order_id ELSE NULL END) AS orders_w_2_items
    , COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY 1

-- Assignment solution
SELECT 
    MIN(DATE(created_at)) AS week_start_date
    , COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-05-10'
AND utm_source = 'gsearch'
AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at)
ORDER BY WEEK(created_at) ASC
