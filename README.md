# Sales Management System with PL/SQL Procedures

## Overview

This project is a sales management system built with Oracle SQL and PL/SQL. It manages customers, products, sales transactions, and location management, while also providing a set of PL/SQL procedures and functions to handle various operations like adding and deleting customers and products, updating sales, and managing statuses.

## Database Structure

The database consists of four primary tables:

1. **CUSTOMER**: Stores customer details, including name, status, and YTD sales.
2. **PRODUCT**: Stores product details, such as name, price, and YTD sales.
3. **SALE**: Tracks individual sales, connecting customers and products with the quantity sold and total sale amount.
4. **LOCATION**: Manages inventory locations with constraints on minimum and maximum quantities.

### Relationships:
- The `SALE` table links the `CUSTOMER` and `PRODUCT` tables via foreign keys (`CUSTID` and `PRODID`).
- The `LOCATION` table defines storage locations with minimum and maximum inventory constraints.

### Table Definitions:

#### CUSTOMER
| Column Name  | Data Type     | Description                       |
|--------------|---------------|-----------------------------------|
| `CUSTID`     | NUMBER        | Primary Key, Unique Customer ID   |
| `CUSTNAME`   | VARCHAR2(100) | Customer's Full Name              |
| `STATUS`     | VARCHAR2(7)   | Customer Status                   |
| `SALES_YTD`  | NUMBER        | Year-to-Date Sales Amount         |

#### PRODUCT
| Column Name     | Data Type     | Description                         |
|-----------------|---------------|-------------------------------------|
| `PRODID`        | NUMBER        | Primary Key, Unique Product ID      |
| `PRODNAME`      | VARCHAR2(100) | Name of the Product                 |
| `SELLING_PRICE` | NUMBER        | Price of the Product                |
| `SALES_YTD`     | NUMBER        | Year-to-Date Sales Amount for Product|

#### SALE
| Column Name  | Data Type   | Description                          |
|--------------|-------------|--------------------------------------|
| `SALEID`     | NUMBER      | Primary Key, Unique Sale ID          |
| `CUSTID`     | NUMBER      | Foreign Key, References `CUSTOMER`   |
| `PRODID`     | NUMBER      | Foreign Key, References `PRODUCT`    |
| `QTY`        | NUMBER      | Quantity of Product Sold             |
| `PRICE`      | NUMBER      | Price of the Sale                    |
| `SALEDATE`   | DATE        | Date of the Sale                     |

#### LOCATION
| Column Name   | Data Type   | Description                            |
|---------------|-------------|----------------------------------------|
| `LOCID`       | VARCHAR2(5) | Primary Key, Location Identifier       |
| `MINQTY`      | NUMBER      | Minimum Quantity Allowed               |
| `MAXQTY`      | NUMBER      | Maximum Quantity Allowed               |
| **Constraints** |           |                                        |
| `CHECK_LOCID_LENGTH` | Ensures `LOCID` is 5 characters long          |
| `CHECK_MINQTY_RANGE` | Ensures `MINQTY` is between 0 and 999          |
| `CHECK_MAXQTY_RANGE` | Ensures `MAXQTY` is between 0 and 999          |
| `CHECK_MAXQTY_GREATER_MINQTY` | Ensures `MAXQTY` is greater than or equal to `MINQTY` |

## PL/SQL Procedures and Functions

### 1. Adding Customers

- **Procedure**: `ADD_CUST_TO_DB`
  
  Adds a customer to the database. Validates the customer ID and raises an error if the ID is out of range or already exists.

- **Procedure**: `ADD_CUSTOMER_VIASQLDEV`
  
  Provides an interface to add customers via SQL Developer, handles commit, and outputs success or error messages.

### 2. Deleting All Customers

- **Function**: `DELETE_ALL_CUSTOMERS_FROM_DB`
  
  Deletes all customer records from the database and returns the number of deleted rows.

- **Procedure**: `DELETE_ALL_CUSTOMERS_VIASQLDEV`
  
  Calls `DELETE_ALL_CUSTOMERS_FROM_DB` and prints the number of rows deleted.

### 3. Adding Products

- **Procedure**: `ADD_PRODUCT_TO_DB`
  
  Adds a product to the database with validation on product ID and price range.

- **Procedure**: `ADD_PRODUCT_VIASQLDEV`
  
  Provides an interface to add products via SQL Developer, handles commit, and outputs success or error messages.

### 4. Deleting All Products

- **Function**: `DELETE_ALL_PRODUCTS_FROM_DB`
  
  Deletes all product records from the database and returns the number of deleted rows.

- **Procedure**: `DELETE_ALL_PRODUCTS_VIASQLDEV`
  
  Calls `DELETE_ALL_PRODUCTS_FROM_DB` and prints the number of rows deleted.

### 5. Fetching Customer Information

- **Function**: `GET_CUST_STRING_FROM_DB`
  
  Retrieves a customer’s details in the format:
  Custid: [ID] Name: [Name] Status: [Status] SalesYTD: [SalesYTD]

- **Procedure**: `GET_CUST_STRING_VIASQLDEV`

  Provides an interface to fetch and display customer details via SQL Developer.

### 6. Updating Customer's YTD Sales

- **Procedure**: `UPD_CUST_SALESYTD_IN_DB`

  Updates the `SALES_YTD` for a customer with validation on the amount range.

- **Procedure**: `UPD_CUST_SALESYTD_VIASQLDEV`

  Provides an interface to update a customer’s YTD sales via SQL Developer.

### 7. Fetching Product Information

- **Function**: `GET_PROD_STRING_FROM_DB`

  Retrieves a product’s details in the format:
  Prodid: [ID] Name: [Name] Price: [Price] SalesYTD: [SalesYTD]

- **Procedure**: `GET_PROD_STRING_VIASQLDEV`

  Provides an interface to fetch and display product details via SQL Developer.

### 8. Updating Product's YTD Sales

- **Procedure**: `UPD_PROD_SALESYTD_IN_DB`

  Updates the `SALES_YTD` for a product with validation on the amount range.

- **Procedure**: `UPD_PROD_SALESYTD_VIASQLDEV`

  Provides an interface to update a product’s YTD sales via SQL Developer.

### 9. Updating Customer Status

- **Procedure**: `UPD_CUST_STATUS_IN_DB`

  Updates the `STATUS` for a customer with validation on the status value.

- **Procedure**: `UPD_CUST_STATUS_VIASQLDEV`

  Provides an interface to update a customer’s status via SQL Developer.

## Sequences

- **SALE_SEQ**: A sequence used to generate unique `SALEID` values for    the `SALE` table.

## Getting Started

### Prerequisites:
- Oracle Database setup.
- SQL Developer or any other PL/SQL development tool.

### Installation:
1. Clone the repository:
 ```bash
 git clone https://github.com/yourusername/sales-management-system.git
```
2. Execute the schema.sql script to create the necessary tables.
3. Execute the PL/SQL scripts for functions and procedures.

### Usage 
1. Add new customers and products using the provided procedures.
2. Record sales transactions and update YTD sales.
3. Run the provided functions to fetch and sum up YTD sales.

### License
  This project is under MIT license
