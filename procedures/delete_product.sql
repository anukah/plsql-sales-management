CREATE OR REPLACE PROCEDURE DELETE_PROD_FROM_DB (
    pProdid NUMBER
)
AS
    e EXCEPTION;
    PRAGMA EXCEPTION_INIT(e, -2292);
BEGIN
    DELETE FROM PRODUCT
    WHERE PRODID = pProdid;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20311, 'Product ID not found');
    END IF;

EXCEPTION
    WHEN e THEN
        RAISE_APPLICATION_ERROR(-20323, 'Product cannot be deleted as sales exist');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END DELETE_PROD_FROM_DB;
/

CREATE OR REPLACE PROCEDURE DELETE_PROD_VIASQLDEV (
    pProdid NUMBER
)
AS
BEGIN

    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Deleting Product. Product Id: ' || pProdid);

    DELETE_PROD_FROM_DB(pProdid);

    DBMS_OUTPUT.PUT_LINE('Deleted Product OK.');

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END DELETE_PROD_VIASQLDEV;
/

BEGIN
    DELETE_CUSTOMER_VIASQLDEV(3);  -- Replace 123 with an actual customer ID
END;
/
BEGIN
    DELETE_PROD_VIASQLDEV(1001);  -- Replace 1001 with an actual product ID
END;
/