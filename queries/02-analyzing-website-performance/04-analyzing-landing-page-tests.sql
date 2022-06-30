-- Step 0: find out when the new page /lander launched
-- Step 1: finding the first website_pageview_id for relevant sessions
-- Step 2: identifying the landing page of each session
-- Step 3: counting pageviews for each session, to identify "bounces"
-- Step 4: summarizing total sessions and bounced sessions, by LP

-- The result of this query will be used to limit the range of the analysis
-- SELECT 
--    MIN(created_at) AS first_created_at
--    , MIN(website_pageview_id) AS first_page_view
-- FROM website_pageviews
-- WHERE pageview_url = '/lander-1'
-- AND created_at IS NOT NULL

WITH first_test_pageviews AS (
    -- Get the first page view id for each session id (the min pageview_id associated with a session_id)
    -- Add range filters created_at and website_pageview_id
    SELECT 
        pv.website_session_id
        , MIN(pv.website_pageview_id) AS min_pageview_id
    FROM website_pageviews pv
        INNER JOIN website_sessions s 
        ON pv.website_session_id = s.website_session_id
        AND s.created_at < '2012-07-28'
        AND pv.website_pageview_id > 23504
        AND s.utm_source = 'gsearch'
        AND s.utm_campaign = 'nonbrand'
    GROUP BY 1
)
, nonbrand_test_sessions_w_landing_page AS (
-- Get the landing page for the min_pageview_id: in this example it can be /home or /lander-1
    SELECT 
        first_pv.website_session_id
        , pv2.pageview_url AS landing_page
    FROM first_test_pageviews first_pv
        LEFT JOIN website_pageviews pv2
        ON first_pv.min_pageview_id = pv2.website_pageview_id
    WHERE pv2.pageview_url IN ('/home', '/lander-1')
    
)
, nonbrand_test_bounced_sessions AS (
    -- For the session of the landing page, get the total number of pages viewed and bring the ones that have this count = 1:
    -- so, these are the bounced sessions, where the users saw just the /home page and exit the website or just saw /lander-1 and exit the website.
    SELECT 
        lp.website_session_id
        , lp.landing_page
        , COUNT(pv3.website_pageview_id) AS count_of_pages_viewed
    FROM nonbrand_test_sessions_w_landing_page lp
        LEFT JOIN website_pageviews pv3
        ON lp.website_session_id = pv3.website_session_id
    GROUP BY 1, 2
    HAVING COUNT(pv3.website_pageview_id) = 1
)
SELECT 
    lp2.landing_page
    , COUNT(DISTINCT lp2.website_session_id) AS sessions
    , COUNT(DISTINCT bs.website_session_id) AS bounced_sessions
    , COUNT(DISTINCT bs.website_session_id) / COUNT(DISTINCT lp2.website_session_id) AS bouce_rate
FROM nonbrand_test_sessions_w_landing_page lp2
    LEFT JOIN nonbrand_test_bounced_sessions bs
    ON lp2.website_session_id = bs.website_session_id
GROUP BY 1