USE Tester;


GO 


/*

CREATE SCHEMA brands;






CREATE TABLE brands.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
);

INSERT INTO brands.products
VALUES (1, 'Bikla')
INSERT INTO brands.products(product_id)
VALUES (2)
UPDATE brands.products 
SET product_name = 'Carbon'
WHERE product_id = 2
DELETE FROM brands.products
WHERE product_id = 2
SELECT product_name FROM brands.products

SELECT * FROM information_schema.COLUMNS
CREATE INDEX products
ON brands.products(product_id)
INSERT INTO brands.products (product_id, product_name)
VALUES
(2,  'Trek Slash 8 27.5'),
(3,  'Heller Shagamaw Frame'),
(4,  'Surly Ice Cream Truck Frame'),
(5,  'Trek Remedy 29 Carbon Frameset'),
(6,  'Trek Conduit+'),
(7,  'Surly Straggler'),

(8,  'Surly Straggler 650b'),
(9,  'Electra Townie Original 21D'),
(10, 'Electra Cruiser 1 Tall');
CREATE VIEW [First_Products] AS
SELECT * FROM
brands.products
WHERE product_id  BETWEEN 1 AND 3 
SELECT * FROM First_Products





CREATE SCHEMA activities






CREATE TABLE activities.program (
    programID INT NOT NULL,
    programName VARCHAR(50) UNIQUE,
    programComment VARCHAR(255),

    PRIMARY KEY(programID)
);


INSERT INTO activities.program
VALUES 
(1, 'Natação', 'Destinada a todas as idades!'),
(2, 'Corrida', 'À descoberta da Natureza'),
(3, 'Bicicleta', 'Até as pernas aguentarem!'), 
(4, 'Futebol', 'Bola de Ouro? Mostra a tua qualidade'),
(5, 'Dança', 'Será que tens ritmo para isto?')


SELECT * FROM activities.program

UPDATE activities.program 
SET programName = 'Corrida Outdoor' 
WHERE programID = 2


SELECT * FROM activities.program



DELETE FROM activities.program
WHERE programName = 'Dança'


SELECT * FROM activities.program


CREATE INDEX activities_program ON activities.program(programID)


CREATE VIEW [activities.first_activity] AS
SELECT * 
FROM activities.program
WHERE programID = 1






SELECT * FROM activities.first_activity









EXEC sp_helpindex 'brands.products';











CREATE TABLE activities.participants (
    participantID INT NOT NULL,
    participantName VARCHAR(20),
    programID INT NOT NULL

    PRIMARY KEY(participantID),
    FOREIGN KEY(programID) REFERENCES activities.program(programID)
);
INSERT INTO activities.participants
VALUES
    (1, 'Abel', 4),
    (2, 'Jorge', 2),
    (3, 'Carlos', 3),
    (4, 'João', 1),
    (5, 'Cláudio', 4),
    (6, 'Prestianni', 4),
    (7, 'Marco', 1);




SELECT * FROM activities.participants

ALTER TABLE activities.participants 
ADD programName VARCHAR(50)
CREATE VIEW activities.ballers AS
SELECT (participantName) 
FROM activities.participants
WHERE programID = 4


SELECT * FROM activities.ballers

*/






SELECT p.participantName,
       pr.programID,
       pr.programName
FROM activities.participants AS p
INNER JOIN activities.program AS pr
    ON p.programID = pr.programID;