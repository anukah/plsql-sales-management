CREATE OR REPLACE PROCEDURE UPD_CUST_STATUS_IN_DB (
    pcustid NUMBER,
    pstatus VARCHAR2
)
AS
    rows_updated NUMBER;
BEGIN
    IF pstatus NOT IN ('OK', 'SUSPEND') OR pstatus IS NULL OR TRIM(pstatus) = '' THEN
        RAISE_APPLICATION_ERROR(-20133, 'Invalid Status value');
    END IF;

    UPDATE CUSTOMER
    SET STATUS = pstatus
    WHERE CUSTID = pcustid;

    rows_updated := SQL%ROWCOUNT;

    IF rows_updated = 0 THEN
        RAISE_APPLICATION_ERROR(-20121, 'Customer ID not found');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END UPD_CUST_STATUS_IN_DB;
/

CREATE OR REPLACE PROCEDURE UPD_CUST_STATUS_VIASQLDEV (
    pcustid NUMBER,
    pstatus VARCHAR2
)
AS
BEGIN

    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Updating Status. Id: ' || pcustid || ' New Status: ' || pstatus);
    UPD_CUST_STATUS_IN_DB(pcustid, pstatus);

    DBMS_OUTPUT.PUT_LINE('Update OK');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UPD_CUST_STATUS_VIASQLDEV;
/