/*
CREATE DATABASE BikeStoresAnalises;

CREATE SCHEMA "analytics"


GO
SELECT * FROM sys.schemas WHERE name NOT LIKE 'db%';





CREATE TABLE analytics.products (
    product_id INT IDENTITY (1, 1) PRIMARY KEY,
    product_name VARCHAR (255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DECIMAL (10, 2) NOT NULL,
);
CREATE TABLE analytics.categories (
    category_id   INT IDENTITY (1, 1) PRIMARY KEY,
    category_name VARCHAR (255) NOT NULL
);
CREATE TABLE analytics.stores (
    store_id   INT IDENTITY (1, 1) PRIMARY KEY,
    store_name VARCHAR (255) NOT NULL,
    phone      VARCHAR (25),
    email      VARCHAR (255),
    street     VARCHAR (255),
    city       VARCHAR (255),
    state      VARCHAR (10),
    zip_code   VARCHAR (5)
);

CREATE TABLE analytics.customers (
    customer_id INT IDENTITY (1, 1) PRIMARY KEY,
    first_name  VARCHAR (255) NOT NULL,
    last_name   VARCHAR (255) NOT NULL,
    phone       VARCHAR (25),
    email       VARCHAR (255) NOT NULL,
    street      VARCHAR (255),
    city        VARCHAR (50),
    state       VARCHAR (25),
    zip_code    VARCHAR (5)
);
CREATE TABLE analytics.staffs (
    staff_id   INT IDENTITY (1, 1) PRIMARY KEY,
    first_name VARCHAR (50) NOT NULL,
    last_name  VARCHAR (50) NOT NULL,
    email      VARCHAR (255) NOT NULL UNIQUE,
    phone      VARCHAR (25),
    active     TINYINT NOT NULL,
    store_id   INT NOT NULL,
    manager_id INT,
    CONSTRAINT FK_staffs_stores
        FOREIGN KEY (store_id) REFERENCES analytics.stores (store_id),
    CONSTRAINT FK_staffs_manager
        FOREIGN KEY (manager_id) REFERENCES analytics.staffs (staff_id)
);
CREATE TABLE analytics.orders (
    order_id      INT IDENTITY (1, 1) PRIMARY KEY,
    customer_id   INT NOT NULL,
    order_status  TINYINT NOT NULL,
    order_date    DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date  DATE,
    store_id      INT NOT NULL,
    staff_id      INT NOT NULL,
    CONSTRAINT FK_orders_customers
        FOREIGN KEY (customer_id) REFERENCES analytics.customers (customer_id),
    CONSTRAINT FK_orders_stores
        FOREIGN KEY (store_id) REFERENCES analytics.stores (store_id),
    CONSTRAINT FK_orders_staffs
        FOREIGN KEY (staff_id) REFERENCES analytics.staffs (staff_id)
);
CREATE TABLE analytics.order_items (
    order_id   INT NOT NULL,
    item_id    INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL,
    list_price DECIMAL (10, 2) NOT NULL,
    discount   DECIMAL (4, 2) NOT NULL DEFAULT 0,
    CONSTRAINT PK_order_items PRIMARY KEY (order_id, item_id),
    CONSTRAINT FK_items_orders
        FOREIGN KEY (order_id) REFERENCES analytics.orders (order_id),
    CONSTRAINT FK_items_products
        FOREIGN KEY (product_id) REFERENCES analytics.products (product_id)
);
CREATE TABLE analytics.stocks (
    store_id   INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT,
    CONSTRAINT PK_stocks PRIMARY KEY (store_id, product_id),
    CONSTRAINT FK_stocks_stores
        FOREIGN KEY (store_id) REFERENCES analytics.stores (store_id),
    CONSTRAINT FK_stocks_products
        FOREIGN KEY (product_id) REFERENCES analytics.products (product_id)
);
*/



USE BikeStoresAnalises



SELECT * FROM sys.tables