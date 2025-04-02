CREATE TABLE sales_data (
    Transaction_ID VARCHAR(50) PRIMARY KEY,
    Customer_ID VARCHAR(50),
    Category VARCHAR(100),
    Item VARCHAR(100),
    Price_Per_Unit FLOAT,
    Quantity FLOAT,
    Total_Spent FLOAT,
    Payment_Method VARCHAR(50),
    Purchase_Location VARCHAR(255),
    Transaction_Date DATETIME,
    Discount_Applied BOOLEAN,
    Day_of_Week VARCHAR(20),
    month INT
);
