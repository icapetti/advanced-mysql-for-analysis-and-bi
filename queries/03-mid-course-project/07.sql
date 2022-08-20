-- For the landing page test you analyzed previously, it would be great to show a full conversion funnel from each of the two pages to orders. 
-- You can use the same time period you analyzed last time (Jun 19 - Jul 28).

WITH session_level_made_it_flagged AS (
    SELECT
        website_session_id
        , MAX(homepage) AS saw_homepage
        , MAX(custom_lander) AS saw_custom_lander
        , MAX(products_page) AS product_made_it
        , MAX(mrfuzzy_page) AS mrfuzzy_made_it
        , MAX(cart_page) AS cart_made_it
        , MAX(shipping_page) AS shipping_made_it
        , MAX(billing_page) AS billing_made_it
        , MAX(thankyou_page) AS thankyou_made_it
    FROM(
        SELECT 
            website_sessions.website_session_id
            , website_pageviews.pageview_url
            , CASE WHEN pageview_url = '/home' THEN 1 ELSE 0 END AS homepage 
            , CASE WHEN pageview_url = '/lander-1' THEN 1 ELSE 0 END AS custom_lander
            , CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END AS products_page
            , CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page
            , CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page
            , CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page
            , CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page
            , CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
        FROM website_sessions
        LEFT JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
        WHERE website_sessions.utm_source = 'gsearch'
        AND website_sessions.utm_campaign = 'nonbrand'
        AND website_sessions.created_at BETWEEN '2012-06-19' AND '2012-07-28'
        ORDER BY website_sessions.website_session_id, website_sessions.created_at
    ) AS pageview_level
    GROUP BY website_sessions.website_session_id/*, website_sessions.created_at*/
)
SELECT
    CASE
        WHEN saw_homepage = 1 THEN 'saw_homepage'
        WHEN saw_custom_lander = 1 THEN 'saw_custom_lander'
        ELSE 'uh... check logic'
    END AS segment
    , COUNT(DISTINCT website_session_id) AS sessions
    , COUNT(DISTINCT CASE WHEN product_made_it = 1 THEN website_session_id ELSE NULL END) AS to_products
    , COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS to_mrfuzzy
    , COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) AS to_cart
    , COUNT(DISTINCT CASE WHEN shipping_made_it = 1 THEN website_session_id ELSE NULL END) AS to_shipping
    , COUNT(DISTINCT CASE WHEN billing_made_it = 1 THEN website_session_id ELSE NULL END) AS to_billing
    , COUNT(DISTINCT CASE WHEN thankyou_made_it = 1 THEN website_session_id ELSE NULL END) AS to_thankyou
FROM session_level_made_it_flagged
GROUP BY 1