CREATE OR REPLACE PROCEDURE UPD_CUST_SALESYTD_IN_DB (
    pcustid NUMBER,
    pamt NUMBER
)
AS
    rows_updated NUMBER;
BEGIN
    IF pamt < -999.99 OR pamt > 999.99 THEN
        RAISE_APPLICATION_ERROR(-20083, 'Amount out of range');
    END IF;

    UPDATE CUSTOMER
    SET sales_ytd = sales_ytd + pamt
    WHERE custid = pcustid;

    rows_updated := SQL%ROWCOUNT;

    IF rows_updated = 0 THEN
        RAISE_APPLICATION_ERROR(-20071, 'Customer ID not found');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Unexpected Error: ' || SQLERRM);
END UPD_CUST_SALESYTD_IN_DB;
/

CREATE OR REPLACE PROCEDURE UPD_CUST_SALESYTD_VIASQLDEV (
    pcustid NUMBER,
    pamt NUMBER
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Updating SalesYTD. Customer Id: ' || pcustid || ' Amount: ' || TO_CHAR(pamt, '999.99'));
    UPD_CUST_SALESYTD_IN_DB(pcustid, pamt);

    DBMS_OUTPUT.PUT_LINE('Update OK');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UPD_CUST_SALESYTD_VIASQLDEV;
/