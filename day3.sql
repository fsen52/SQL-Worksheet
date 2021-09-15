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