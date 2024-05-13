
CREATE OR REPLACE FUNCTION fnc_fibonacci (pstop INT DEFAULT 10)
    RETURNS SETOF INT
AS
$$
    DECLARE 
        vol1 INT := 0;
        vol2 INT := 1;
        buff INT;
        i INT := 1;
BEGIN
    RETURN NEXT vol1;
    RETURN NEXT vol2;
    WHILE vol2 < pstop
    loop
        buff := vol1 + vol2;
        vol1 := vol2;
        vol2 := buff;
        i := i + 1;
        IF (vol2 < pstop) THEN RETURN NEXT vol2;
        END IF;
    END loop;
END;
$$
LANGUAGE  plpgsql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();


select * from fnc_fibonacci(20);
 
