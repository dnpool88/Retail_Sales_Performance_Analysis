-- Q:Retrieve all the relevant sales data for the last 6 months.

-- 1. Retrieving the most recent date:
SELECT MAX(Transaction_Date) AS Most_Recent_Date
FROM sales_data;

/* Result:
+---------------------+
| Most_Recent_Date    |
+---------------------+
| 2025-01-18 00:00:00 |
+---------------------+
*/

-- 2. Making a new table containing sales data from 2024-07-18 to 2025-01-18:
CREATE TABLE sales_data_6months AS
SELECT *
FROM sales_data
WHERE Transaction_Date BETWEEN '2024-07-18' AND '2025-01-18';

    -- 2b. Setting Transaction_ID as the primary key:
ALTER TABLE sales_data_6months 
ADD PRIMARY KEY (Transaction_ID);

-- Calculating the total sales revenue and total number of transactions per product.
-- Ranking these products, then calculating the renevue per transaction.
SELECT Item, 
SUM(Total_Spent) AS Total_Sales_Revenue, 
COUNT(Transaction_ID) AS Total_Transactions,
FROM sales_data_6months
GROUP BY Item
ORDER BY Total_Sales_Revenue DESC
LIMIT 10;

/* Result:
+--------------+---------------------+--------------------+
| Item         | Total_Sales_Revenue | Total_Transactions |
+--------------+---------------------+--------------------+
| Unknown      |             12176.5 |                189 |
| Item_25_BUT  |                4633 |                 17 |
| Item_19_MILK |                4288 |                 24 |
| Item_25_BEV  |                4100 |                 18 |
| Item_25_EHE  |                4018 |                 18 |
| Item_19_CEA  |                4000 |                 27 |
| Item_20_FOOD |                3819 |                 20 |
| Item_25_FUR  |                3731 |                 17 |
| Item_20_BEV  |              3651.5 |                 19 |
| Item_17_BEV  |                3625 |                 21 |
+--------------+---------------------+--------------------+
*/

-- 1. Removing the Unknown items and ranking the remaining items.
-- Creating as a table for the next step:
CREATE TABLE item_sales_rank AS
SELECT Item, 
SUM(Total_Spent) AS Total_Sales_Revenue, 
COUNT(Transaction_ID) AS Total_Transactions,
RANK() OVER (ORDER BY SUM(Total_Spent) DESC) AS Revenue_Rank
FROM sales_data_6months
WHERE Item != 'Unknown'
GROUP BY Item
ORDER BY Total_Sales_Revenue DESC;

/* Result (Showing only 10 rows):
+--------------+---------------------+--------------------+--------------+
| Item         | Total_Sales_Revenue | Total_Transactions | Revenue_Rank |
+--------------+---------------------+--------------------+--------------+
| Item_25_BUT  |                4633 |                 17 |            1 |
| Item_19_MILK |                4288 |                 24 |            2 |
| Item_25_BEV  |                4100 |                 18 |            3 |
| Item_25_EHE  |                4018 |                 18 |            4 |
| Item_19_CEA  |                4000 |                 27 |            5 |
| Item_20_FOOD |                3819 |                 20 |            6 |
| Item_25_FUR  |                3731 |                 17 |            7 |
| Item_20_BEV  |              3651.5 |                 19 |            8 |
| Item_17_BEV  |                3625 |                 21 |            9 |
| Item_24_FUR  |                3555 |                 18 |           10 |
+--------------+---------------------+--------------------+--------------+
*/

-- Q: Calculating revenue per transaction.
CREATE TABLE revenue_per_transaction AS
SELECT Item,
Total_Sales_Revenue,
Total_Transactions,
Revenue_Rank,
ROUND(Total_Sales_Revenue / Total_Transactions, 2) AS Revenue_Per_Transaction
FROM item_sales_rank
ORDER BY Revenue_Per_Transaction DESC;

SELECT * FROM revenue_per_transaction LIMIT 15;

/* Result:
+--------------+---------------------+--------------------+--------------+-------------------------+
| Item         | Total_Sales_Revenue | Total_Transactions | Revenue_Rank | Revenue_Per_Transaction |
+--------------+---------------------+--------------------+--------------+-------------------------+
| Item_24_CEA  |                 553 |                  2 |          133 |                   276.5 |
| Item_25_BUT  |                4633 |                 17 |            1 |                  272.53 |
| Item_19_BEV  |                2720 |                 10 |           23 |                     272 |
| Item_19_FOOD |                 544 |                  2 |          136 |                     272 |
| Item_21_FOOD |                1015 |                  4 |           98 |                  253.75 |
| Item_21_BEV  |                2765 |                 11 |           21 |                  251.36 |
| Item_23_BEV  |                2204 |                  9 |           37 |                  244.89 |
| Item_24_EHE  |                 474 |                  2 |          141 |                     237 |
| Item_15_MILK |                 468 |                  2 |          142 |                     234 |
| Item_24_MILK |              1619.5 |                  7 |           62 |                  231.36 |
| Item_25_FOOD |                3444 |                 15 |           11 |                   229.6 |
| Item_24_PAT  |                2054 |                  9 |           46 |                  228.22 |
| Item_25_BEV  |                4100 |                 18 |            3 |                  227.78 |
| Item_24_BEV  |                2686 |                 12 |           27 |                  223.83 |
| Item_25_EHE  |                4018 |                 18 |            4 |                  223.22 |
+--------------+---------------------+--------------------+--------------+-------------------------+

As we can see there isn't really a correlation between Sales Revenue and Revenue per Transaction,
although the distribution seems to be more at the end points of Revenue_Rank.
*/

