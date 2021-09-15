CREATE TABLE workers

(
worker_id CHAR(3) ,
worker_name VARCHAR(50) ,
worker_salary NUMBER(5) ,
CONSTRAINT worker_ID_PK PRIMARY KEY(worker_id)
);

INSERT INTO workers VALUES('111','ADEM', 2500);
INSERT INTO workers VALUES('113','EDEM', 2600);
INSERT INTO workers VALUES('115','DEDEM', 2700);
INSERT INTO workers VALUES('117','BADEM', 2800);


SELECT * FROM workers;

UPDATE workers
SET worker_salary = (SELECT MAX(worker_salary)*0.80 FROM workers)
WHERE worker_id = '115';

UPDATE workers
SET worker_salary = worker_salary + 1000
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);

SELECT * FROM workers;

UPDATE workers
SET worker_salary = (SELECT AVG(worker_salary) FROM workers)
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);

SELECT * FROM workers;

================================================================================


CREATE TABLE people
(
ssn CHAR(9),
name VARCHAR2(50),
adress VARCHAR2(80)
);

INSERT INTO people VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES (345678901, 'Marry Tien', 'New Jersey');
INSERT INTO people(ssn, adress) VALUES (456789012,  'Michigan');
INSERT INTO people(ssn, adress) VALUES (567890123, 'California');
INSERT INTO people(ssn, name) VALUES (678901234,'California');

SELECT * FROM people;

UPDATE people
SET name = 'This name will be inserted later'
WHERE name IS NULL;

UPDATE people
SET name = COALESCE(name, 'to be inserted later'),
    adress = COALESCE(adress, 'to be inserted later');
    
    
================================================================================

DELETE FROM people
WHERE ssn = '234567890';

SELECT * FROM people;

DELETE FROM people
WHERE name IS NOT NULL AND adress IS NOT NULL;

DROP TABLE people;

DROP TABLE workers PURGE;

================================================================================
CREATE TABLE workers

(
worker_id CHAR(3) ,
worker_name VARCHAR(50) ,
worker_salary NUMBER(5) ,
CONSTRAINT worker_ID_PK PRIMARY KEY(worker_id)
);

INSERT INTO workers VALUES('111','ADEM', 2500);
INSERT INTO workers VALUES('113','EDEM', 2600);
INSERT INTO workers VALUES('115','DEDEM', 2700);
INSERT INTO workers VALUES('117','BADEM', 2800);

SELECT * FROM workers WHERE worker_id = '117'; 

SELECT * FROM workers WHERE worker_id < 118; 

SELECT * FROM workers WHERE worker_salary IN(2500,2600,2700); 

SELECT worker_name FROM workers WHERE worker_id = '117';


SELECT * FROM workers WHERE worker_salary = (SELECT MAX (worker_salary) FROM workers);

SELECT MAX(worker_salary) FROM workers;


SELECT MAX(worker_salary) AS maximum_salary FROM workers;

SELECT COUNT(worker_name) FROM workers;

SELECT SUM(worker_salary) AS total_Salary FROM workers;