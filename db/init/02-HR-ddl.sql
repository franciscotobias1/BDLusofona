/*******************************************************
 * Script to Create SCHEMAS on Classe Database
 *******************************************************
 * 02 - CREATE SCHEMAS
 *		[Scott] & [HR]
 *		Starts by droping any existing object so that the
 *		script can be run independntly of CREATE script
 *		(e.g. recreate schema without droping database)
 *******************************************************/
USE [ULHT_DB26]
GO

IF NOT EXISTS(SELECT schema_id FROM sys.schemas WHERE name = 'HR')
	EXEC sp_executesql N'CREATE SCHEMA HR';

IF NOT EXISTS(SELECT schema_id FROM sys.schemas WHERE name = 'Scott')
	EXEC sp_executesql N'CREATE SCHEMA Scott';    


/*******************************************************
 * DROP table for base SCHEMA SCOTT
 *******************************************************/
IF OBJECT_ID('[Scott].[DEPT]', 'U') IS NOT NULL
	DROP TABLE [Scott].[DEPT];
IF OBJECT_ID('[Scott].[EMP]', 'U') IS NOT NULL
	DROP TABLE [Scott].[EMP];
IF OBJECT_ID('[Scott].[BONUS]', 'U') IS NOT NULL
	DROP TABLE [Scott].[BONUS];
IF OBJECT_ID('[Scott].[SALGRADE]', 'U') IS NOT NULL
	DROP TABLE [Scott].[SALGRADE];


/*******************************************************
 * DROP table for base SCHEMA HR
 *******************************************************/
IF EXISTS (
	SELECT * FROM sys.foreign_keys 
	   WHERE object_id = OBJECT_ID(N'[HR].[FK_DEPARTMENTS_EMPLOYEES]')
	   AND parent_object_id = OBJECT_ID(N'[HR].[DEPARTMENTS]')
)
	ALTER TABLE [HR].[DEPARTMENTS] DROP CONSTRAINT [FK_DEPARTMENTS_EMPLOYEES] ;

IF EXISTS (
	SELECT * FROM sys.foreign_keys 
	   WHERE object_id = OBJECT_ID(N'[HR].[FK_EMPLOYEES_EMPLOYEES]')
	   AND parent_object_id = OBJECT_ID(N'[HR].[EMPLOYEES]')
)
	ALTER TABLE [HR].[EMPLOYEES] DROP CONSTRAINT [FK_EMPLOYEES_EMPLOYEES];

IF OBJECT_ID('[HR].[JOB_HISTORY]', 'U') IS NOT NULL
	DROP TABLE [HR].[JOB_HISTORY];
IF OBJECT_ID('[HR].[EMPLOYEES]', 'U') IS NOT NULL
	DROP TABLE [HR].[EMPLOYEES];
IF OBJECT_ID('[HR].[JOBS]', 'U') IS NOT NULL
	DROP TABLE [HR].[JOBS];
IF OBJECT_ID('[HR].[DEPARTMENTS]', 'U') IS NOT NULL
	DROP TABLE [HR].[DEPARTMENTS];
IF OBJECT_ID('[HR].[LOCATIONS]', 'U') IS NOT NULL
	DROP TABLE [HR].[LOCATIONS];
IF OBJECT_ID('[HR].[COUNTRIES]', 'U') IS NOT NULL
	DROP TABLE [HR].[COUNTRIES];
IF OBJECT_ID('[HR].[REGIONS]', 'U') IS NOT NULL
	DROP TABLE [HR].[REGIONS];

/*******************************************************
 * DDL for base SCHEMA SCOTT
 *******************************************************/
--------------------------------------------------------
--  DDL for Table DEPT
--------------------------------------------------------
IF OBJECT_ID('[Scott].[DEPT]', 'U') IS NULL
	CREATE TABLE [Scott].[DEPT] (	
			[DEPTNO]	NUMERIC(2,0), 
			[DNAME]		VARCHAR(14), 
			[LOC]		VARCHAR(13)
	);