-- Q:Get a breakdown of sales by payment method, day of the week, and month.

-- 1. Payment Methods:
SELECT Payment_Method,
COUNT(Transaction_ID) AS Total_Transactions,
SUM(Total_Spent) AS Total_Sales_Revenue,
ROUND(AVG(Total_Spent), 2) AS Avg_Sale_Value
FROM sales_data
GROUP BY Payment_Method
ORDER BY Total_Sales_Revenue DESC;

/* Result:
+----------------+--------------------+---------------------+----------------+
| Payment_Method | Total_Transactions | Total_Sales_Revenue | Avg_Sale_Value |
+----------------+--------------------+---------------------+----------------+
| Cash           |               4310 |              537710 |         124.76 |
| Digital Wallet |               4144 |              507279 |         122.41 |
| Credit Card    |               4121 |              507082 |         123.05 |
+----------------+--------------------+---------------------+----------------+
*/

-- 2. Day of the Week:
SELECT Day_of_Week,
COUNT(Transaction_ID) AS Total_Transactions,
SUM(Total_Spent) AS Total_Sales_Revenue,
ROUND(AVG(Total_Spent), 2) AS Avg_Sale_Value
FROM sales_data
GROUP BY Day_of_Week
ORDER BY Total_Sales_Revenue DESC;

/* Result:
+-------------+--------------------+---------------------+----------------+
| Day_of_Week | Total_Transactions | Total_Sales_Revenue | Avg_Sale_Value |
+-------------+--------------------+---------------------+----------------+
| Friday      |               1808 |              232786 |         128.75 |
| Sunday      |               1811 |              225991 |         124.79 |
| Saturday    |               1787 |              224191 |         125.46 |
| Tuesday     |               1788 |              219650 |         122.85 |
| Thursday    |               1790 |            219380.5 |         122.56 |
| Wednesday   |               1813 |              216982 |         119.68 |
| Monday      |               1778 |            213090.5 |         119.85 |
+-------------+--------------------+---------------------+----------------+
*/

-- 3. Month:
SELECT month,
COUNT(Transaction_ID) AS Total_Transactions,
SUM(Total_Spent) AS Total_Sales_Revenue,
ROUND(AVG(Total_Spent), 2) AS Avg_Sale_Value
FROM sales_data
GROUP BY month
ORDER BY month ASC;

/* Result:
+-------+--------------------+---------------------+----------------+
| month | Total_Transactions | Total_Sales_Revenue | Avg_Sale_Value |
+-------+--------------------+---------------------+----------------+
|     1 |               1361 |              174421 |         128.16 |
|     2 |                965 |              119685 |         124.03 |
|     3 |               1019 |              122392 |         120.11 |
|     4 |                996 |            125618.5 |         126.12 |
|     5 |               1033 |            124594.5 |         120.61 |
|     6 |               1038 |              129771 |         125.02 |
|     7 |               1089 |              131509 |         120.76 |
|     8 |               1039 |            123287.5 |         118.66 |
|     9 |               1021 |              129344 |         126.68 |
|    10 |                978 |            119413.5 |          122.1 |
|    11 |               1003 |            122346.5 |         121.98 |
|    12 |               1033 |            129688.5 |         125.55 |
+-------+--------------------+---------------------+----------------+
*/

-- Q:Which item is purchased the most by high-spending customers?

-- 1. Finding the top 20% of customers:
WITH High_Paying_Customers AS (
    SELECT Customer_ID,
    SUM(Total_Spent) AS Total_Customer_Spent
    FROM sales_data
    GROUP BY Customer_ID
),
Ranked_Customers AS (
    SELECT Customer_ID,  
           Total_Customer_Spent,  
           NTILE(10) OVER (ORDER BY Total_Customer_Spent DESC) AS Spending_Rank  
    FROM High_Paying_Customers
)

SELECT * FROM Ranked_Customers WHERE Spending_Rank = 2;
/* Result:
+-------------+----------------------+---------------+
| Customer_ID | Total_Customer_Spent | Spending_Rank |
+-------------+----------------------+---------------+
| CUST_24     |                68452 |             1 |
| CUST_08     |              67351.5 |             1 |
| CUST_05     |              66974.5 |             1 |
| CUST_16     |              65570.5 |             2 |
| CUST_13     |                65037 |             2 |
| CUST_23     |                64507 |             2 |
+-------------+----------------------+---------------+
*/

-- 2. Finding the most purchased item between these 6 top customers:
SELECT Item,  
       COUNT(*) AS Purchase_Count  
FROM sales_data  
WHERE Customer_ID IN ('CUST_24', 'CUST_08', 'CUST_05', 'CUST_16', 'CUST_13', 'CUST_23')  
       AND Item != 'Unknown'
GROUP BY Item  
ORDER BY Purchase_Count DESC  
LIMIT 1;  

/* Result:
+-------------+----------------+
| Item        | Purchase_Count |
+-------------+----------------+
| Item_12_PAT |             37 |
+-------------+----------------+
*/