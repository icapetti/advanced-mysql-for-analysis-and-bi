-- Calculating bounce rates
-- Step 1: finding the first website_pageview_id for relevant sessions
-- Step 2: identifying the landing page of each session
-- Step 3: counting pageviews for each session. to identify "bounces"
-- Step 4: summarizing by counting total sessions and bounced sessions

WITH first_pageviews AS (
-- Get the first page view id for each session id.
    SELECT 
        website_session_id
        , MIN(website_pageview_id) AS min_pageview_id
    FROM website_pageviews
    WHERE created_at < '2012-06-14'
    GROUP BY 1
)
, sessions_w_home_landing_page AS (
-- Get the landing page for the min_pageview_id (Redundant here, as we will filter by /home, 
-- but it serves the purpose of the exercise.)
    SELECT 
        fp.website_session_id
        , wpv.pageview_url AS landing_page
    FROM first_pageviews fp
    LEFT JOIN website_pageviews wpv ON fp.min_pageview_id = wpv.website_pageview_id
    WHERE wpv.pageview_url = '/home'
)
, bounced_sessions AS (
-- For the session of the landing page, get the total number of pages viewed and bring the ones that have this count = 1:
-- so, these are the bounced sessions, where the users saw just the /home page.
    SELECT
        shlp.website_session_id
        , shlp.landing_page
        , COUNT(wpv2.website_pageview_id) AS count_of_pages_viewed
    FROM sessions_w_home_landing_page shlp
    LEFT JOIN website_pageviews wpv2 ON shlp.website_session_id = wpv2.website_session_id
    GROUP BY 1, 2
    HAVING COUNT(wpv2.website_pageview_id) = 1
)
SELECT 
    COUNT(DISTINCT sessions_w_home_landing_page.website_session_id) AS total_sessions
    , COUNT(DISTINCT bounced_sessions.website_session_id) AS bounced_sessions
    , COUNT(DISTINCT bounced_sessions.website_session_id) / COUNT(DISTINCT sessions_w_home_landing_page.website_session_id) AS bounce_rate
FROM sessions_w_home_landing_page
LEFT JOIN bounced_sessions ON sessions_w_home_landing_page.website_session_id = bounced_sessions.website_session_id