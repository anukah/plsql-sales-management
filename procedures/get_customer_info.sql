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