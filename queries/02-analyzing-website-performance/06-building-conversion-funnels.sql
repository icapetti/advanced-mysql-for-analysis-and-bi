-- 1: select all pageviews for relevant sessions
-- 2: identify each pageview as the specific funnel step
-- 3: create the session-level conversion funnel  view
-- 4: aggregate the data do assess funnel performance

WITH flags AS (
    SELECT 
        ws.website_session_id
        , wpv.pageview_url
        , CASE WHEN wpv.pageview_url = '/products' THEN 1 ELSE 0 END AS products_page
        , CASE WHEN wpv.pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page
        , CASE WHEN wpv.pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page
        , CASE WHEN wpv.pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page
        , CASE WHEN wpv.pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page
        , CASE WHEN wpv.pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS thankyou_page
    FROM website_sessions ws
    LEFT JOIN website_pageviews wpv ON ws.website_session_id = wpv.website_session_id
    WHERE ws.utm_source = 'gsearch'
        AND ws.utm_campaign = 'nonbrand'
        AND ws.created_at > '2012-08-05'
        AND ws.created_at < '2012-09-05'
    ORDER BY 
        ws.website_session_id
        , wpv.created_at
)
, funnel AS (
-- Here is the funnel, in a non aggregated way, the funnel for each session_id, we identify how far each session has reached in our flow.
    SELECT 
        website_session_id
        , MAX(products_page) AS products_page
        , MAX(mrfuzzy_page) AS mrfuzzy_page
        , MAX(cart_page) AS cart_page
        , MAX(shipping_page) AS shipping_page
        , MAX(billing_page) AS billing_page
        , MAX(thankyou_page) AS thankyou_page
    FROM flags
    GROUP BY 
        website_session_id
)
, funnel_agg AS (
    -- Here we get an aggregated way the total sessions and how many of then went to the products page, and then to the myfuzzy and so on.
    SELECT
        COUNT(DISTINCT website_session_id) AS sessions
        , COUNT(DISTINCT CASE WHEN products_page = 1 THEN website_session_id ELSE NULL END) AS to_products
        , COUNT(DISTINCT CASE WHEN mrfuzzy_page = 1 THEN website_session_id ELSE NULL END) AS to_mrfuzzy
        , COUNT(DISTINCT CASE WHEN cart_page = 1 THEN website_session_id ELSE NULL END) AS to_cart
        , COUNT(DISTINCT CASE WHEN shipping_page = 1 THEN website_session_id ELSE NULL END) AS to_shipping
        , COUNT(DISTINCT CASE WHEN billing_page = 1 THEN website_session_id ELSE NULL END) AS to_billing
        , COUNT(DISTINCT CASE WHEN thankyou_page = 1 THEN website_session_id ELSE NULL END) AS to_thankyou
    FROM funnel
)
-- Here we have the rates for funnel agg
SELECT
    to_products / sessions AS lander_click_rate
    , to_mrfuzzy / to_products AS myfuzzy_click_rate
    , to_cart / to_mrfuzzy AS cart_click_rate
    , to_shipping / to_cart AS shipping_click_rate
    , to_billing / to_shipping AS billing_click_rate
    , to_thankyou / to_billing AS thankyou_click_rate
FROM funnel_agg