/*******************************************************
 * Script to Create Classe Database in MS-SQL
 *******************************************************
 * 01 - CREATE DATABASE
 *		Must be in a diferent script so that it can be 
 *		referenced in the DML script (USE sentence)
 *******************************************************/
IF DB_ID(N'ULHT_DB26') IS NULL
BEGIN
  CREATE DATABASE ULHT_DB26;
END
GO

-- Delay the script conclusion waiting for server and database to be online
-- This delay is critical for container boot
WHILE DB_ID(N'ULHT_DB26') IS NOT NULL
  AND CAST(DATABASEPROPERTYEX(N'ULHT_DB26','Status') AS NVARCHAR(60)) <> N'ONLINE'
BEGIN
  WAITFOR DELAY '00:00:01';
END
GO