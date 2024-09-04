CREATE OR REPLACE PROCEDURE ADD_PRODUCT_TO_DB (
    pprodid NUMBER,
    pprodname VARCHAR2,
    pprice NUMBER
)
AS 
BEGIN
    IF pprodid < 1000 OR pprodid > 2500 THEN
        RAISE_APPLICATION_ERROR(-20043, 'Product ID out of range');
    END IF;

    IF pprice < 0 OR pprice > 999.99 THEN
        RAISE_APPLICATION_ERROR(-20055, 'Price out of range');
    END IF;

    BEGIN
        INSERT INTO PRODUCT (PRODID, PRODNAME, SELLING_PRICE, SALES_YTD)
        VALUES(pprodid, pprodname, pprice, 0);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20031, 'Duplicate product ID');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000, SQLERRM);
    END;
END ADD_PRODUCT_TO_DB;
/

CREATE OR REPLACE PROCEDURE ADD_PRODUCT_VIASQLDEV(
    pprodid NUMBER,
    pprodname VARCHAR2,
    pprice NUMBER
) 
AS BEGIN
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');

    DBMS_OUTPUT.PUT_LINE('Adding Product. ID: ' || pprodid || ' Name: ' || pprodname || ' Price: ' || pprice);
    
    BEGIN
        ADD_PRODUCT_TO_DB(pprodid, pprodname, pprice);

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Product Added OK');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

END ADD_PRODUCT_VIASQLDEV;
/