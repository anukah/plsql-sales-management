CREATE OR REPLACE FUNCTION GET_ALLPROD_FROM_DB
RETURN SYS_REFCURSOR
AS
    prod_cursor SYS_REFCURSOR;
BEGIN
    OPEN prod_cursor FOR
    SELECT PRODID, PRODNAME, SELLING_PRICE, SALES_YTD
    FROM PRODUCT;

    RETURN prod_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END GET_ALLPROD_FROM_DB;
/

CREATE OR REPLACE PROCEDURE GET_ALLPROD_VIASQLDEV
AS
    prod_cursor SYS_REFCURSOR;
    prodid PRODUCT.PRODID%TYPE;
    prodname PRODUCT.PRODNAME%TYPE;
    price PRODUCT.SELLING_PRICE%TYPE;
    sales_ytd PRODUCT.SALES_YTD%TYPE;
    found BOOLEAN := FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Listing All Product Details');
    
    prod_cursor := GET_ALLPROD_FROM_DB;

    LOOP
        FETCH prod_cursor INTO prodid, prodname, price, sales_ytd;
        EXIT WHEN prod_cursor%NOTFOUND;
        
        found := TRUE;

        DBMS_OUTPUT.PUT_LINE('Prodid: ' || prodid || ' Name: ' || prodname || 
                             ' Price: ' || TO_CHAR(price, '999.99') || 
                             ' SalesYTD: ' || TO_CHAR(sales_ytd, '99999.99'));
    END LOOP;

    IF NOT found THEN
        DBMS_OUTPUT.PUT_LINE('No rows found.');
    END IF;

    CLOSE prod_cursor;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END GET_ALLPROD_VIASQLDEV;
/