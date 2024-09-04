# plsql-sales-management
# Database Structure

## Tables

---

### 1. CUSTOMER
The `CUSTOMER` table stores information about the customers.

| Column Name | Data Type   | Description                       |
|-------------|-------------|-----------------------------------|
| `CUSTID`    | NUMBER      | Primary Key, Unique Customer ID   |
| `CUSTNAME`  | VARCHAR2(50)| Customer's Full Name              |
| `STATUS`    | VARCHAR2(20)| Customer Status ('OK', 'SUSPEND') |
| `SALES_YTD` | NUMBER(10,2)| Year-to-Date Sales Amount         |

---

### 2. PRODUCT
The `PRODUCT` table stores information about products available for sale.

| Column Name     | Data Type   | Description                         |
|-----------------|-------------|-------------------------------------|
| `PRODID`        | NUMBER      | Primary Key, Unique Product ID      |
| `PRODNAME`      | VARCHAR2(50)| Name of the Product                 |
| `SELLING_PRICE` | NUMBER(10,2)| Price of the Product                |
| `SALES_YTD`     | NUMBER(10,2)| Year-to-Date Sales Amount for Product|

---

### 3. SALES
The `SALES` table stores details of each sale transaction.

| Column Name  | Data Type   | Description                          |
|--------------|-------------|--------------------------------------|
| `SALEID`     | NUMBER      | Primary Key, Unique Sale ID          |
| `CUSTID`     | NUMBER      | Foreign Key, References `CUSTOMER`   |
| `PRODID`     | NUMBER      | Foreign Key, References `PRODUCT`    |
| `SALE_QTY`   | NUMBER      | Quantity of Product Sold             |
| `SALE_TOTAL` | NUMBER(10,2)| Total Sale Amount (Qty * Product Price) |

---

## PL/SQL Functions and Procedures

---

### Functions

1. **GET_CUST_STRING_FROM_DB(pcustid NUMBER)**:
   - Retrieves a customer’s details in the format:
     ```
     Custid: 999 Name: XXXXXXXXXX Status: XXXXXXX SalesYTD: 99999.99
     ```

2. **GET_PROD_STRING_FROM_DB(pprodid NUMBER)**:
   - Retrieves a product’s details in the format:
     ```
     Prodid: 999 Name: XXXXXXXXXX Price: 999.99 SalesYTD: 99999.99
     ```

3. **SUM_CUST_SALESYTD() RETURN NUMBER**:
   - Returns the total sum of all customer `SalesYTD` values.

4. **SUM_PROD_SALESYTD_FROM_DB() RETURN NUMBER**:
   - Returns the total sum of all product `SalesYTD` values.

---

### Procedures

1. **ADD_CUSTOMER_VIASQLDEV(pcustid NUMBER, pcustname VARCHAR2)**:
   - Adds a new customer to the `CUSTOMER` table.
   
2. **ADD_PRODUCT_VIASQLDEV(pprodid NUMBER, pprodname VARCHAR2, pprice NUMBER)**:
   - Adds a new product to the `PRODUCT` table.

3. **UPD_CUST_STATUS_VIASQLDEV(pcustid NUMBER, pstatus VARCHAR2)**:
   - Updates the status of a customer.

4. **UPD_CUST_SALESYTD_IN_DB(pcustid NUMBER, pamt NUMBER)**:
   - Updates the `SALES_YTD` value of a customer by adding the provided amount.

5. **UPD_PROD_SALESYTD_IN_DB(pprodid NUMBER, pamt NUMBER)**:
   - Updates the `SALES_YTD` value of a product by adding the provided amount.

6. **ADD_SIMPLE_SALE_VIASQLDEV(pcustid NUMBER, pprodid NUMBER, pqty NUMBER)**:
   - Adds a sale record, updates both the customer and product `SALES_YTD`.

7. **SUM_CUST_SALES_VIASQLDEV**:
   - Calls `SUM_CUST_SALESYTD` and prints the total customer sales.

8. **SUM_PROD_SALES_VIASQLDEV**:
   - Calls `SUM_PROD_SALESYTD_FROM_DB` and prints the total product sales.

---

## Relationships

- The `CUSTOMER` and `PRODUCT` tables are linked through the `SALES` table.
- The `SALES` table contains foreign keys `CUSTID` (references `CUSTOMER`) and `PRODID` (references `PRODUCT`).

---

## SQL Schema Example

```sql
CREATE TABLE CUSTOMER (
    CUSTID NUMBER PRIMARY KEY,
    CUSTNAME VARCHAR2(50),
    STATUS VARCHAR2(20) CHECK (STATUS IN ('OK', 'SUSPEND')),
    SALES_YTD NUMBER(10, 2) DEFAULT 0
);

CREATE TABLE PRODUCT (
    PRODID NUMBER PRIMARY KEY,
    PRODNAME VARCHAR2(50),
    SELLING_PRICE NUMBER(10, 2),
    SALES_YTD NUMBER(10, 2) DEFAULT 0
);

CREATE TABLE SALES (
    SALEID NUMBER PRIMARY KEY,
    CUSTID NUMBER REFERENCES CUSTOMER(CUSTID),
    PRODID NUMBER REFERENCES PRODUCT(PRODID),
    SALE_QTY NUMBER,
    SALE_TOTAL NUMBER(10, 2)
);
