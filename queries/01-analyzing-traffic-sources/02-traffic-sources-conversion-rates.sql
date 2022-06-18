-- Since we want all in table websessions and just the matches from the table orders, we use a LEFT JOIN
-- to get the CVR.
SELECT 
    COUNT(DISTINCT s.website_session_id) AS sessions
    , COUNT(DISTINCT o.order_id) AS orders
    , (COUNT(DISTINCT o.order_id) / COUNT(DISTINCT s.website_session_id))*100 AS session_to_order_conv_rate
FROM  website_sessions s
LEFT JOIN orders o
ON s.website_session_id = o.website_session_id
WHERE s.created_at < '2012-04-14'
AND s.utm_source = 'gsearch'
AND s.utm_campaign = 'nonbrand'