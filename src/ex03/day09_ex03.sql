DROP TRIGGER trg_person_insert_audit ON person;
DROP TRIGGER trg_person_update_audit ON person;
DROP TRIGGER trg_person_delete_audit ON person;

DROP FUNCTION fnc_trg_person_insert_audit;
DROP FUNCTION fnc_trg_person_update_audit;
DROP FUNCTION fnc_trg_person_delete_audit;

DELETE FROM person_audit;

CREATE OR REPLACE FUNCTION fnc_trg_person_audit() RETURNS TRIGGER AS
$trg_person_audit$
    BEGIN
        CASE TG_OP 
            WHEN 'INSERT' THEN INSERT INTO person_audit VALUES (
                CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Moscow', 'I', new.id, new.name,
                new.age, new.gender, new.address);
            WHEN 'UPDATE' THEN INSERT INTO person_audit VALUES (
                CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Moscow', 'U', new.id, new.name,
                new.age, new.gender, new.address);
            WHEN 'DELETE' THEN INSERT INTO person_audit VALUES (
                CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Moscow', 'D', old.id, old.name,
                old.age, old.gender, old.address);
            ELSE NULL;
        END CASE;
    RETURN coalesce(NEW, OLD);
    END;
$trg_person_audit$
LANGUAGE  plpgsql; 

CREATE OR REPLACE TRIGGER trg_person_audit
AFTER INSERT OR UPDATE OR DELETE
ON person 
FOR EACH ROW
EXECUTE PROCEDURE fnc_trg_person_audit();

INSERT INTO person(id, name, age, gender, address)
    VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;

