-- We rank sessions in the website_pageviews table by creation date.
-- From this ranking, we count the sessions (website_session_id) for the pageviews
-- with rank = 1 (first page viewed in session).
WITH pv_per_session_rank AS (
    SELECT 
        *
        , ROW_NUMBER() OVER (PARTITION BY website_session_id ORDER BY created_at) AS rnk
    FROM website_pageviews
)
SELECT 
    pageview_url AS landing_page_rul
    , COUNT(DISTINCT website_session_id) AS sessions_hitting_page
FROM pv_per_session_rank
WHERE created_at < '2012-06-12' AND rnk = 1
GROUP BY 1
ORDER BY 2 DESC