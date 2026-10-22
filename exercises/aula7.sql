/*CREATE DATABASE Datawarehouse;*/

USE Datawarehouse;
/*CREATE TABLE "Clientes" (

    ClienteID INT NOT NULL,
    PRIMARY KEY(ClienteID)



);

CREATE TABLE "Pedidos" (

    ClienteID INT NOT NULL,
    FOREIGN KEY(ClienteID) REFERENCES Clientes(ClienteID)

    
);

INSERT INTO dbo.clientes
    (ClienteID)
VALUES 
    (2);
SELECT * FROM dbo.Clientes;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS;
 SELECT * FROM dbo.Pedidos;
CREATE TABLE "Departamentos" (

    DepartamentoID INT NOT NULL,

    PRIMARY KEY (DepartamentoID)


);
CREATE TABLE "Funcionarios" (
    FuncionarioID INT NOT NULL,
    DepartamentoID INT NOT NULL,
    PRIMARY KEY (FuncionarioID),
    FOREIGN KEY(FuncionarioID) REFERENCES Departamentos(DepartamentoID)
);
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

CREATE TABLE "Cursos" (
    CursoID INT NOT NULL,
    PRIMARY KEY(CursoID)
);

CREATE TABLE "Matriculas" (
    AlunoID INT NOT NULL,
    CursoID INT NOT NULL,
    PRIMARY KEY(AlunoID),
    FOREIGN KEY(CursoID) REFERENCES Cursos(CursoID)

);
CREATE TABLE "Fornecedores" (
    FornecedorID INT NOT NULL,
    PRIMARY KEY(FornecedorID)
);

CREATE TABLE "Produtos" (
    ProdutoID INT NOT NULL,
    FornecedorID INT NOT NULL,
    PRIMARY KEY(ProdutoID),
    FOREIGN KEY(FornecedorID) REFERENCES Fornecedores(FornecedorID)


);
*/

CREATE TABLE "Projetos" (
    ProjetoID INT NOT NULL,
    PRIMARY KEY(ProjetoID)
);

CREATE TABLE "Tarefas" (
    TarefaID INT NOT NULL,
    ProjetoID INT NOT NULL,

    PRIMARY KEY(TarefaID),
    FOREIGN KEY(ProjetoID) REFERENCES Projetos(ProjetoID)
);