--------------------------------------------------------
--  DDL for Table EMP
--------------------------------------------------------
IF OBJECT_ID('[Scott].[EMP]', 'U') IS NULL
	CREATE TABLE [Scott].[EMP] (
			[EMPNO]		NUMERIC(4,0)			NOT NULL, 
			[ENAME]		VARCHAR(10)		DEFAULT	NULL,
			[JOB]		VARCHAR(9)		DEFAULT	NULL, 
			[MGR]		NUMERIC(4,0)	DEFAULT	NULL, 
			[HIREDATE]	DATE			DEFAULT	NULL, 
			[SAL]		NUMERIC(7,2)	DEFAULT	NULL, 
			[COMM]		NUMERIC(7,2)	DEFAULT	NULL, 
			[DEPTNO]	NUMERIC(2,0)	DEFAULT	NULL
	   );

--------------------------------------------------------
--  Constraints for Table EMP
--------------------------------------------------------
ALTER TABLE [Scott].[EMP] ADD CONSTRAINT [EMP_PK] PRIMARY KEY ([EMPNO]);

--------------------------------------------------------
--  DDL for Table BONUS
--------------------------------------------------------
IF OBJECT_ID('[Scott].[BONUS]', 'U') IS NULL
	CREATE TABLE [Scott].[BONUS] (	
			[ENAME]		VARCHAR(10), 
			[JOB]		VARCHAR(9), 
			[SAL]		NUMERIC(8,2), 
			[COMM]		NUMERIC(2,2)
	);

--------------------------------------------------------
--  DDL for Table SALGRADE
--------------------------------------------------------
IF OBJECT_ID('[Scott].[SALGRADE]', 'U') IS NULL
	CREATE TABLE [Scott].[SALGRADE] (
			[GRADE]		NUMERIC(2), 
			[LOSAL]		NUMERIC(8,2), 
			[HISAL]		NUMERIC(8,2)
	);


/*******************************************************
 * End of base SCHEMA Scott
 *******************************************************/

/*******************************************************
 * DDL for base SCHEMA HR
 *******************************************************/
--------------------------------------------------------
--  DDL for Table REGIONS
--------------------------------------------------------
IF OBJECT_ID('[HR].[REGIONS]', 'U') IS NULL
	CREATE TABLE [HR].[REGIONS] (
			[REGION_ID]		NUMERIC(3)	NOT NULL, 
			[REGION_NAME]	VARCHAR(25)	NOT NULL
	);

--------------------------------------------------------
--  Constraints for Table REGIONS
--------------------------------------------------------
ALTER TABLE [HR].[REGIONS] ADD CONSTRAINT [PK_REGIONS] PRIMARY KEY ([REGION_ID]);


--------------------------------------------------------
--  DDL for Table COUNTRIES
--------------------------------------------------------
IF OBJECT_ID('[HR].[COUNTRIES]', 'U') IS NULL
	CREATE TABLE [HR].[COUNTRIES] (
  			[COUNTRY_ID]	CHAR(2)		NOT NULL, 
			[COUNTRY_NAME]	VARCHAR(40)	NOT NULL, 
			[REGION_ID]		NUMERIC(3)	NOT NULL
	);

--------------------------------------------------------
--  Constraints for Table COUNTRIES
--------------------------------------------------------
ALTER TABLE [HR].[COUNTRIES] ADD CONSTRAINT [PK_COUNTRIES] PRIMARY KEY ([COUNTRY_ID]);

--------------------------------------------------------
--  DDL for Table LOCATIONS
--------------------------------------------------------
IF OBJECT_ID('[HR].[LOCATIONS]', 'U') IS NULL
	CREATE TABLE [HR].[LOCATIONS] (
			[LOCATION_ID]		NUMERIC(4,0)			NOT NULL, 
			[STREET_ADDRESS]	VARCHAR(40)		DEFAULT	NULL, 
			[POSTAL_CODE]		VARCHAR(12)		DEFAULT	NULL, 
			[CITY]				VARCHAR(30)				NOT NULL, 
			[STATE_PROVINCE]	VARCHAR(25)		DEFAULT	NULL, 
			[COUNTRY_ID]		CHAR(2)			DEFAULT	NULL
	);

--------------------------------------------------------
--  Constraints for Table LOCATIONS
--------------------------------------------------------
ALTER TABLE [HR].[LOCATIONS] ADD CONSTRAINT [PK_LOCATIONS] PRIMARY KEY ([LOCATION_ID]);

--------------------------------------------------------
--  DDL for Table DEPARTMENTS
--------------------------------------------------------
IF OBJECT_ID('[HR].[DEPARTMENTS]', 'U') IS NULL
	CREATE TABLE [HR].[DEPARTMENTS]  (	
			[DEPARTMENT_ID]		NUMERIC(4,0)			NOT NULL, 
			[DEPARTMENT_NAME]	VARCHAR(30)				NOT NULL, 
			[MANAGER_ID]		NUMERIC(6,0)	DEFAULT	NULL, 
			[LOCATION_ID]		NUMERIC(4,0)	DEFAULT NULL
	);

