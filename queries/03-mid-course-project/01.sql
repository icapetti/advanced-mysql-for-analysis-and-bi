-- Gsearch seems to be the biggest driver of our business. 
-- Could you pull monthly trends for gsearch sessions and orders so that we can showcase the growth there?

SELECT 
    YEAR(ws.created_at) AS year
    , MONTH(ws.created_at) AS month
    , COUNT(DISTINCT ws.website_session_id) AS sessions
    , COUNT(DISTINCT o.order_id) AS orders
    , COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id) AS conv_rate
FROM website_sessions ws
LEFT JOIN orders o ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch'
AND ws.created_at < '2012-11-27'
GROUP BY 1, 2
ORDER BY 1, 2