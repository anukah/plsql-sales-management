CREATE OR REPLACE PROCEDURE ADD_COMPLEX_SALE_TO_DB (
    pcustid  NUMBER,
    pprodid  NUMBER,
    pqty     NUMBER,
    pdate    VARCHAR2
)
AS
    status     CUSTOMER.STATUS%TYPE;
    price      PRODUCT.SELLING_PRICE%TYPE;
    saleid     NUMBER;
    sale_date  DATE;
BEGIN
    IF pqty < 1 OR pqty > 999 THEN
        RAISE_APPLICATION_ERROR(-20231, 'Sale Quantity outside valid range');
    END IF;

    BEGIN
        sale_date := TO_DATE(pdate, 'YYYYMMDD');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20255, 'Date not valid');
    END;

    BEGIN
        SELECT STATUS INTO status
        FROM CUSTOMER
        WHERE CUSTID = pcustid;
        
        IF status != 'OK' THEN
            RAISE_APPLICATION_ERROR(-20243, 'Customer status is not OK');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20267, 'Customer ID not found');
    END;

    BEGIN
        SELECT SELLING_PRICE INTO price
        FROM PRODUCT
        WHERE PRODID = pprodid;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20279, 'Product ID not found');
    END;

    SELECT SALE_SEQ.NEXTVAL INTO saleid FROM DUAL;

    INSERT INTO SALE (SALEID, CUSTID, PRODID, QTY, PRICE, SALEDATE)
    VALUES (saleid, pcustid, pprodid, pqty, price * pqty, sale_date);

    UPD_CUST_SALESYTD_IN_DB(pcustid, pqty * price);
    UPD_PROD_SALESYTD_IN_DB(pprodid, pqty * price);

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END ADD_COMPLEX_SALE_TO_DB;
/

CREATE OR REPLACE PROCEDURE ADD_COMPLEX_SALE_VIASQLDEV (
    pcustid  NUMBER,
    pprodid  NUMBER,
    pqty     NUMBER,
    pdate    VARCHAR2
)
AS
    price     PRODUCT.SELLING_PRICE%TYPE;
    amount    NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    BEGIN
        SELECT SELLING_PRICE INTO price
        FROM PRODUCT
        WHERE PRODID = pprodid;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            RETURN;
    END;

    amount := pqty * price;

    DBMS_OUTPUT.PUT_LINE('Adding Complex Sale. Cust Id: ' || pcustid || ' Prod Id: ' || pprodid || ' Date: ' || pdate || ' Amt: ' || amount);

    BEGIN
        ADD_COMPLEX_SALE_TO_DB(pcustid, pprodid, pqty, pdate);
        DBMS_OUTPUT.PUT_LINE('Added Complex Sale OK');

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            ROLLBACK;
    END;

END ADD_COMPLEX_SALE_VIASQLDEV;
/