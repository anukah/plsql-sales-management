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

## Sequences

- **SALE_SEQ**: A sequence used to generate unique `SALEID` values for the `SALE` table.

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

### 6. Fetching All Customers
- **Function**: `GET_ALLCUST`

  Retrieves a customer details in the format:
  Custid: [ID] Name: [Name] Status: [Status] SalesYTD: [SalesYTD]

- **Procedure**: `GET_ALLCUST_VIASQLDEV`

  Provides an interface to fetch and display all customer details via SQL Developer.

### 7. Updating Customer's YTD Sales

- **Procedure**: `UPD_CUST_SALESYTD_IN_DB`

  Updates the `SALES_YTD` for a customer with validation on the amount range.

- **Procedure**: `UPD_CUST_SALESYTD_VIASQLDEV`

  Provides an interface to update a customer’s YTD sales via SQL Developer.

### 8. Fetching Product Information

- **Function**: `GET_PROD_STRING_FROM_DB`

  Retrieves a product’s details in the format:
  Prodid: [ID] Name: [Name] Price: [Price] SalesYTD: [SalesYTD]

- **Procedure**: `GET_PROD_STRING_VIASQLDEV`

  Provides an interface to fetch and display product details via SQL Developer.

### 9. Fetching All Products
- **Function**: `GET_ALLPROD_FROM_DB`

  Retrieves all product details in the format:
  Prodid: [ID] Name: [Name] Price: [Price] SalesYTD: [SalesYTD]

- **Procedure**: `GET_ALLPROD_VIASQLDEV`

  Provides an interface to fetch and display all product details via SQL Developer.

### 10. Updating Product's YTD Sales

- **Procedure**: `UPD_PROD_SALESYTD_IN_DB`

  Updates the `SALES_YTD` for a product with validation on the amount range.

- **Procedure**: `UPD_PROD_SALESYTD_VIASQLDEV`

  Provides an interface to update a product’s YTD sales via SQL Developer.

### 11. Updating Customer Status

- **Procedure**: `UPD_CUST_STATUS_IN_DB`

  Updates the `STATUS` for a customer with validation on the status value.

- **Procedure**: `UPD_CUST_STATUS_VIASQLDEV`

  Provides an interface to update a customer’s status via SQL Developer.

### 12. Adding Locations

- **Procedure**: `ADD_LOCATION_TO_DB`
  
  Adds a location to the database. Validates the location ID and raises an error if the ID, Minimum Quantity, Maximum Quantity or Code Length is out of range .

- **Procedure**: `ADD_LOCATION_VIASQLDEV`
  
  Provides an interface to add locations via SQL Developer, handles commit, and outputs success or error messages.

### 13. Adding Complex Sale

- **Procedure**: `ADD_COMPLEX_SALE_TO_DB`

  Adds a complex sale, validates customer and product information, calculates sale price, and updates both customer and product sales YTD. Also validates the sale quantity and sale date.

- **Procedure**: `ADD_COMPLEX_SALE_VIASQLDEV`

  Provides an interface to add complex sales via SQL Developer with success or error messages. Handles the sale amount calculation.

### 14. Fetching All Sales

- **Function**: `GET_ALLSALES_FROM_DB`

  Retrieves all sale transactions, including the sale ID, customer ID, product ID, sale date, and sale price.

- **Procedure**: `GET_ALLSALES_VIASQLDEV`

  Provides an interface to fetch and display all sale transactions via SQL Developer.

### 15. Counting Product Sales Within a Time Period

- **Function**: `COUNT_PRODUCT_SALES_FROM_DB`

  Counts the total number of product sales made within a specific number of days from the current date.

- **Procedure**: `COUNT_PRODUCT_SALES_VIASQLDEV`

  Provides an interface to count product sales within a given time period via SQL Developer.

### 16. Deleting Sale

- **Function**: `DELETE_SALE_FROM_DB`

  Deletes the sale record with the smallest `SALEID` in the `SALE` table, updates both customer and product `SALES_YTD` based on the sale amount, and returns the deleted `SALEID`. If no sale exists, raises an exception.

- **Procedure**: `DELETE_SALE_VIASQLDEV`

  Provides an interface to delete the sale with the smallest `SALEID` via SQL Developer, displaying success or error messages. Commits the transaction if successful.

---

### 17. Deleting All Sales

- **Procedure**: `DELETE_ALL_SALES_FROM_DB`

  Deletes all sales records from the `SALE` table and resets the `SALES_YTD` values to zero for all customers and products. Ensures complete deletion and updates.

- **Procedure**: `DELETE_ALL_SALES_VIASQLDEV`

  Provides an interface to delete all sales and reset customer and product `SALES_YTD` via SQL Developer, displaying success or error messages. Commits the transaction if successful.


## Getting Started

### Prerequisites:
- Oracle Database setup.
- SQL Developer or any other PL/SQL development tool.

### Installation:
1. Clone the repository:
 ```bash
 git clone https://github.com/anukah/sales-management-system.git
```
2. Execute the schema.sql script given below to create the necessary tables.

```sql
DROP TABLE SALE CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE LOCATION CASCADE CONSTRAINTS;

CREATE TABLE CUSTOMER (
CUSTID	NUMBER
, CUSTNAME	VARCHAR2(100)
, SALES_YTD	NUMBER
, STATUS	VARCHAR2(7)
, PRIMARY KEY	(CUSTID) 
);

CREATE TABLE PRODUCT (
PRODID	NUMBER
, PRODNAME	VARCHAR2(100)
, SELLING_PRICE	NUMBER
, SALES_YTD	NUMBER
, PRIMARY KEY	(PRODID)
);


CREATE TABLE SALE (
SALEID	NUMBER
, CUSTID	NUMBER
, PRODID	NUMBER
, QTY	NUMBER
, PRICE	NUMBER
, SALEDATE	DATE
, PRIMARY KEY 	(SALEID)
, FOREIGN KEY 	(CUSTID) REFERENCES CUSTOMER
, FOREIGN KEY 	(PRODID) REFERENCES PRODUCT
);


CREATE TABLE LOCATION (
  LOCID	VARCHAR2(5)
, MINQTY	NUMBER
, MAXQTY	NUMBER
, PRIMARY KEY 	(LOCID)
, CONSTRAINT CHECK_LOCID_LENGTH CHECK (LENGTH(LOCID) = 5)
, CONSTRAINT CHECK_MINQTY_RANGE CHECK (MINQTY BETWEEN 0 AND 999)
, CONSTRAINT CHECK_MAXQTY_RANGE CHECK (MAXQTY BETWEEN 0 AND 999)
, CONSTRAINT CHECK_MAXQTY_GREATER_MIXQTY CHECK (MAXQTY >= MINQTY)
);

DROP SEQUENCE SALE_SEQ;
CREATE SEQUENCE SALE_SEQ;
```

3. Execute the PL/SQL scripts for functions and procedures.

### Usage 
1. Add new customers and products using the provided procedures.
2. Record sales transactions and update YTD sales.
3. Run the provided functions to fetch and sum up YTD sales.

### License
  This project is under MIT license
