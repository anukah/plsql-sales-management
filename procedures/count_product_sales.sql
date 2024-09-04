CREATE OR REPLACE FUNCTION COUNT_PRODUCT_SALES_FROM_DB (
    pdays NUMBER
)
RETURN NUMBER
AS
    sale_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO sale_count
    FROM SALE
    WHERE SALEDATE >= TRUNC(SYSDATE) - pdays;

    RETURN sale_count;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM);
END COUNT_PRODUCT_SALES_FROM_DB;
/

CREATE OR REPLACE PROCEDURE COUNT_PRODUCT_SALES_VIASQLDEV (
    pdays NUMBER
)
AS
    sale_count NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Counting sales within ' || pdays || ' days');

    sale_count := COUNT_PRODUCT_SALES_FROM_DB(pdays);

    DBMS_OUTPUT.PUT_LINE('Total number of sales: ' || sale_count);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END COUNT_PRODUCT_SALES_VIASQLDEV;
/