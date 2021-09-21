CREATE TABLE my_companies
(
company_id NUMBER(9),
company_name VARCHAR2(9)

);
--DELETE my_companies;
INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');
SELECT * FROM my_companies;

CREATE TABLE orders
(
order_id NUMBER(9),
company_id NUMBER(9),
order_date DATE

);

INSERT INTO orders VALUES(11, 101, '17-Apr-2020');
INSERT INTO orders VALUES(22, 102, '18-Apr-2020');
INSERT INTO orders VALUES(33, 103, '19-Apr-2020');
INSERT INTO orders VALUES(44, 104, '20-Apr-2020');
INSERT INTO orders VALUES(55, 105, '21-Apr-2020');

SELECT * FROM orders;

--Select company name, order id, order date for common companies

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc INNER JOIN orders o
ON o.company_id = mc.company_id;

--LEFT JOIN : 

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc LEFT JOIN orders o
ON o.company_id = mc.company_id;

--RIGHT JOIN : 

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc RIGHT JOIN orders o
ON o.company_id = mc.company_id;

--FULL JOIN  : 


SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc FULL JOIN orders o
ON o.company_id = mc.company_id;

--SELF JOIN : 

--DROP TABLE workers PURGE;

CREATE TABLE workers
(
id NUMBER(2),
name VARCHAR2(20),
title VARCHAR2(60),
manager_id NUMBER(2)
);

INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT * FROM workers;

SELECT m1.name AS "Employee Name", m2.name AS "Manager Name"
FROM workers m1 INNER JOIN workers m2
ON m1.manager_id = m2.id;

--ALTER TABLE : 
--We can add a column to existing table 

ALTER TABLE my_companies
ADD company_address VARCHAR2(80);

UPDATE my_companies
SET company_address = 'Austin Texas'
WHERE company_id = 100;

--Add a field with default value

ALTER TABLE my_companies
ADD company_profession VARCHAR2(20) DEFAULT 'IT';

--Add multiple fields into a table

ALTER TABLE my_companies
ADD (company_ceo VARCHAR2(50),
     number_workers NUMBER(5) DEFAULT 0);

--Drop fields from a table

ALTER TABLE my_companies
DROP COLUMN company_ceo;

--Rename fields/column

ALTER TABLE my_companies
RENAME COLUMN company_profession TO company_industry;

--Rename table

ALTER TABLE my_companies
RENAME TO our_companies;

--Modify (Add constraints, change data type, change the size) a field

--How to add constraint

ALTER TABLE our_companies
MODIFY number_workers NOT NULL;

--Make all data in company_address field null for change data type

UPDATE our_companies
SET company_address = NULL;

ALTER TABLE our_companies
MODIFY company_address CHAR(20);

SELECT * FROM our_companies;

--DROP TABLE workers PURGE;
--DROP TABLE our_companies PURGE;


================================================================================

--PROCEDURE : That is a function but don't return data

CREATE OR REPLACE FUNCTION addf(a NUMBER, b NUMBER) RETURN NUMBER IS
BEGIN
   RETURN a+b;
END;

--1.Way to call function 
SELECT addf(12, 13) FROM DUAL;

--2.Way

EXECUTE DBMS_OUTPUT.PUT_LINE('Result :' || addf(12, 13)); 

--3.Way

VARIABLE RESULT NUMBER
EXECUTE : RESULT := addf(12,13);
PRINT RESULT;

--Get two numbers and oparation sign from user then print the result

DECLARE 
a NUMBER := '&First_number';
b NUMBER := '&Second_number';
c CHAR := '&Operation_sign';

FUNCTION calculatorf(a NUMBER, b NUMBER, c CHAR) RETURN NUMBER IS
BEGIN
    IF c = '+' THEN RETURN a+b;
    ELSIF c = '-' THEN RETURN a-b;
    ELSIF c = '*' THEN RETURN a*b;
    ELSIF c = '/' THEN RETURN a/b;
    ELSE DBMS_OUTPUT.PUT_LINE('duzgun gir la');
        RETURN 0;
    END IF;    
END;

BEGIN

    DBMS_OUTPUT.PUT_LINE(calculatorf(a, b, c));

END;

CREATE TABLE students
(
std_name VARCHAR2(50),
std_age NUMBER(3),
insertion_date DATE,
inserter VARCHAR2(50)
);

DECLARE
    current_date DATE;
    inserter VARCHAR2(50);
    std_name VARCHAR2(50);
    std_age NUMBER(3);
BEGIN
    SELECT sysdate, user
    INTO current_date, inserter
    FROM DUAL;
    
    std_name := '&student_name';
    std_age := '&student_age';
    
    INSERT INTO students VALUES (std_name, std_age, current_date, inserter);
END;

SELECT * FROM students;