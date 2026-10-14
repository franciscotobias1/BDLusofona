/*CREATE DATABASE BikeStoresAnalytics;


CREATE SCHEMA "metrics";

GO

CREATE SCHEMA "events";





SELECT * FROM INFORMATION_SCHEMA.COLUMNS;



CREATE SCHEMA "metrics";

GO

CREATE SCHEMA "events";



USE BikeStoresAnalytics;


USE BikeStoresAnalytics;





CREATE DATABASE BikeStoresAnalytics;
CREATE DATABASE metrics;
CREATE DATABASE events;



CREATE TABLE metrics.indicators (
    id          INT NOT NULL,
    name        VARCHAR(100) NOT NULL,
    category    VARCHAR(100),
    description VARCHAR(255),
    val         DECIMAL(10,2) NOT NULL,
    dt          DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (name),
    CHECK (name <> ''),
    CHECK (val > 20)
);



CREATE TABLE events.messages (
    id      INT NOT NULL,
    message VARCHAR(255) DEFAULT 'General Event',
    dt      DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);



INSERT INTO metrics.indicators (id, name, category, description, val) VALUES
(1,  'Total Sales',        'Sales',     'Total de vendas',            1500.50),
(2,  'Average Order',      'Sales',     'Valor médio por encomenda',  75.25),
(3,  'Active Customers',   'Customers', 'Clientes ativos',            320),
(4,  'New Customers',      'Customers', NULL,                         45),
(5,  'Stock Level',        'Inventory', 'Stock disponível',           980),
(6,  'Returns',            '',          'Devoluções',                 22),
(7,  'Store Visits',       'Traffic',   'Visitas às lojas',           2100),
(8,  'Online Orders',      'Sales',     'Encomendas online',          410),
(9,  'Staff Count',        'HR',        'Número de funcionários',     36),
(10, 'Customer Rating',    'Customers', 'Avaliação média (x10)',      42);

INSERT INTO events.messages (id, message) VALUES
(1,  'Sistema iniciado'),
(2,  'Utilizador autenticado'),
(3,  'Nova encomenda registada'),
(4,  'Stock atualizado'),
(5,  'Pagamento recebido'),
(6,  'Backup concluído'),
(7,  'Erro de ligação'),
(8,  'Relatório gerado'),
(9,  'Cliente criado'),
(10, 'Sessão terminada');

INSERT INTO events.messages (id) VALUES (11);



SELECT * FROM metrics.indicators;
SELECT * FROM events.messages; */

SELECT * FROM metrics.indicators;

GO


SELECT * FROM events.messages;