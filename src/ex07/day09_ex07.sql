CREATE OR REPLACE FUNCTION func_minimum (VARIADIC ARR NUMERIC[])
    RETURNS NUMERIC
AS
$$
SELECT MIN(n) FROM unnest(VARIADIC ARR) AS n;
$$
LANGUAGE sql;

SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);