-- We do a GROUP BY by WEEK, but show the week start date instead of the week number. For this, we use MIN(DATE(created_at)).
-- The objective here is to demonstrate the weekly count of sessions by device type 'desktop' and 'mobile'. 
-- For this, we perform a COUNT with CASE WHEN to count only the values we want.
SELECT
    MIN(DATE(created_at)) AS week_start_date
    , COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_session_id ELSE NULL END) AS dtop_sessions
    , COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) AS mob_sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-04-15' AND '2012-06-09'
AND utm_source = 'gsearch'
AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at)
ORDER BY WEEK(created_at) ASC