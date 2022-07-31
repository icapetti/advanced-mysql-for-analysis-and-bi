-- 1: find th first website_pageview_id for relevant sessions (relevant sessions are...)
-- 2: identify the landing page of each session
-- 3: count pageviews for each session, to identify "bounces"
-- 4: summarize by week (bounce rate, sessions to each lander)

WITH sessions_w_min_pv_id_and_view_count AS (
    SELECT
        ws.website_session_id
        , MIN(wpv.website_pageview_id) AS first_pageview_id
        , COUNT(wpv.website_pageview_id) AS count_pageviews
    FROM
        website_sessions ws
    LEFT JOIN website_pageviews AS wpv ON ws.website_session_id = wpv.website_session_id
    WHERE ws.created_at > '2012-06-01' -- as asked by requestor
        AND ws.created_at < '2012-08-31' -- as prescribed by assignment date
        AND ws.utm_source = 'gsearch'
        AND ws.utm_campaign = 'nonbrand'
    GROUP BY ws.website_session_id
)
, sessions_w_counts_lander_and_created_at AS (
    SELECT
        sessions_count.website_session_id
        , sessions_count.first_pageview_id
        , sessions_count.count_pageviews
        , wpv.pageview_url AS landing_page
        , wpv.created_at AS session_created_at
    FROM
        sessions_w_min_pv_id_and_view_count sessions_count
    LEFT JOIN website_pageviews AS wpv ON sessions_count.first_pageview_id = wpv.website_pageview_id
)
SELECT 
    MIN(DATE(session_created_at)) AS week_start_date
    , COUNT(DISTINCT CASE WHEN count_pageviews = 1 THEN website_session_id ELSE NULL END)*1.0/COUNT(DISTINCT website_session_id) AS bounce_rate
    , COUNT(DISTINCT CASE WHEN landing_page = '/home' THEN website_session_id ELSE NULL END) AS home_sessions
    , COUNT(DISTINCT CASE WHEN landing_page = '/lander-1' THEN website_session_id ELSE NULL END) AS lander_sessions
FROM sessions_w_counts_lander_and_created_at
GROUP BY YEARWEEK(session_created_at)