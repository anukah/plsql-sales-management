CREATE OR REPLACE FUNCTION DELETE_SALE_FROM_DB
RETURN NUMBER
AS
    min_saleid  SALE.SALEID%TYPE;
    custid      SALE.CUSTID%TYPE;
    prodid      SALE.PRODID%TYPE;
    qty         SALE.QTY%TYPE;
    price       SALE.PRICE%TYPE;
    total_amount NUMBER;
BEGIN
    SELECT MIN(SALEID) INTO min_saleid
    FROM SALE;

    IF min_saleid IS NULL THEN
        RAISE_APPLICATION_ERROR(-20281, 'No Sale Rows Found');
    END IF;

    SELECT CUSTID, PRODID, QTY, PRICE
    INTO custid, prodid, qty, price
    FROM SALE
    WHERE SALEID = min_saleid;

    total_amount := qty * price;

    DELETE FROM SALE
    WHERE SALEID = min_saleid;

    UPD_CUST_SALESYTD_IN_DB(custid, total_amount);
    UPD_PROD_SALESYTD_IN_DB(prodid, total_amount);

    RETURN min_saleid;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END DELETE_SALE_FROM_DB;
/
CREATE OR REPLACE PROCEDURE DELETE_SALE_VIASQLDEV
AS
    saleid NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Deleting Sale with smallest SaleId value');

    saleid := DELETE_SALE_FROM_DB;

    DBMS_OUTPUT.PUT_LINE('Deleted Sale OK. SaleID: ' || saleid);

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END DELETE_SALE_VIASQLDEV;
/