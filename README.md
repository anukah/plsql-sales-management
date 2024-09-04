# Sales Management System

## Overview

This project is a basic sales management system built with Oracle SQL and PL/SQL. It manages customers, products, sales transactions, and inventory location management, while calculating year-to-date (YTD) sales figures for both customers and products.

## Database Structure

The database consists of four primary tables:

1. **CUSTOMER**: Stores customer details, including name, status, and YTD sales.
2. **PRODUCT**: Stores product details, such as name, price, and YTD sales.
3. **SALE**: Tracks individual sales, connecting customers and products with the quantity sold and total sale amount.
4. **LOCATION**: Manages inventory locations with minimum and maximum quantity constraints.

### Relationships:
- The `SALE` table links the `CUSTOMER` and `PRODUCT` tables via foreign keys (`CUSTID` and `PRODID`).
- The `LOCATION` table defines storage locations with minimum and maximum inventory constraints.

### Table Definitions:

#### CUSTOMER
| Column Name | Data Type     | Description                       |
|-------------|---------------|-----------------------------------|
| `CUSTID`    | NUMBER        | Primary Key, Unique Customer ID   |
| `CUSTNAME`  | VARCHAR2(100) | Customer's Full Name              |
| `STATUS`    | VARCHAR2(7)   | Customer Status                   |
| `SALES_YTD` | NUMBER        | Year-to-Date Sales Amount         |

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
| `CHECK_MAXQTY_GREATER_MIXQTY` | Ensures `MAXQTY` is greater than or equal to `MINQTY` |

## PL/SQL Functions and Procedures

### Functions:
- `GET_CUST_STRING_FROM_DB(pcustid NUMBER)`: Fetches customer details in a formatted string.
- `GET_PROD_STRING_FROM_DB(pprodid NUMBER)`: Fetches product details in a formatted string.
- `SUM_CUST_SALESYTD()`: Returns the total YTD sales for all customers.
- `SUM_PROD_SALESYTD_FROM_DB()`: Returns the total YTD sales for all products.

### Procedures:
- `ADD_CUSTOMER_VIASQLDEV(pcustid NUMBER, pcustname VARCHAR2)`: Adds a new customer.
- `ADD_PRODUCT_VIASQLDEV(pprodid NUMBER, pprodname VARCHAR2, pprice NUMBER)`: Adds a new product.
- `UPD_CUST_STATUS_VIASQLDEV(pcustid NUMBER, pstatus VARCHAR2)`: Updates customer status.
- `UPD_CUST_SALESYTD_IN_DB(pcustid NUMBER, pamt NUMBER)`: Updates customer YTD sales.
- `UPD_PROD_SALESYTD_IN_DB(pprodid NUMBER, pamt NUMBER)`: Updates product YTD sales.
- `ADD_SIMPLE_SALE_VIASQLDEV(pcustid NUMBER, pprodid NUMBER, pqty NUMBER)`: Adds a sale and updates YTD sales for both customer and product.

## Sequences

- **SALE_SEQ**: A sequence used to generate unique `SALEID` values for the `SALE` table.

## Getting Started

### Prerequisites:
- Oracle Database setup.
- SQL Developer or any other PL/SQL development tool.

### Installation:
1. Clone the repository: 
   ```bash
   git clone https://github.com/anukah/sales-management-system.git
