USE BikeStores;
/*
SELECT *
INTO sales.customers_short
FROM sales.customers
WHERE first_name LIKE '[ABCDXYZ]%';
GO

CREATE VIEW sales.customers_rich_states AS
SELECT first_name, last_name, email
FROM sales.customers
WHERE state IN ('TX', 'CA');
GO

CREATE VIEW sales.customers_special AS
SELECT *
FROM sales.customers
WHERE last_name LIKE '[abt]%'
AND (city LIKE '%o' OR city LIKE '%on');
GO

CREATE VIEW sales.last_trimester AS
SELECT *
FROM sales.orders
WHERE MONTH(order_date) IN (10, 11, 12);
GO

CREATE VIEW sales.second_semester AS
SELECT *
FROM sales.orders
WHERE MONTH(order_date) >= 7
AND YEAR(order_date) IN (2016, 2018)
AND YEAR(shipped_date) <> YEAR(order_date);
GO

CREATE VIEW sales.long_emails AS
SELECT *
FROM sales.customers
WHERE LEN(email) > 20;
GO

SELECT * FROM sales.customers_short;
SELECT * FROM sales.customers_rich_states;
SELECT * FROM sales.customers_special;
SELECT * FROM sales.last_trimester;
SELECT * FROM sales.second_semester;
SELECT * FROM sales.long_emails;*/

