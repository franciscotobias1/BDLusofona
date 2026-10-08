USE Bikestores;
/*SELECT *
FROM information_schema.TABLES t
WHERE t.TABLE_SCHEMA = 'production';*/

/*SELECT *
FROM information_schema.TABLES t 
WHERE t.TABLE_SCHEMA = 'sales';*/

/*SELECT *
FROM sys.tables;*/

/*SELECT *
FROM information_schema.COLUMNS c  
WHERE c.TABLE_NAME = 'products';*/

/*SELECT * 
FROM information_schema.COLUMNS c  
WHERE c.TABLE_NAME = 'customers';*/
/*SET IDENTITY_INSERT production.brands ON;
INSERT INTO production.brands
    (brand_id, brand_name)
VALUES 
    (2001, 'APPLE');
SET IDENTITY_INSERT production.brands OFF;

SELECT * FROM production.brands;*/

/*SET IDENTITY_INSERT production.categories ON;
INSERT INTO production.categories
    (category_id, category_name)
VALUES 
    (2001, 'telemovel');
SET IDENTITY_INSERT production.categories OFF;

SELECT * FROM production.categories;*/

/*SET IDENTITY_INSERT sales.customers ON;
INSERT INTO sales.customers
    (customer_id, first_name, last_name, phone, email, street, city, state, zip_code) 
VALUES 
    (2300, 'Francisco', 'Tobias', 969903327, 'franciscotobias2121@gmail.com', 'Rua A', 'Lisboa', 'Texas', '7890');
SET IDENTITY_INSERT sales.customers OFF;

SELECT * FROM sales.customers;*/

/*SET IDENTITY_INSERT sales.stores ON;
INSERT INTO sales.stores
    (store_id, store_name, phone, email, street, city, state, zip_code) 
VALUES 
    (1000, 'ALEHOP', 9876578, 'alehop"alehop', 'RUA A', 'ALABAMA', 'AZ', '2872');
SET IDENTITY_INSERT sales.stores OFF;

SELECT * FROM sales.stores;*/

/*DELETE FROM production.brands WHERE brand_id = 2001;*/


/*DELETE FROM production.brands WHERE brand_id = 2000;
DELETE FROM production.brands WHERE brand_id = 245;

SELECT * FROM production.brands;*/

/*DELETE FROM production.categories WHERE category_id = 2001;

SELECT * FROM production.categories;*/

/*DELETE FROM sales.customers WHERE customer_id = 2300;

SELECT * FROM sales.customers;*/

/*DELETE FROM sales.stores WHERE store_id = 1000;

SELECT * FROM sales.stores;
SELECT first_name AS Nome, last_name AS Apelido, phone AS Telefone, email AS 'Endereço Email' FROM sales.customers c;

SELECT first_name AS Nome, last_name AS Apelido, phone AS Telefone, email AS 'Endereço Email' FROM sales.customers c WHERE c.phone IS NOT NULL;

SELECT CONCAT(first_name,' ',last_name) AS fullname, first_name, last_name, phone, email FROM sales.customers c WHERE c.phone IS NULL;
SELECT CONCAT(LOWER(first_name), ' ', UPPER(last_name)) AS fullname, phone, email FROM sales.customers c WHERE c.phone IS NULL;

SELECT CONCAT(LEFT(first_name, 1), '. ', last_name) AS customer_name, email, phone FROM sales.customers c WHERE c.phone IS NULL;


SELECT CONCAT(first_name, ' ', LEFT(last_name, 1), '.') AS customer_name, email, phone FROM sales.customers c WHERE c.phone IS NULL;

SELECT DISTINCT state AS 'Estado' FROM sales.customers c WHERE c.phone IS NULL order by 'Estado' ASC;

SELECT product_name AS Produto, list_price AS 'Preço' FROM production.products p WHERE p.list_price BETWEEN 350 AND 850 ORDER BY 'Preço' DESC; 

SELECT product_name AS Produto, list_price AS 'Preço' FROM production.products p WHERE p.list_price IN (999.99, 1999.99, 2999.99) ORDER BY 'Preço' ASC;

SELECT product_name AS Produto, list_price AS 'Preço' FROM production.products p WHERE p.product_name LIKE '%Fuel%';

SELECT product_name AS 'Produto', list_price AS 'Preço' FROM production.products p WHERE p.product_name LIKE 'Trek%';

SELECT first_name, last_name, email, state, phone FROM sales.customers c WHERE c.phone IS  NOT NULL AND c.state = 'CA';

SELECT first_name AS 'Nome', last_name AS Apelido, email AS 'Endereço Email'
FROM sales.staffs s 
WHERE s.email LIKE '%serrano%';

SELECT first_name as Nome, last_name AS Apelido, email AS 'Endereço Email' 
FROM sales.staffs s
WHERE s.manager_id IS NULL;

SELECT first_name AS Nome, last_name AS Apelido, phone AS Telefone
FROM sales.staffs s
WHERE s.phone LIKE '%55';

SELECT first_name AS Nome, last_name AS Apelido, phone AS Telefone
FROM sales.staffs s 
WHERE s.first_name LIKE 'M%';

SELECT order_id AS ID, order_date AS 'Data'
FROM sales.orders s  
WHERE s.order_date BETWEEN '2016-01-01' AND '2016-01-15';    

SELECT * 
FROM sales.orders s  
WHERE s.customer_id IN (541, 1212, 1326) AND LEFT(order_date, 4) IN (2016, 2017);

SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS; */