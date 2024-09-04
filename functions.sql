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