CREATE OR REPLACE PROCEDURE ADD_LOCATION_TO_DB (
    ploccode VARCHAR2,
    pminqty  NUMBER,
    pmaxqty  NUMBER
)
AS
BEGIN
    IF LENGTH(ploccode) != 5 THEN
        RAISE_APPLICATION_ERROR(-20193, 'Location Code length invalid');
    END IF;

    IF pminqty < 0 OR pminqty > 999 THEN
        RAISE_APPLICATION_ERROR(-20205, 'Minimum Qty out of range');
    END IF;

    IF pmaxqty < 0 OR pmaxqty > 999 THEN
        RAISE_APPLICATION_ERROR(-20217, 'Maximum Qty out of range');
    END IF;

    IF pminqty > pmaxqty THEN
        RAISE_APPLICATION_ERROR(-20229, 'Minimum Qty larger than Maximum Qty');
    END IF;

    BEGIN
        INSERT INTO LOCATION (LOCID, MINQTY, MAXQTY)
        VALUES (ploccode, pminqty, pmaxqty);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20181, 'Duplicate location ID');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
    END;

END ADD_LOCATION_TO_DB;
/

CREATE OR REPLACE PROCEDURE ADD_LOCATION_VIASQLDEV (
    ploccode VARCHAR2,
    pminqty  NUMBER,
    pmaxqty  NUMBER
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Adding Location LocCode: ' || ploccode || 
                         ' MinQty: ' || pminqty || 
                         ' MaxQty: ' || pmaxqty);

    ADD_LOCATION_TO_DB(ploccode, pminqty, pmaxqty);
    
    DBMS_OUTPUT.PUT_LINE('Location Added OK');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END ADD_LOCATION_VIASQLDEV;
/
