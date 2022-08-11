-- Next, it would be great to se a similar monthly trend for Gsearch, but this time splitting out nonbrand and brand campaigns separately. 
SELECT 
    YEAR(ws.created_at) AS year
    , MONTH(ws.created_at) AS month
    , COUNT(DISTINCT CASE WHEN ws.utm_campaign = 'nonbrand' THEN ws.website_session_id ELSE NULL END) AS nonbrand_sessions
    , COUNT(DISTINCT CASE WHEN ws.utm_campaign = 'nonbrand' THEN o.website_session_id ELSE NULL END) AS nonbrand_orders
    , COUNT(DISTINCT CASE WHEN ws.utm_campaign = 'brand' THEN ws.website_session_id ELSE NULL END) AS brand_sessions
    , COUNT(DISTINCT CASE WHEN ws.utm_campaign = 'brand' THEN o.website_session_id ELSE NULL END) AS brand_orders
FROM website_sessions ws
LEFT JOIN orders o ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch'
AND ws.created_at < '2012-11-27'
GROUP BY 1, 2
ORDER BY 1, 2