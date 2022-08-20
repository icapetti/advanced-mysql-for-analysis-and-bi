-- I'd love for you quantify the impact of our billing test, as well. 
-- Please analyze the lift generated from the tes (Sep 10 - Nov 10), in terms of revenue per billing page session, 
-- and then pull the member of billing page sessions for the past month to understand monthly impact.

SELECT
    billing_version_seen
    , COUNT(DISTINCT website_session_id) AS sessions
    , SUM(price_usd)/COUNT(DISTINCT website_session_id) AS revenue_per_billing_page_seen
FROM (
    SELECT
        website_pageviews.website_session_id
        , website_pageviews.pageview_url AS billing_version_seen
        , orders.order_id
        , orders.price_usd
    FROM website_pageviews
    LEFT JOIN orders ON orders.website_session_id = website_pageviews.website_session_id
    WHERE website_pageviews.created_at BETWEEN '2012-09-10' AND '2012-11-10'
    AND website_pageviews.pageview_url IN ('/billing', '/billing-2')
) AS billing_pageviews_and_order_data
GROUP BY 1