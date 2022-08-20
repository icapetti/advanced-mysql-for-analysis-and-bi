-- For gsearch lander test, please estimate the revenue that test earned us 
-- (Hint: look at the increase in CVR from the test (Jun 19 - Jul 28), and 
-- use nonbrand sessions and revenue since then to calculate incremental value).

WITH first_test_views AS (
    SELECT
        wp.website_session_id
        , MIN(wp.website_pageview_id) AS min_pageview_id
    FROM
        website_pageviews wp
    INNER JOIN website_sessions ws
    ON ws.website_session_id = wp.website_session_id
    AND ws.created_at < '2012-07-28'
    AND wp.website_pageview_id >= 23504
    AND ws.utm_source = 'gsearch'
    AND ws.utm_campaign = 'nonbrand'
    GROUP BY wp.website_session_id
)
, nonbrand_test_sessions_w_landing_pages AS (
    SELECT
    ftv.website_session_id
    , wp.pageview_url AS landing_page
    FROM first_test_views ftv
    LEFT JOIN website_pageviews wp
    ON wp.website_pageview_id = ftv.min_pageview_id
    WHERE wp.pageview_url IN ('/home', '/lander-1')
)
, nonbrand_test_sessions_w_orders AS (
    SELECT
        nonbrand_sessions.website_session_id
        , nonbrand_sessions.landing_page
        , orders.order_id
    FROM nonbrand_test_sessions_w_landing_pages nonbrand_sessions
    LEFT JOIN orders ON orders.website_session_id = nonbrand_sessions.website_session_id
)
SELECT 
    landing_page
    , COUNT(DISTINCT website_session_id) AS sessions
    , COUNT(DISTINCT order_id) AS orders
    , COUNT(DISTINCT order_id)/COUNT(DISTINCT website_session_id) AS conv_rate
FROM nonbrand_test_sessions_w_orders
GROUP BY 1