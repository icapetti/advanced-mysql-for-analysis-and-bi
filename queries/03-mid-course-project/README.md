# Mid course project
Content based on Section 6 of the course Advanced SQL: MySQL Data Analysis & Business Intelligence

## The situation
Maven Fuzzy Factory has been live for ~8 months and your CEO is due to present company performance metrics to the board next week. You'll be the one tasked with preparing relevant metrics to show the company's promising growth.

## The objective
Use SQL to:
Extract and analyze website traffic and performance data from the Maven Fuzzy Factory database to quantify the company's growth, and to tell the story of how you have been able to generate that growth.


## CEO questions
1 Gsearch seems to be the biggest driver of our business. Could you pull monthly trends for gsearch sessions and orders so that we can showcase the growth there?
[Question 1 - SQL code](01.sql)

2 Next, it would be great to see a similar monthly trend for Gsearch, but this time splitting out nonbrand and brand campaigns separately. I am wondering if brand is picking up at all. If so, this is a good story to tell.
[Question 2 - SQL code](02.sql)

3 While we're on Gsearch, could you dive into nobrand, and pull monthly sessions and orders split by device type? I want to flex out analytical muscles a little and show the board we really know our traffic sources.
[Question 3 - SQL code](03.sql)

4 I'm worried that one of our pessimistic board members may be concerned about the large % of traffic from Gsearch. Can you pull monthly trends for Gsearch, alongside monthly trends for each of other channels?
[Question 4 - SQL code](04.sql)

5 I'd like to tell the story of our website performance improvements over the course of the first 8 months. Could you pull session to order conversion rates, by month?
[Question 5 - SQL code](05.sql)

6 For gsearch lander test, please estimate the revenue that test earned us (Hint: look at the increase in CVR from the test (Jun 19 - Jul 28), and use nonbrand sessions and revenue since then to calculate incremental value).
[Question 6 - SQL code](06.sql)

7 For the landing page test you analyzed previously, it would be great to show a full conversion funnel from each of the two pages to orders. You can use the same time period you analyzed last time (Jun 19 - Jul 28).
[Question 7 - SQL code](07.sql)

8 I'd love for you quantify the impact of our billing test, as well. Please analyze the lift generated from the tes (Sep 10 - Nov 10), in terms of revenue per billing page session, and then pull the member of billing page sessions for the past month to understand monthly impact.
[Question 8 - SQL code](08.sql)