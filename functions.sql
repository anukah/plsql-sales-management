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