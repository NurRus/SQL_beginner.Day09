CREATE TABLE person_audit (
    created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type_event char(1) DEFAULT 'I' NOT NULL,
    row_id bigint NOT NULL,
    name varchar,
    age integer,
    gender varchar,
    address varchar,
    constraint ch_type_event check(type_event IN ('I', 'U', 'D'))
);

CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit() RETURNS TRIGGER AS
$trg_person_insert_audit$
    BEGIN
        CASE TG_OP 
            WHEN 'INSERT' THEN INSERT INTO person_audit VALUES (
                CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Moscow', 'I', new.id, new.name,
                new.age, new.gender, new.address);
            ELSE NULL;
        END CASE;
    RETURN coalesce(NEW, OLD);
    END;
$trg_person_insert_audit$
LANGUAGE  plpgsql; 

CREATE OR REPLACE TRIGGER trg_person_insert_audit
AFTER INSERT
ON person 
FOR EACH ROW
EXECUTE PROCEDURE fnc_trg_person_insert_audit();

INSERT INTO person VALUES(10,'Damir', 22, 'male', 'Irkutsk');