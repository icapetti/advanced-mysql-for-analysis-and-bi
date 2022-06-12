# The database creation and description
The scripts for creating the database and inserting records into the tables were originally created by the instructor of the [Advanced SQL course](https://www.udemy.com/course/advanced-sql-mysql-for-analytics-business-intelligence/)

## Diagram
The scripts were reorganized and divided into several files just to organize this repository. To understand the database model here is the diagram created by the instructor of the course:
![diagram](./docs-img/maven-db-diagram.png)

## Tables description
### Orders
| Field              	| Type              	| Null 	| Key 	| Default 	| Extra          	| Description                          	|
|--------------------	|-------------------	|------	|-----	|---------	|----------------	|--------------------------------------	|
| order_id           	| bigint unsigned   	| NO   	| PRI 	|         	| auto_increment 	| The unique id for each order.        	|
| created_at         	| datetime          	| NO   	|     	|         	|                	| Date and time of order creation.     	|
| website_session_id 	| bigint unsigned   	| NO   	| MUL 	|         	|                	| Session id that generated the order. 	|
| user_id            	| bigint unsigned   	| NO   	|     	|         	|                	| User id that generated the order.    	|
| primary_product_id 	| smallint unsigned 	| NO   	|     	|         	|                	| Product id.                          	|
| items_purchased    	| smallint unsigned 	| NO   	|     	|         	|                	| Quantity of items in the order.      	|
| price_usd          	| decimal(6,2)      	| NO   	|     	|         	|                	| Total order amount in USD.           	|
| cogs_usd           	| decimal(6,2)      	| NO   	|     	|         	|                	| ?                                    	|

### Order item
| Field           	| Type              	| Null 	| Key 	| Default 	| Extra          	| Description                                              	|
|-----------------	|-------------------	|------	|-----	|---------	|----------------	|----------------------------------------------------------	|
| order_item_id   	| bigint unsigned   	| NO   	| PRI 	|         	| auto_increment 	| Order item id.                                           	|
| created_at      	| datetime          	| NO   	|     	|         	|                	| Date and time of order item creation.                    	|
| order_id        	| bigint unsigned   	| NO   	| MUL 	|         	|                	| Order id.                                                	|
| product_id      	| smallint unsigned 	| NO   	|     	|         	|                	| Product id.                                              	|
| is_primary_item 	| smallint unsigned 	| NO   	|     	|         	|                	| Flag that indicates if the order item is a primary item. 	|
| price_usd       	| decimal(6,2)      	| NO   	|     	|         	|                	| Price of the item in USD.                                	|
| cogs_usd        	| decimal(6,2)      	| NO   	|     	|         	|                	| ?                                                        	|

### Order item refunds
| Field                	| Type            	| Null 	| Key 	| Default 	| Extra          	| Description                                  	|
|----------------------	|-----------------	|------	|-----	|---------	|----------------	|----------------------------------------------	|
| order_item_refund_id 	| bigint unsigned 	| NO   	| PRI 	|         	| auto_increment 	| Order item refund id.                        	|
| created_at           	| datetime        	| NO   	|     	|         	|                	| Date and time of order item refund creation. 	|
| order_item_id        	| bigint unsigned 	| NO   	| MUL 	|         	|                	| Order item id.                               	|
| order_id             	| bigint unsigned 	| NO   	| MUL 	|         	|                	| Order it.                                    	|
| refund_amount_usd    	| decimal(6,2)    	| NO   	|     	|         	|                	| Refund amount in USD.                        	|

### Products
| Field        	| Type            	| Null 	| Key 	| Default 	| Extra          	| Description                            	|
|--------------	|-----------------	|------	|-----	|---------	|----------------	|----------------------------------------	|
| product_id   	| bigint unsigned 	| NO   	| PRI 	|         	| auto_increment 	| Product unique id.                     	|
| created_at   	| datetime        	| NO   	|     	|         	|                	| Date and time of product registration. 	|
| product_name 	| varchar(50)     	| NO   	|     	|         	|                	| The product name.                      	|

### Website page views
| Field               	| Type            	| Null 	| Key 	| Default 	| Extra          	| Description                 	|
|---------------------	|-----------------	|------	|-----	|---------	|----------------	|-----------------------------	|
| website_pageview_id 	| bigint unsigned 	| NO   	| PRI 	|         	| auto_increment 	| id.                         	|
| created_at          	| datetime        	| NO   	|     	|         	|                	| Date and time of page view. 	|
| website_session_id  	| bigint unsigned 	| NO   	| MUL 	|         	|                	| Session id.                 	|
| pageview_url        	| varchar(50)     	| NO   	|     	|         	|                	| Page URL.                   	|

### Website sessions
| Field              	| Type              	| Null 	| Key 	| Default 	| Extra          	| Description                                 	        |
|--------------------	|-------------------	|------	|-----	|---------	|----------------	|----------------------------------------------------   |
| website_session_id 	| bigint unsigned   	| NO   	| PRI 	|         	| auto_increment 	| Session id.                                 	        |
| created_at         	| datetime          	| NO   	|     	|         	|                	| Date and time of session.                   	        |
| user_id            	| bigint unsigned   	| NO   	| MUL 	|         	|                	| User id.                                    	        |
| is_repeat_session  	| smallint unsigned 	| NO   	|     	|         	|                	| Flag that indicate if is a repeted session. 	        |
| utm_source         	| varchar(12)       	| YES  	|     	|         	|                	| It can be: gsearch, socialbook, bsearch      	        |
| utm_campaign       	| varchar(20)       	| YES  	|     	|         	|                	| It can be: brand, nonbrand, desktop_targeted, pilot   |
| utm_content        	| varchar(15)       	| YES  	|     	|         	|                	| ?                                           	        |
| device_type        	| varchar(15)       	| YES  	|     	|         	|                	| It can be: mobile, desktop                   	        |
| http_referer       	| varchar(30)       	| YES  	|     	|         	|                	| ?                                           	        |