CREATE OR REPLACE PROCEDURE UPD_PROD_SALESYTD_IN_DB (
    pprodid NUMBER,
    pamt NUMBER
)
AS
    rows_updated NUMBER;
BEGIN
    IF pamt < -999.99 OR pamt > 999.99 THEN
        RAISE_APPLICATION_ERROR(-20113, 'Amount out of range');
    END IF;

    UPDATE PRODUCT
    SET sales_ytd = sales_ytd + pamt
    WHERE PRODID = pprodid;
    
    rows_updated := SQL%ROWCOUNT;
    
    IF rows_updated = 0 THEN
        RAISE_APPLICATION_ERROR(-20101, 'Product ID not found');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, SQLERRM);
END UPD_PROD_SALESYTD_IN_DB;
/

CREATE OR REPLACE PROCEDURE UPD_PROD_SALESYTD_VIASQLDEV (
    pprodid NUMBER,
    pamt NUMBER
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Updating SalesYTD Product Id: ' || pprodid || ' Amount: ' || TO_CHAR(pamt, '9999.99'));
    UPD_PROD_SALESYTD_IN_DB(pprodid, pamt);

    DBMS_OUTPUT.PUT_LINE('Update OK');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UPD_PROD_SALESYTD_VIASQLDEV;
/