-- While we're on Gsearch, could you dive into nobrand, and pull monthly sessions and orders split by device type? 
-- I want to flex out analytical muscles a little and show the board we really know our traffic sources.
SELECT 
    YEAR(ws.created_at) AS year
    , MONTH(ws.created_at) AS month
    , COUNT(DISTINCT CASE WHEN ws.device_type = 'desktop' THEN ws.website_session_id ELSE NULL END) AS desktop_sessions
    , COUNT(DISTINCT CASE WHEN ws.device_type = 'desktop' THEN o.website_session_id ELSE NULL END) AS desktop_orders
    , COUNT(DISTINCT CASE WHEN ws.device_type = 'mobile' THEN ws.website_session_id ELSE NULL END) AS mobile_sessions
    , COUNT(DISTINCT CASE WHEN ws.device_type = 'mobile' THEN o.website_session_id ELSE NULL END) AS mobile_orders
FROM website_sessions ws
LEFT JOIN orders o ON ws.website_session_id = o.website_session_id
WHERE ws.utm_source = 'gsearch'
AND ws.utm_campaign = 'nonbrand'
AND ws.created_at < '2012-11-27'
GROUP BY 1, 2
ORDER BY 1, 2