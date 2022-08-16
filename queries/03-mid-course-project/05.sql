-- I'd like to tell the story of our website performance improvements over the course of the first 8 months. 
-- Could you pull session to order conversion rates, by month?

SELECT
    YEAR(ws.created_at) AS year
    , MONTH(ws.created_at) AS month
    , COUNT(DISTINCT ws.website_session_id) AS sessions
    , COUNT(DISTINCT orders.order_id) AS orders
    , COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT ws.website_session_id) AS orders
FROM website_sessions ws
LEFT JOIN orders ON orders.website_session_id = ws.website_session_id
WHERE ws.created_at < '2012-11-27'
GROUP BY 1,2