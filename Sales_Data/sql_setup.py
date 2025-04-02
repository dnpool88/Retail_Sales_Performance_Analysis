import mysql.connector 
import pandas as pd

df = pd.read_csv('/Users/dylanpool/Desktop/Side_Projects/Sales_Data/cleaned_sales_data.csv')

# Connecting to MySQL Database:

connection = mysql.connector.connect(
    host='localhost',
    user='root',
    password='dynkster',
    database='sales_db',
    allow_local_infile=True
)

if connection.is_connected():
    print('MySQL Success')

cursor = connection.cursor()

csv_file_path = '/Users/dylanpool/Desktop/Side_Projects/Sales_Data/cleaned_sales_data.csv'

# SQL query to load the CSV into your table
query = f"""
LOAD DATA LOCAL INFILE '{csv_file_path}'
INTO TABLE sales_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'           
LINES TERMINATED BY '\n' 
IGNORE 1 LINES             
(
    `transaction_id`,
    `customer_id`,
    `category`,
    `item`,
    `price_per_unit`,
    `quantity`,
    `total_spent`,
    `payment_method`,
    `location`,
    `transaction_date`,
    `discount_applied`,
    `day_of_week`,
    `month`
);
"""
cursor.execute(query)


cursor.execute('SELECT * FROM sales_data')
result = cursor.fetchall()

for row in result:
    print(row)

connection.commit()
cursor.close()
connection.close()