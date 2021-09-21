--ALIASES  :


CREATE TABLE employees
(
employee_id NUMBER(9),
employee_first_name VARCHAR2(20),
employee_last_name VARCHAR2(20)

);

--SELECT * FROM employees;
--DELETE employees;
--DROP TABLE employees PURGE;

INSERT INTO employees VALUES(14, 'Chris', 'Tae');
INSERT INTO employees VALUES(11, 'John', 'Walker');
INSERT INTO employees VALUES(12, 'Amy', 'Star');
INSERT INTO employees VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees VALUES(15, 'Chris', 'Way');

SELECT * FROM employees; 

CREATE TABLE adresses
(
employee_id NUMBER(9),
street VARCHAR2(20),
city VARCHAR2(20),
state CHAR(2),
zipcode CHAR(5)
);

INSERT INTO adresses VALUES(11, '32nd Star 1234','Miami','FL','33018');
INSERT INTO adresses VALUES(12, '23rd Rain 567','Jacksonville','FL','32256');
INSERT INTO adresses VALUES(13, '5th Snow 765','Hialeah','VA','20121');
INSERT INTO adresses VALUES(14, '3rd Man 12','Weston','MI','12345');
INSERT INTO adresses VALUES(15, '11th Chris 12','St.Johns','FL','32259');

SELECT * FROM adresses;

SELECT employees.employee_first_name, adresses.state
FROM employees, adresses
WHERE employees.employee_id = adresses.employee_id;


SELECT e.employee_first_name, a.state
FROM employees e, adresses a
WHERE e.employee_id = a.employee_id;

SELECT employee_id AS id, employee_first_name || ' ' || employee_last_name AS full_name
FROM employees;


--GROUP BY :

CREATE TABLE workers
(
id NUMBER(9),
name VARCHAR2(50),
state VARCHAR2(50),
salary NUMBER(20),
company VARCHAR2(20)
);

INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456789, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM workers;

--Find the total salary for every employee

SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name;

SELECT state, COUNT(state) AS number_of_employees
FROM workers
GROUP BY state
ORDER BY number_of_employees DESC; 

SELECT company, COUNT(*) AS "Number of Workers"
FROM workers
WHERE salary >2000
GROUP BY company;

SELECT company, MIN(salary) "Minimum", MAX(salary) "Maximum"
FROM workers
GROUP BY company;

--HAVING CLAUSE : 

--Find the total salary if it is greater than 2500 for every employee

SELECT name, SUM(salary)
FROM workers
GROUP BY name
HAVING SUM(salary)>2500;

SELECT state, COUNT(state) AS "number of employees"
FROM workers
GROUP BY state
HAVING COUNT(state)>1;

SELECT company, MIN(salary)
FROM workers
GROUP BY company
HAVING MIN(salary)>2000;

--UNION Operators : -Too many fields into single field with UNION
--                  -Give us unique data
--                  -UNION ALL give as all data, not just unique    
                    
--Find the state or employee names whose salary is greater than 3000, less than 2000 without duplication

SELECT state AS "Column", salary
FROM workers
WHERE salary > 3000

UNION

SELECT name, salary
FROM workers
WHERE salary < 2000;

--INTERSECT : Which results are same in the both of two table
--            Give us unique data

SELECT name AS "Column", salary
FROM workers
WHERE salary > 1000

INTERSECT

SELECT name, salary
FROM workers
WHERE salary < 2000;

-- MINUS :  



-- JOINS : 1)INNER JOIN
--         2)LEFT JOIN
--         3)RIGHT JOIN
--         4)FULL JOIN
--         5)SELF JOIN

DROP TABLE my_companies PURGE;


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