DROP FUNCTION fnc_persons_male();

DROP FUNCTION fnc_persons_female();

CREATE OR REPLACE FUNCTION fnc_persons(pgender VARCHAR DEFAULT 'female')
     RETURNS TABLE
        (
            id bigint,
            name varchar,
            age int,
            gender varchar,
            address varchar
        )
AS
$$
SELECT * FROM person WHERE gender LIKE pgender;
$$
LANGUAGE sql;

select *
from fnc_persons(pgender := 'male');

select *
from fnc_persons();
