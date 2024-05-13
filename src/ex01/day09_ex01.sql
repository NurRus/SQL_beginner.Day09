CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit() RETURNS TRIGGER AS
$trg_person_update_audit$
    BEGIN
        CASE TG_OP 
            WHEN 'UPDATE' THEN INSERT INTO person_audit VALUES (
                CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Moscow', 'U', new.id, new.name,
                new.age, new.gender, new.address);
            ELSE NULL;
        END CASE;
    RETURN coalesce(NEW, OLD);
    END;
$trg_person_update_audit$
LANGUAGE  plpgsql; 

CREATE OR REPLACE TRIGGER trg_person_update_audit
AFTER UPDATE
ON person 
FOR EACH ROW
EXECUTE PROCEDURE fnc_trg_person_update_audit();

UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;