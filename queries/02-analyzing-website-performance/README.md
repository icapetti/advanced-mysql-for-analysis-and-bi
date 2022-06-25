# Analyzing website performance
Content based on Section 5 of the course Advanced SQL: MySQL Data Analysis & Business Intelligence

## Index

- [00 Context](#context)
- [01 Finding top website pages](#01-finding-top-website-pages)
- [02 ](#02-)
- [03 ](#03-)
- [04 ](#04-)
- [05 ](#05-)
- [06 ](#06-)
- [07 ](#07-)

## Context
Website content analysis is about understanding which pages are seen the most by your users, to identify where to focus on improving your business. Common use cases:
- Finding the most-viewed pages that customers view on your website.
- Identifying the most common entry pages to your website - the first thing a user sees
- For most-viewed pages and most comm.on entry pages, understanding how those pages perform for your business objectives.
---
## 01 Fiding top website pages
### Case
Pull the most-viewed website pages, ranked by session volume, until 2012-06-09.

### What to do
Structure of the expected result:

| pageview_url 	| sessions 	|
|--------------	|----------	|
| value        	| value    	|

### Results
### [SQL query](01-finding-top-website-pages.sql)
#### ![01-02-Visualization](../../.img/02-01.png)