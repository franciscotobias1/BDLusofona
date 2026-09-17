/*
--------------------------------------------------------------------
© 2017 sqlservertutorial.net All Rights Reserved
--------------------------------------------------------------------
Name   : BikeStores
Link   : http://www.sqlservertutorial.net/load-sample-database/
Version: 1.0
--------------------------------------------------------------------
*/
/*******************************************************
 * Script to Create Classe Database in MS-SQL
 *******************************************************
 * 01 - CREATE DATABASE
 *		Must be in a diferent script so that it can be 
 *		referenced in the DML script (USE sentence)
 *******************************************************/
 
IF DB_ID(N'BikeStores') IS NULL
BEGIN
  CREATE DATABASE BikeStores;
END
GO

-- Delay the script conclusion waiting for server and database to be online
-- This delay is critical for container boot so that the remainder scripts do not run before the DB is available
WHILE DB_ID(N'BikeStores') IS NOT NULL
  AND CAST(DATABASEPROPERTYEX(N'BikeStores','Status') AS NVARCHAR(60)) <> N'ONLINE'
BEGIN
  WAITFOR DELAY '00:00:01';
END
GO
