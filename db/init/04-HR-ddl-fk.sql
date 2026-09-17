/*******************************************************
 * Referencial constraints for base SCHEMA HR
 *******************************************************/
USE [ULHT_DB26]
GO
--------------------------------------------------------
--  Ref Constraints for Table COUNTRIES
--------------------------------------------------------
ALTER TABLE [HR].[COUNTRIES] ADD CONSTRAINT [FK_COUNTRIES_REGION] FOREIGN KEY ([REGION_ID])
	REFERENCES [HR].[REGIONS] ([REGION_ID]);

--------------------------------------------------------
--  Ref Constraints for Table LOCATIONS
--------------------------------------------------------
ALTER TABLE [HR].[LOCATIONS] ADD CONSTRAINT [FK_LOCATIONS_COUNTRIES] FOREIGN KEY ([COUNTRY_ID])
	REFERENCES [HR].[COUNTRIES] ([COUNTRY_ID]);

--------------------------------------------------------
--  Ref Constraints for Table DEPARTMENTS
--------------------------------------------------------
ALTER TABLE [HR].[DEPARTMENTS] ADD CONSTRAINT [FK_DEPTARTMENTS_LOCATIONS] FOREIGN KEY ([LOCATION_ID])
	REFERENCES [HR].[LOCATIONS] ([LOCATION_ID]);
    
ALTER TABLE [HR].[DEPARTMENTS] ADD CONSTRAINT [FK_DEPARTMENTS_EMPLOYEES] FOREIGN KEY ([MANAGER_ID])
	REFERENCES [HR].[EMPLOYEES] ([EMPLOYEE_ID]);

--------------------------------------------------------
--  Ref Constraints for Table EMPLOYEES
--------------------------------------------------------
  ALTER TABLE [HR].[EMPLOYEES] ADD CONSTRAINT [FK_EMPLOYEES_DEPARTMENTS] FOREIGN KEY ([DEPARTMENT_ID])
	  REFERENCES [HR].[DEPARTMENTS] ([DEPARTMENT_ID]);

  ALTER TABLE [HR].[EMPLOYEES] ADD CONSTRAINT [FK_EMPLOYESS_JOBS] FOREIGN KEY ([JOB_ID])
	  REFERENCES [HR].[JOBS] ([JOB_ID]);

  ALTER TABLE [HR].[EMPLOYEES] ADD CONSTRAINT [FK_EMPLOYEES_EMPLOYEES] FOREIGN KEY ([MANAGER_ID])
	  REFERENCES [HR].[EMPLOYEES] ([EMPLOYEE_ID]);

--------------------------------------------------------
--  Ref Constraints for Table JOB_HISTORY
--------------------------------------------------------
  ALTER TABLE [HR].[JOB_HISTORY] ADD CONSTRAINT [FK_JOB_HISTORY_DEPARTMENTS] FOREIGN KEY ([DEPARTMENT_ID])
	  REFERENCES [HR].[DEPARTMENTS] ([DEPARTMENT_ID]);

  ALTER TABLE [HR].[JOB_HISTORY] ADD CONSTRAINT [FK_JOB_HISTORY_EMPLOYEES] FOREIGN KEY ([EMPLOYEE_ID])
	  REFERENCES [HR].[EMPLOYEES] ([EMPLOYEE_ID]);

  ALTER TABLE [HR].[JOB_HISTORY] ADD CONSTRAINT [FK_JOB_HISTORY_JOBS] FOREIGN KEY ([JOB_ID])
	  REFERENCES [HR].[JOBS] ([JOB_ID]);                

/*******************************************************
 * End of base SCHEMA HR
 *******************************************************/