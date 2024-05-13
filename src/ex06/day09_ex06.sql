CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
        pperson VARCHAR DEFAULT 'Dmitriy',
        pprice BIGINT DEFAULT 500,
        pdate date DEFAULT '2022-01-08')
        RETURNS TABLE (pizzeria_name VARCHAR)
AS
$$
    SELECT DISTINCT pz.name AS pizzeria_name FROM pizzeria pz
    JOIN person_visits pv ON pv.pizzeria_id = pz.id
    JOIN menu ON menu.pizzeria_id = pz.id
    JOIN person pr ON pr.id = pv.person_id
    WHERE
        price < pprice AND pr.name = pperson AND visit_date = pdate;
$$
LANGUAGE sql;

select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');


