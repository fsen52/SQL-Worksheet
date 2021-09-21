SELECT * FROM workers;

--Select all data from workers whoose salary is the second highest

SELECT * FROM workers 
WHERE worker_salary = (SELECT MAX (worker_salary) AS second_highest FROM workers 
                       WHERE worker_salary < (SELECT MAX (worker_salary) FROM workers));
                       
DROP TABLE workers PURGE;

CREATE TABLE workers

(
id CHAR(3) ,
name VARCHAR(50) ,
salary NUMBER(5) ,
CONSTRAINT worker_ID_PK PRIMARY KEY(id)
);

INSERT INTO workers VALUES('111','ADEM', 2500);
INSERT INTO workers VALUES('113','EDEM', 2600);
INSERT INTO workers VALUES('115','DEDEM', 2700);
INSERT INTO workers VALUES('117','BADEM', 2800);

SELECT * FROM workers;

--DROP TABLE student_name_age PURGE;

--Select all data from workers whoose salary is the second highest
--2.way

SELECT * 
FROM workers 
ORDER BY salary DESC;
--OFFSET 1 ROW
--FETCH NEXT 1 ROW ONLY;


================================================================================


CREATE TABLE customers_products

(
product_id NUMBER(10),
customer_name VARCHAR2(50),
produc_name VARCHAR2(50)
);

INSERT INTO customers_products VALUES (10,'Mark' ,'Orange');
INSERT INTO customers_products VALUES (10,'Mark' ,'Orange');
INSERT INTO customers_products VALUES (20,'John' ,'Apple');
INSERT INTO customers_products VALUES (30,'Amy'  ,'Palm');
INSERT INTO customers_products VALUES (20,'Mark' ,'Apple');
INSERT INTO customers_products VALUES (10,'Adem' ,'Orange');
INSERT INTO customers_products VALUES (40,'John' ,'Apricot');
INSERT INTO customers_products VALUES (20,'Eddie','Apple');


--DROP TABLE customers_products PURGE;

SELECT * FROM customers_products;

SELECT * FROM customers_products WHERE produc_name IN ('Orange','Apple','Palm');

--BETWEEN / NOT BETWEEN CONDITION

SELECT * FROM customers_products WHERE product_id BETWEEN 20 AND 30;

SELECT * FROM customers_products WHERE product_id NOT BETWEEN 20 AND 25;

--EXISTS CONDITION

CREATE TABLE customers_likes

(
product_id NUMBER(10),
customer_name VARCHAR2(50),
liked_product VARCHAR2(50)
);

INSERT INTO customers_likes VALUES (10,'Mark' ,'Orange');
INSERT INTO customers_likes VALUES (50,'Mark' ,'Pineapple');
INSERT INTO customers_likes VALUES (60,'John' ,'Avocado');
INSERT INTO customers_likes VALUES (30,'Lary'  ,'Cherries');
INSERT INTO customers_likes VALUES (20,'Mark' ,'Apple');
INSERT INTO customers_likes VALUES (10,'Adem' ,'Orange');
INSERT INTO customers_likes VALUES (40,'John' ,'Apricot');
INSERT INTO customers_likes VALUES (20,'Eddie','Apple');

SELECT * FROM customers_likes;


SELECT product_id, customer_name FROM customers_products
WHERE EXISTS (SELECT product_id FROM customers_likes WHERE customers_products.product_id=customers_likes.product_id);

================================================================================
CREATE TABLE employees 
(
id_number CHAR(9),
name VARCHAR2(50),
state VARCHAR2(50),
salary NUMBER(20),
company VARCHAR2(20)
);


INSERT INTO employees VALUES (123456789, 'John Walker','Florida',2500,'IBM');  
INSERT INTO employees VALUES (234567890, 'Brad Pitt','Florida',1500,'APPLE');
INSERT INTO employees VALUES (345678901, 'Eddie Murphy','Texas',3000,'IBM');
INSERT INTO employees VALUES (456789012, 'Eddie Murphy','Virgina',1000,'GOOGLE');
INSERT INTO employees VALUES (567890123, 'Eddie Murphy','Texas',7000,'MICROSOFT');
INSERT INTO employees VALUES (678901234, 'Brad Pitt','Texas',1500,'GOOGLE');
INSERT INTO employees VALUES (123456710, 'Mark Stone','Pennsylvania',2500,'IBM');

SELECT * FROM employees;
--DELETE employees;
CREATE TABLE companies
(
company_id NUMBER(9),
company VARCHAR2(20),
number_of_employees NUMBER(20)
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(100, 'APPLE', 21000);

SELECT * FROM companies;

--Find the employee and company name whose company has more than 15000 employees

SELECT name, company
FROM employees
WHERE company IN (SELECT company FROM companies WHERE companies.number_of_employees > 15000);

--Find the company ids and company names which are in Florida

SELECT company_id, company
FROM companies
WHERE company IN (SELECT company FROM employees WHERE employees.state = 'Florida');  

SELECT name,state
FROM employees
WHERE company IN (SELECT company FROM companies WHERE company_id>100);

--Find the company name, number of employees and average salary for every company

SELECT company,number_of_employees, (SELECT AVG (salary) 
                                    FROM employees 
                                    WHERE companies.company = employees.company) 
                                    AS company_avg_salary
FROM companies;

SELECT state, (SELECT SUM (salary) FROM employees WHERE employees.company = companies.company )
FROM employees;


DELETE companies;

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;

--LIKE Condition : It is used with WildCard : "%"

SELECT name
FROM employees
WHERE name LIKE 'E%';


SELECT name
FROM employees
WHERE name LIKE 'B%t';


SELECT name
FROM employees
WHERE name LIKE '%k%';

SELECT state
FROM employees
WHERE state LIKE '_e_n%';

--REGEXP_LIKE Condition : Regular Expressions

CREATE TABLE words
(
word_id NUMBER(10) UNIQUE,
word VARCHAR2(50),
number_of_letters NUMBER(6)
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);

SELECT * FROM words;

SELECT word
FROM words
WHERE REGEXP_LIKE (word, 'h[oai]t');

SELECT word
FROM words
WHERE REGEXP_LIKE (word, 'h[a-e]t');

SELECT word
FROM words
WHERE REGEXP_LIKE (word, '^[say](*)'); -- "*" is optional

SELECT word
FROM words
WHERE REGEXP_LIKE (word, '(*)[mfa]$');  -- "*" is optional

SELECT word
FROM words
WHERE REGEXP_LIKE (word, '^[s].*[a]$');

SELECT word
FROM words
WHERE REGEXP_LIKE (word, 'a');

SELECT word
FROM words
WHERE REGEXP_LIKE (word, '^[d-t].[l]'); -- "." in REGEXP_LIKE same with "_" in LIKE

SELECT word
FROM words
WHERE REGEXP_LIKE (word, '[u{2}]');  -- "u" repeated twice


--NOT LIKE Condition :

SELECT word
FROM words
WHERE word NOT LIKE '%h%';

SELECT word
FROM words
WHERE word NOT LIKE '%f' AND word NOT LIKE '%t';

SELECT word
FROM words
WHERE word NOT LIKE '_a%';

--ORDER BY : to put the records in ascending or descending order


SELECT *
FROM words 
ORDER BY number_of_letters;

SELECT *
FROM words 
ORDER BY number_of_letters DESC;

SELECT *
FROM words 
ORDER BY word DESC;

SELECT *
FROM words 
ORDER BY 3 DESC; -- 3 is column number


SELECT *
FROM words 
ORDER BY word DESC, number_of_letters ASC; 

