--add customer to database
CREATE OR REPLACE PROCEDURE ADD_CUST_TO_DB (
    pcustid NUMBER,
    pcustname VARCHAR2
)
AS
BEGIN
    IF pcustid < 1 OR pcustid > 499 THEN
        RAISE_APPLICATION_ERROR(-20023, 'Customer ID out of range');
    END IF;

    BEGIN
        INSERT INTO Customer (custid, custname, sales_ytd, status)
        VALUES (pcustid, pcustname, 0, 'OK');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20011, 'Duplicate customer ID');
    
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000, SQLERRM);
    END; 
END ADD_CUST_TO_DB;
/

--add costumer as dev
CREATE OR REPLACE PROCEDURE ADD_CUSTOMER_VIASQLDEV (
    pcustid   IN NUMBER,
    pcustname IN VARCHAR2
)
AS
BEGIN

    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');

    DBMS_OUTPUT.PUT_LINE('Adding Customer. ID: ' || pcustid || ' Name: ' || pcustname);

    BEGIN
        ADD_CUST_TO_DB(pcustid, pcustname);

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Customer Added OK');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

END ADD_CUSTOMER_VIASQLDEV;
/

--delete costumer from database
CREATE OR REPLACE FUNCTION DELETE_ALL_CUSTOMERS_FROM_DB
RETURN NUMBER AS
  deleted_rows NUMBER;
  
BEGIN

  DELETE FROM CUSTOMER;
  deleted_rows := SQL%ROWCOUNT;
  COMMIT;

  RETURN deleted_rows;
  
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, SQLERRM);
END DELETE_ALL_CUSTOMERS_FROM_DB;
/

--delete costumer as dev
CREATE OR REPLACE PROCEDURE DELETE_ALL_CUSTOMERS_VIASQLDEV
AS
  deleted_rows NUMBER;
  
BEGIN
 DBMS_OUTPUT.PUT_LINE('------------------------------');
 DBMS_OUTPUT.PUT_LINE('Deleting all Customer rows');
 
 deleted_rows := DELETE_ALL_CUSTOMERS_FROM_DB;
 
  DBMS_OUTPUT.PUT_LINE(deleted_rows || ' rows deleted');

EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM);
  
END DELETE_ALL_CUSTOMERS_VIASQLDEV;
/

--add product to database
CREATE OR REPLACE PROCEDURE ADD_PRODUCT_TO_DB (
    pprodid NUMBER,
    pprodname VARCHAR2,
    pprice NUMBER
)
AS 
BEGIN
    IF pprodid < 1000 OR pprodid > 2500 THEN
        RAISE_APPLICATION_ERROR(-20043, 'Product ID out of range');
    END IF;

    IF pprice < 0 OR pprice > 999.99 THEN
        RAISE_APPLICATION_ERROR(-20055, 'Price out of range');
    END IF;

    BEGIN
        INSERT INTO PRODUCT (PRODID, PRODNAME, SELLING_PRICE, SALES_YTD)
        VALUES(pprodid, pprodname, pprice, 0);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20031, 'Duplicate product ID');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000, SQLERRM);
    END;
END ADD_PRODUCT_TO_DB;
/

--add product to database as dev
CREATE OR REPLACE PROCEDURE ADD_PRODUCT_VIASQLDEV(
    pprodid NUMBER,
    pprodname VARCHAR2,
    pprice NUMBER
) 
AS BEGIN
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');

    DBMS_OUTPUT.PUT_LINE('Adding Product. ID: ' || pprodid || ' Name: ' || pprodname || ' Price: ' || pprice);
    
    BEGIN
        ADD_PRODUCT_TO_DB(pprodid, pprodname, pprice);

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Product Added OK');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

END ADD_PRODUCT_VIASQLDEV;
/

--delete product from database
CREATE OR REPLACE FUNCTION DELETE_ALL_PRODUCTS_FROM_DB
RETURN NUMBER AS
  deleted_rows NUMBER;
  
BEGIN

  DELETE FROM PRODUCT;
  deleted_rows := SQL%ROWCOUNT;
  COMMIT;

  RETURN deleted_rows;
  
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, SQLERRM);
END DELETE_ALL_PRODUCTS_FROM_DB;
/

--delete product from database as dev
CREATE OR REPLACE PROCEDURE DELETE_ALL_PRODUCTS_VIASQLDEV
AS
  deleted_rows NUMBER;
  
BEGIN
 DBMS_OUTPUT.PUT_LINE('------------------------------');
 DBMS_OUTPUT.PUT_LINE('Deleting all Products rows');
 
 deleted_rows := DELETE_ALL_PRODUCTS_FROM_DB;
 
  DBMS_OUTPUT.PUT_LINE(deleted_rows || ' rows deleted');

EXCEPTION
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM);
  
END DELETE_ALL_PRODUCTS_VIASQLDEV;
/

--get custom string from database
CREATE OR REPLACE FUNCTION GET_CUST_STRING_FROM_DB (
    pcustid NUMBER
)
RETURN VARCHAR2
AS
    name VARCHAR2(50);
    status VARCHAR2(20);
    sales_ytd NUMBER(10, 2);

BEGIN
    SELECT CUSTOMER.CUSTNAME, CUSTOMER.STATUS, CUSTOMER.SALES_YTD
    INTO name, status, sales_ytd
    FROM CUSTOMER
    WHERE CUSTID = pcustid;

    RETURN 'Custid: ' || pcustid || ' Name: ' || name || ' Status: ' || status || ' SalesYTD: ' || TO_CHAR(sales_ytd, '999.99');

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20061, 'Customer ID not found');
    
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END GET_CUST_STRING_FROM_DB;
/

--get custom string from database as dev
CREATE OR REPLACE PROCEDURE GET_CUST_STRING_VIASQLDEV (
    pcustid NUMBER
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('------------------------------');
    DBMS_OUTPUT.PUT_LINE('Getting Details for CustId ' || pcustid);
    DBMS_OUTPUT.PUT_LINE(GET_CUST_STRING_FROM_DB(pcustid));

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END GET_CUST_STRING_VIASQLDEV;
/

--get custom sales ytd from database
CREATE OR REPLACE PROCEDURE UPD_CUST_SALESYTD_IN_DB (
    pcustid NUMBER,
    pamt NUMBER
)
AS
    rows_updated NUMBER;
BEGIN
    IF pamt < -999.99 OR pamt > 999.99 THEN
        RAISE_APPLICATION_ERROR(-20083, 'Amount out of range');
    END IF;

    UPDATE CUSTOMER
    SET sales_ytd = sales_ytd + pamt
    WHERE custid = pcustid;

    rows_updated := SQL%ROWCOUNT;

    IF rows_updated = 0 THEN
        RAISE_APPLICATION_ERROR(-20071, 'Customer ID not found');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Unexpected Error: ' || SQLERRM);
END UPD_CUST_SALESYTD_IN_DB;
/

--get custom sales ytd from database as dev
CREATE OR REPLACE PROCEDURE UPD_CUST_SALESYTD_VIASQLDEV (
    pcustid NUMBER,
    pamt NUMBER
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Updating SalesYTD. Customer Id: ' || pcustid || ' Amount: ' || TO_CHAR(pamt, '999.99'));
    UPD_CUST_SALESYTD_IN_DB(pcustid, pamt);

    DBMS_OUTPUT.PUT_LINE('Update OK');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UPD_CUST_SALESYTD_VIASQLDEV;
/