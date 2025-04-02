import kagglehub
import pandas as pd
import mysql.connector 

# Download latest version
path = kagglehub.dataset_download("ahmedmohamed2003/retail-store-sales-dirty-for-data-cleaning")

#print("Path to dataset files:", path)

file_path = "/Users/dylanpool/.cache/kagglehub/datasets/ahmedmohamed2003/retail-store-sales-dirty-for-data-cleaning/versions/1/retail_store_sales.csv"

# Load the dataset into a pandas dataframe
df = pd.read_csv(file_path)
#print(df.head())

# Data Cleaning:

df['Discount Applied'] = df['Discount Applied'].fillna(False)
df['Item'] = df['Item'].fillna('Unknown')
df['Price Per Unit'] = df['Price Per Unit'].fillna(df['Price Per Unit'].median())
df['Quantity'] = df['Quantity'].fillna(0)
df['Total Spent'] = df['Total Spent'].fillna(df['Price Per Unit'] * df['Quantity'])
#print(df.isnull().sum())

df['Transaction Date'] = pd.to_datetime(df['Transaction Date'], errors='coerce')
df['Quantity'] = pd.to_numeric(df['Quantity'], errors='coerce')
df['Price Per Unit'] = pd.to_numeric(df['Price Per Unit'], errors='coerce')
df['Item'] = df['Item'].astype('category')
df['Payment Method'] = df['Payment Method'].astype('category')

df['Day of Week'] = df['Transaction Date'].dt.day_name()
df['Month'] = df['Transaction Date'].dt.month

df.to_csv('cleaned_sales_data.csv', index=False)