--------------------------------------------------------
--  Constraints for Table DEPARTMENTS
--------------------------------------------------------
ALTER TABLE [HR].[DEPARTMENTS] ADD CONSTRAINT [PK_DEPARTMENTS] PRIMARY KEY ([DEPARTMENT_ID]);

--------------------------------------------------------
--  DDL for Table JOBS
--------------------------------------------------------
IF OBJECT_ID('[HR].[JOBS]', 'U') IS NULL
	CREATE TABLE [HR].[JOBS] (	
			[JOB_ID]		VARCHAR(10)					NOT NULL, 
			[JOB_TITLE]		VARCHAR(35)					NOT NULL, 
			[MIN_SALARY]	NUMERIC(6,0)	DEFAULT		NULL, 
			[MAX_SALARY]	NUMERIC(6,0)	DEFAULT		NULL
	);

--------------------------------------------------------
--  Constraints for Table JOBS
--------------------------------------------------------
ALTER TABLE [HR].[JOBS] ADD CONSTRAINT [PK_JOBS] PRIMARY KEY ([JOB_ID]);


--------------------------------------------------------
--  DDL for Table EMPLOYEES
--------------------------------------------------------
IF OBJECT_ID('[HR].[EMPLOYEES]', 'U') IS NULL
	CREATE TABLE [HR].[EMPLOYEES] (
  			[EMPLOYEE_ID]		NUMERIC(6,0)				NOT NULL, 
			[FIRST_NAME]		VARCHAR(20)		DEFAULT		NULL, 
			[LAST_NAME]			VARCHAR(25)					NOT NULL, 
			[EMAIL]				VARCHAR(25)		DEFAULT		NULL, 
			[PHONE_NUMBER]		VARCHAR(20)					NOT NULL, 
			[HIRE_DATE]			DATE						NOT NULL, 
			[JOB_ID]			VARCHAR(10)					NOT NULL, 
			[SALARY]			NUMERIC(8,2)	DEFAULT 0, 
			[COMMISSION_PCT]	NUMERIC(2,2)	DEFAULT 0	NULL, 
			[MANAGER_ID]		NUMERIC(6,0)	DEFAULT		NULL, 
			[DEPARTMENT_ID]		NUMERIC(4,0)	DEFAULT		NULL
	);

--------------------------------------------------------
--  Constraints for Table EMPLOYEES
--------------------------------------------------------
ALTER TABLE [HR].[EMPLOYEES] ADD CONSTRAINT [PK_EMPLOYEES] PRIMARY KEY ([EMPLOYEE_ID]);
ALTER TABLE [HR].[EMPLOYEES] ADD CONSTRAINT [UQ_EMPLOYEES_EMAIL] UNIQUE ([EMAIL]);
ALTER TABLE [HR].[EMPLOYEES] ADD CONSTRAINT [CH_EMPLOYEES_SALARY] CHECK (salary > 0);

--------------------------------------------------------
--  DDL for Table JOB_HISTORY
--------------------------------------------------------
IF OBJECT_ID('[HR].[JOB_HISTORY]', 'U') IS NULL
	CREATE TABLE [HR].[JOB_HISTORY] (
  			[EMPLOYEE_ID]		NUMERIC(6,0)			NOT NULL, 
			[START_DATE]		DATE					NOT NULL, 
			[END_DATE]			DATE			DEFAULT	NULL, 
			[JOB_ID]			VARCHAR(10)				NOT NULL, 
			[DEPARTMENT_ID]		NUMERIC(4,0)	DEFAULT	NULL
	);

--------------------------------------------------------
--  Constraints for Table JOB_HISTORY
--------------------------------------------------------
ALTER TABLE [HR].[JOB_HISTORY] ADD CONSTRAINT [PK_JOB_HISTORY] PRIMARY KEY ([EMPLOYEE_ID],[START_DATE]);
ALTER TABLE [HR].[JOB_HISTORY] ADD CONSTRAINT [CH_JOB_HISTORY_DATE_INTERVAL] CHECK ([END_DATE] > [START_DATE]);

/*******************************************************
 * End of base SCHEMA HR
 *******************************************************/

