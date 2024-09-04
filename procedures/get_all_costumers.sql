CREATE OR REPLACE FUNCTION GET_ALLCUST
RETURN SYS_REFCURSOR
AS
    cust_cursor SYS_REFCURSOR;
BEGIN
    OPEN cust_cursor FOR
    SELECT CUSTID, CUSTNAME, STATUS, SALES_YTD
    FROM CUSTOMER;

    RETURN cust_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END GET_ALLCUST;
/

CREATE OR REPLACE PROCEDURE GET_ALLCUST_VIASQLDEV
AS
    cust_cursor SYS_REFCURSOR;
    custid CUSTOMER.CUSTID%TYPE;
    custname CUSTOMER.CUSTNAME%TYPE;
    status CUSTOMER.STATUS%TYPE;
    sales_ytd CUSTOMER.SALES_YTD%TYPE;
    found BOOLEAN:= FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Listing All Customer Details');
    
    cust_cursor := GET_ALLCUST;

    LOOP
        FETCH cust_cursor INTO custid, custname, status, sales_ytd;
        EXIT WHEN cust_cursor%NOTFOUND;
        found := TRUE;
        
        DBMS_OUTPUT.PUT_LINE('Custid: ' || custid || ' Name: ' || custname || 
                             ' Status: ' || status || ' SalesYTD: ' || TO_CHAR(sales_ytd, '99999.99'));
    END LOOP;

    IF NOT found THEN
        DBMS_OUTPUT.PUT_LINE('No rows found.');
    END IF;

    CLOSE cust_cursor;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END GET_ALLCUST_VIASQLDEV;
/