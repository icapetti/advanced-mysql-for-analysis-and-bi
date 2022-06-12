# Analyzing Traffic Sources
* Content based on Section 4 of the course Advanced SQL: MySQL Data Analysis & Business Intelligence

## Context
### Traffic source analysis
Where your customers are coming from and which channels are driving the highest quality traffic.

Channels can be:
- Email
- Social
- Search
- Direct

### Conversion Rates 
Percent that converts to sales.

UTM - Urchin Traffic Monitor: parameters are five variants of URL parameters used by marketers to track the effectiveness of online marketing campaigns across traffic sources and publishing media. 

When businesses run paid marleting campaigns, they often obsess over performance and measure everything:
- How much they spend
- How well traffic converts to sales
- etc...

Paid traffic is commonly tagged with tracking (UTM) paramters, which are appended to URLs and allows us to tie website activity back to specific traffic sources and campaigns.

## Assignments
### 01 Finding top traffic sources
#### Case
We've been live for almost a month now and we're starting to generate sales. Can you help me understand **where the bulk of our website sessions are coming from**, from yesterday?
I'd like to see a breakdown by **UTM source, campaign and referring domain**. Thanks!

#### What to do
The objective is to show where the volume of website traffic comes from, that is, where the website sessions come from. That is, we need to build count by TM source, campaign and referring domain and evidence from highest to lowest.
