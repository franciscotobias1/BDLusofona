/*
  Lesson 01 - Metadata,Read, add, and remove rows
  Student: 2703 - Luis A. Gomes 
  Date: 15/09/2026
*/

USE ULHT_DB26;
GO

-- list databases in the current SQL Server instance
SELECT
    name,
    database_id,
    state_desc,
    recovery_model_desc
FROM sys.databases
ORDER BY name;

SELECT TOP 1 * FROM Scott.emp ORDER BY sal DESC;
SELECT '1'+'1';
SELECT GETDATE();

SELECT * FROM Scott.emp WHERE sal > 2000;


SELECT * FROM INFORMATION_SCHEMA.COLUMNS AS c
    WHERE c.TABLE_NAME = 'emp';

INSERT INTO Scott.EMP
VALUES
    (2703, 'TEST', NULL, NULL, GETDATE(), 1000, NULL, NULL);

SELECT * FROM Scott.emp WHERE empno = 2703;       

DELETE FROM Scott.emp WHERE empno = 2703;  