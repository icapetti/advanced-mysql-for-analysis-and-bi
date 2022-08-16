-- Can you pull monthly trends for Gsearch, alongside monthly trends for each of other channels?

SELECT
    YEAR(ws.created_at) AS year
    , MONTH(ws.created_at) AS month
    , COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' THEN ws.website_session_id ELSE NULL END) AS gsearch_paid_sessions
    , COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' THEN ws.website_session_id ELSE NULL END) AS bsearch_paid_sessions
    , COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN ws.website_session_id ELSE NULL END) AS organic_search_sessions
    , COUNT(DISTINCT CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN ws.website_session_id ELSE NULL END) AS direct_type_in_sessions
FROM website_sessions ws
LEFT JOIN orders ON orders.website_session_id = ws.website_session_id
WHERE ws.created_at < '2012-11-27'
GROUP BY 1,2