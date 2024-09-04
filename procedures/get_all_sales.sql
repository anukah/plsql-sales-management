CREATE OR REPLACE FUNCTION GET_ALLSALES_FROM_DB
RETURN SYS_REFCURSOR
AS
    sales_cursor SYS_REFCURSOR;
BEGIN
    OPEN sales_cursor FOR
    SELECT SALEID, CUSTID, PRODID, SALEDATE, PRICE
    FROM SALE;

    RETURN sales_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END GET_ALLSALES_FROM_DB;
/

CREATE OR REPLACE PROCEDURE GET_ALLSALES_VIASQLDEV
AS
    sales_cursor SYS_REFCURSOR;
    saleid  SALE.SALEID%TYPE;
    custid  SALE.CUSTID%TYPE;
    prodid  SALE.PRODID%TYPE;
    saledate SALE.SALEDATE%TYPE;
    price   SALE.PRICE%TYPE;
    found   BOOLEAN := FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Listing All Complex Sales Details');
    
    sales_cursor := GET_ALLSALES_FROM_DB;

    LOOP
        FETCH sales_cursor INTO saleid, custid, prodid, saledate, price;
        EXIT WHEN sales_cursor%NOTFOUND;

        found := TRUE;

        DBMS_OUTPUT.PUT_LINE('Saleid: ' || saleid || ' Custid: ' || custid || ' Prodid: ' || prodid || ' Date: ' || TO_CHAR(saledate, 'DD MON YYYY') || ' Amount: ' || TO_CHAR(price, '9999.99'));
    END LOOP;

    IF NOT found THEN
        DBMS_OUTPUT.PUT_LINE('No rows found.');
    END IF;

    CLOSE sales_cursor;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END GET_ALLSALES_VIASQLDEV;
/