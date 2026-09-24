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

SELECT * FROM sales.stores;*/
SELECT first_name AS Nome, last_name AS Apelido, phone AS Telefone, email AS 'Endereço Email' FROM sales.customers c