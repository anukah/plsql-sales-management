CREATE OR REPLACE PROCEDURE DELETE_ALL_SALES_FROM_DB
AS
BEGIN
    DELETE FROM SALE;

    UPDATE CUSTOMER
    SET SALES_YTD = 0;

    UPDATE PRODUCT
    SET SALES_YTD = 0;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END DELETE_ALL_SALES_FROM_DB;
/

CREATE OR REPLACE PROCEDURE DELETE_ALL_SALES_VIASQLDEV
AS
BEGIN

    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Deleting all Sales data in Sale, Customer, and Product tables');

    DELETE_ALL_SALES_FROM_DB;

    DBMS_OUTPUT.PUT_LINE('Deletion OK');

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END DELETE_ALL_SALES_VIASQLDEV;
/