CREATE OR REPLACE PROCEDURE ADD_SIMPLE_SALE_TO_DB (
    pcustid NUMBER,
    pprodid NUMBER,
    pqty NUMBER
)
AS
    cust_status VARCHAR2(20);
    prod_price NUMBER(10, 2);
    total_sale_amount NUMBER(10, 2);
BEGIN
    IF pqty < 1 OR pqty > 999 THEN
        RAISE_APPLICATION_ERROR(-20141, 'Sale Quantity outside valid range');
    END IF;

    SELECT STATUS
    INTO cust_status
    FROM CUSTOMER
    WHERE CUSTID = pcustid;

    IF cust_status != 'OK' THEN
        RAISE_APPLICATION_ERROR(-20153, 'Customer status is not OK');
    END IF;

    SELECT SELLING_PRICE
    INTO prod_price
    FROM PRODUCT
    WHERE PRODID = pprodid;

    total_sale_amount := pqty * prod_price;

    UPD_CUST_SALESYTD_IN_DB(pcustid, total_sale_amount);
    UPD_PROD_SALESYTD_IN_DB(pprodid, total_sale_amount);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20165, 'Customer ID not found');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END ADD_SIMPLE_SALE_TO_DB;
/

CREATE OR REPLACE PROCEDURE ADD_SIMPLE_SALE_VIASQLDEV (
    pcustid NUMBER,
    pprodid NUMBER,
    pqty NUMBER
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Adding Simple Sale. Cust Id: ' || pcustid || ' Prod Id: ' || pprodid || ' Qty: ' || pqty);
    ADD_SIMPLE_SALE_TO_DB(pcustid, pprodid, pqty);

    DBMS_OUTPUT.PUT_LINE('Added Simple Sale OK');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END ADD_SIMPLE_SALE_VIASQLDEV;
/