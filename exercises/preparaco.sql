/*
CREATE DATABASE Praticar;
CREATE SCHEMA vendas;
GO;
CREATE TABLE vendas.categorias (
    categoria_id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE

);

CREATE TABLE vendas.produtos (
    produto_id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100),
    categoria_id INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
    ano_modelo SMALLINT NOT NULL,
    CONSTRAINT FK_produtos_categorias
        FOREIGN KEY(categoria_id) REFERENCES vendas.categorias(categoria_id)

);

CREATE TABLE vendas.clientes (
  cliente_id INT IDENTITY(1,1) PRIMARY KEY,
  nome       VARCHAR(100) NOT NULL,
  email      VARCHAR(100) NOT NULL UNIQUE,
  telefone   VARCHAR(25) NULL,
  cidade     VARCHAR(50) NULL,
  pais       VARCHAR(30) NOT NULL DEFAULT 'Portugal'
);

CREATE TABLE vendas.encomendas (
  encomenda_id   INT IDENTITY(1,1) PRIMARY KEY,
  cliente_id     INT NOT NULL,
  data_encomenda DATE NOT NULL DEFAULT GETDATE(),
  data_envio     DATE NULL,
  CONSTRAINT FK_encomendas_clientes
    FOREIGN KEY (cliente_id) REFERENCES vendas.clientes(cliente_id),
  CONSTRAINT CHK_datas
    CHECK (data_envio IS NULL OR data_envio >= data_encomenda)
);

CREATE TABLE vendas.itens_encomenda (
  encomenda_id INT NOT NULL,
  item_id      INT NOT NULL,
  produto_id   INT NOT NULL,
  quantidade   INT NOT NULL CHECK (quantidade > 0),
  desconto     DECIMAL(3,2) NOT NULL DEFAULT 0 CHECK (desconto BETWEEN 0 AND 1),
  CONSTRAINT PK_itens PRIMARY KEY (encomenda_id, item_id),
  CONSTRAINT FK_itens_encomendas
    FOREIGN KEY (encomenda_id) REFERENCES vendas.encomendas(encomenda_id),
  CONSTRAINT FK_itens_produtos
    FOREIGN KEY (produto_id) REFERENCES vendas.produtos(produto_id)
);
GO

CREATE INDEX idx_clientes_cidade ON vendas.clientes(cidade);
GO
CREATE SCHEMA vendas;
*/

USE Praticar;

GO

SELECT INFORMATION_SCHEMA.COLUMNS;