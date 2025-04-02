# Retail Sales Performance Analysis

### Dataset
[Kaggle - Retail Store Sales (Dirty for Data Cleaning)](https://www.kaggle.com/datasets/ahmedmohamed2003/retail-store-sales-dirty-for-data-cleaning)

I am using a mock dataset from Ahmed Mohamed on Kaggle, containing sales data on **12,575 transactions** with details such as product, price, date, category, and more.

### Project Overview

This project is focused on analyzing the sales performance of a retail company using SQL for data extraction, Excel for data cleaning and analysis, and Tableau for visualization. The goal is to provide actionable insights that help the company understand key trends in their sales data, including the most profitable products, sales trends across time, and the impact of discounts.

### Project Problem
A retail company has requested an analysis of its sales performance to understand key business questions:

- **Which products are the most profitable?**
- **How do sales trends vary across different days of the week and months?**
- **What payment methods are used the most?**
- **What impact do discounts have?**
- **How does customer spending behavior vary?**

The company requires an **easy-to-understand and visually appealing** presentation of these findings.

### **Approach:**
- **SQL** for data extraction
- **Excel** for data cleaning and initial analysis
- **Tableau** for creating visualizations and presenting actionable insights

### Key Goals

The aim of this project is to:

Analyze sales performance using SQL queries to extract meaningful insights.

Clean and transform data in Excel to ensure consistency and accuracy.

Visualize trends and key metrics using Tableau dashboards to provide clear, actionable insights.

---

## **1. Data Extraction (SQL)**

The first step involved querying the database to extract relevant sales data, focusing on the most recent **6-month period**.

### **Key SQL Queries:**
1. **Retrieve Sales Data for the Last 6 Months:**
   - Filtered transactions from **July 18, 2024, to January 18, 2025**.
   - Stored the data in `sales_data_6months`, ensuring `Transaction_ID` was unique.

2. **Calculate Total Sales Revenue and Top Products:**
   - Identified top-selling products based on revenue.
   - Removed the "Unknown" category, which skewed results.
   - Ranked the remaining products by sales revenue.

3. **Revenue Per Transaction Analysis:**
   - Examined variations in revenue per transaction.
   - Found that high-revenue products do not always have the highest transaction values.

4. **Breakdown by Payment Method, Day, and Month:**
   - **Payment Methods:** Cash, Digital Wallet, and Credit Card had no major differences.
   - **Day of the Week:** Highest sales on **Friday, Saturday, and Sunday**, with Sunday being the busiest.
   - **Monthly Trends:** **January had the highest sales**, contradicting expectations of a strong December.

5. **Purchasing Behavior of High-Spending Customers:**
   - Identified the **top 20% of customers** by total spending (six individuals).
   - Their most frequently purchased items were **not in the top 10 products by total revenue**, suggesting they have **limited impact on overall sales**.

---

## **2. Data Cleaning & Analysis (Excel)**

### **Steps Taken in Excel:**

#### **Data Cleaning**
- **Conditional Formatting:** Highlighted missing values and inconsistencies.
- **COUNTIF:** Identified duplicates and outliers in `Quantity` and `Total_Spent`.
- **Date Standardization:** Applied `YYYY-MM-DD` format to `Transaction_Date`.

#### **Sales Analysis**
- **Sales per Transaction:** `Total_Spent / Quantity` column added.
- **Total Spending Per Customer:** Used `SUMIF` to aggregate spending.

#### **Profit Calculation**
- **VLOOKUP for Cost Values:** Calculated `Profit per Product = Total_Spent - Cost`.
- **Average Cost by Category:** Used Pivot Tables for category pricing trends.

#### **Discount Impact Analysis**
- **SUMIF for Discount vs. Non-Discount Revenue.**
- **Created `Total_Spent_Discount` Column** to track sales with discounts.

#### **Pivot Tables for Insights**
1. **Category-Based Pivot Table:** Displaying `Avg_Price_Per_Unit`.
2. **Year-Based Pivot Table:** Extracted `Year` from `Transaction_Date` for trend analysis.

#### **VBA Automation**
- **Created a VBA macro** for data cleaning, formatting, and dynamic formula updates.
- **Ensured efficiency** by testing and refining the macro.

---

## **3. Data Visualization (Tableau)**

### **Tableau Workbook:**
[Sales Visualizations on Tableau Public](https://public.tableau.com/views/Sales_Visualizations/CategoricalSpendingDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

### **Dashboard Previews:**
![Categorical Spending Dashboard](/Users/dylanpool/Desktop/Side_Projects/Sales_Data/Categorical_Spending_Dashboard.png)
![Time-Focused Dashboard](/Users/dylanpool/Desktop/Side_Projects/Sales_Data/Time-Focused_Dashboard.png)

---

## **Tableau Dashboard Analysis**

### **Time-Focused Dashboard**
- **Stable Sales Trends (2022-2024):** No major fluctuations in yearly sales.
- **2025 Data Still in Progress:** Current data extends to February.
- **Slight Price Increase:** Average price per unit **rose by $0.81 since 2022**, indicating steady consumer demand.
- **Busiest Days:** **Friday to Sunday peak in sales, with Sunday being the busiest.**
- **Surprising January Sales Spike:** January has unexpectedly higher sales than December, contradicting typical holiday trends.

### **Categorical Spending Dashboard**
- **Even Spending Across Categories:** No single category dominates revenue, indicating a diverse product mix.
- **Stable Category Sales Trends:** No major shifts in sales between years.
- **Spending by Top 20% Customers:** **Different spending patterns compared to overall sales**, reducing reliance on high-spending customers.
- **Unexpectedly Low Avg Price for Electronics & Furniture:** Raises questions about pricing strategies or data accuracy. 

## Conclusion  
Both dashboards provide valuable insights into sales performance, consumer behavior, and pricing trends. The data suggests a stable and well-balanced revenue distribution, with some areas for deeper investigation—particularly around category pricing and seasonal sales patterns.  

## Files

- [Python Preliminary Data Cleaning](./data_clean.py) - Performs initial checks on the data to ensure its suitability for the project.
- [MySQL Setup](./sql_setup.py) - Python file used to setup MySQL Database.
- [SQL Queries](./Sales_queries.sql) - SQL queries used for extracting and analyzing data.
- [Excel File](./sales_data.xlsx) - Cleaned and analyzed sales data.
- [Tableau Workbook Link](https://public.tableau.com/views/Sales_Visualizations/CategoricalSpendingDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) - Interactive Tableau dashboards.
- [VBA Code](./vba_code.txt) - VBA macro for automating data cleaning.