
-- Data import script for the employees-db

-- Because of the way that the data is formatted in the csv file,
-- the datestyle has to be set to this in advance of the importing.  The
-- input data is NOT in postgres default, which is yyyy-mm-dd.
-- The datafiles use mm/dd/yy.

-- This setting is local to the session.   'SHOW datestyle' will
-- display the current setting.
		 
SET datestyle TO 'ISO, MDY';

-- Use dynamic sql to set up the variable names for the files to load.
-- The path should be set to the proper one for the user's environment.
-- The dynamic sql method is a combination of different Stack Overflow
-- answers and ChatGpt.   ChatGpt was incorrect in its first few responses
-- on this, but modified its answers in response to further information.

-- Loading all of the tables together may take about 15 seconds, mostly for
-- the large employee table, which has more than 300,000 rows.

-- The use of dynamic sql to create and concatenate the path was a combination
-- of suggestions from Stack Overflow and ChatGPT.  The first few that ChatGPT
-- suggested did not work, but later queries after getting information from
-- Stack Overflow produced a combined helpful result.

DO $$
DECLARE
   path_name text := 'C:/CWRU_Bootcamp/Git/sql_challenge/EmployeeSQL/data/';

   titles_file text := CONCAT (path_name, 'titles.csv');
   departments_file text := CONCAT (path_name, 'departments.csv');
   employees_file text := CONCAT (path_name, 'employees.csv');
   salaries_file text := CONCAT (path_name, 'salaries.csv');
   dept_managers_file text := CONCAT (path_name, 'dept_manager.csv');
   dept_emps_file text := CONCAT (path_name, 'dept_emp.csv');

   sql_statement text;

BEGIN

-- The loads of Departments and Titles have to be first because of foreign key constraints.
-- The order of loading those two files does not matter. 
	 
   -- Construct the SQL statement  for departments and execute the dynamic SQL
   sql_statement := 'COPY Departments FROM ''' || departments_file || ''' DELIMITER '','' CSV HEADER';
   EXECUTE sql_statement;
   
   -- Construct the SQL statement for titles and execute the dynamic SQL
   sql_statement := 'COPY Titles FROM ''' || titles_file || ''' DELIMITER '','' CSV HEADER';
   EXECUTE sql_statement;

-- Because of foreign keys, The load of Employees has to come before salaries or the junction tables

   -- Construct the SQL statement for employees and execute the dynamic SQL
   sql_statement := 'COPY Employees FROM ''' || employees_file || ''' DELIMITER '','' CSV HEADER';
   EXECUTE sql_statement;

-- The order of loading the last 3 tables, salaries and the junction tables for employee/manager and employee/depart,
-- does not matter with respect to these 3 tables, so long as they are after the others, as they use either
-- employee number or a combination of employee number and department number as foreign keys. 

-- Construct the SQL statement for salaries and execute the dynamic SQL
   sql_statement := 'COPY Salaries FROM ''' || salaries_file || ''' DELIMITER '','' CSV HEADER';
   EXECUTE sql_statement;

   -- Construct the SQL statement for department employees and execute the dynamic SQL
   sql_statement := 'COPY  DeptEmps FROM ''' || dept_emps_file || ''' DELIMITER '','' CSV HEADER';
   EXECUTE sql_statement;

      -- Construct the SQL statement for department managers and execute the dynamic SQL
   sql_statement := 'COPY DeptMngrs FROM ''' || dept_managers_file || ''' DELIMITER '','' CSV HEADER';
   EXECUTE sql_statement;

END $$;




