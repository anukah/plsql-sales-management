CREATE OR REPLACE FUNCTION SUM_CUST_SALESYTD
RETURN NUMBER
AS
    total_sales NUMBER;
BEGIN
    SELECT NVL(SUM(SALES_YTD), 0) INTO total_sales FROM CUSTOMER;
    RETURN total_sales;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END SUM_CUST_SALESYTD;
/

--get total sum of customer sales ytd as dev
CREATE OR REPLACE PROCEDURE SUM_CUST_SALES_VIASQLDEV
AS
    total_sales NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Summing Customer SalesYTD');
    total_sales := SUM_CUST_SALESYTD;

    DBMS_OUTPUT.PUT_LINE('All Customer Total: ' || TO_CHAR(total_sales, '99999.99'));

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END SUM_CUST_SALES_VIASQLDEV;
/