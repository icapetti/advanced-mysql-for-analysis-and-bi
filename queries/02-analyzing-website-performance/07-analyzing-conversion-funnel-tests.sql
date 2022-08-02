WITH billing_sessions_w_orders AS (
    SELECT
        wpv.website_session_id
        , wpv.pageview_url AS billing_version_seen
        , orders.order_id
    FROM 
        website_pageviews wpv
    LEFT JOIN 
        orders ON orders.website_session_id = wpv.website_session_id
    WHERE 
        wpv.website_pageview_id >= 53550 -- first pageview_id where test was live
        AND wpv.created_at < '2012-11-10' -- time of assigment
        AND wpv.pageview_url IN ('/billing', '/billing-2')
)
SELECT 
    billing_version_seen
    , COUNT(DISTINCT website_session_id) AS sessions
    , COUNT(DISTINCT order_id) AS orders
    , COUNT(DISTINCT order_id)/COUNT(DISTINCT website_session_id) AS billing_to_order_rt
FROM 
    billing_sessions_w_orders
GROUP BY 
    billing_version_seen