# sql_challenge

This challenge is to do a research project on employees who worked at a fictional company during the 1980s and 1990s.

The input is six csv files in the "data" directory, for employees, titles, salaries, departments, department managers, and department employees.  

The project requires using a postgres database server, postgresql, and pgAdmin4 to create a database schema.  It also requires creating an Entity Relatioship Diagram (ERD) for the database, importing the provided data, and running some analyses on the database.   

The final project documents consist of three sql files, two ERD diagrams, an output message log of combined returned messages from one run of the different data analysis queries, and eight output .csv files.  There is one sql file, "employees_schema.sql", to create the database tables and constraints; one sql file, "employees_data_load.sql", to load the .csv files into the database, and one sql file, "employees_data_display", to run the eight analysis queries.  

The online application QuickDBD (opendatabasediagram.com) was used to create one of the ERDs, as suggested as an option in the challenge instructions.  An initial SQL for all six tables was created manually using CODE, uploaded into QuickDBD, and later finalized manually using Code.   The Postgress SQL produced by the QuickDBD app as an "export" had many issues, including with putting tables and field names in quotation marks that are then included in the field or table definition, datatypes not known to postgres, and adding all constraints separately by altering the tables after they are created.  So, after the SQL was output from this tool for examination, it was not used for this project.  

After the initial data modeling was done in QuickDBD, and the postgress schema was created using the manual sql scripts, pgAdmin4 was also used to create a second ERD. 

The advantage of QuickDBD's less-detailed diagram is that the table names are easy to see and stand out, and the diagram looks more like something that non-technical executives viewing slides might prefer.  The advantage of the PgAdmin4 ERD program is the greater detail even in the "lesser" detail mode, the greater use of color and images, the easier-to-see relationship indicators, and the use of the proper data types, because the ERD has moved past the conceptual level.  Both diagrams are included in the submission.  Each probably would work better for a different audience.

To run these scripts, the project assumes that the "employees_db" is already created in the user environment, and the user running the sql files has the appropriate access.  For this project, the database was created manually using the PgAdmin4 GUI.  Although a sql script to create the database and to set permissions is available in pgAdmin4 after the database is created using the GUI, and is not too complex, a more complex script would be needed to search out any connected PIDs, and to terminate those processes, if the script were to drop and re-create the "employees_db" itself.  This is outside the scope of the requirements, which did not ask for any type of script to create the database.  It also could be a problem in a multi-user environment to just terminate running processes.  If connections to the database are open and the user wants to drop and add it, PIDs to delete can be found by running Python scripts, or pgAdmin4 has a dashboard GUI that shows connected PIDs, which can then be manually terminated.

----------------------------------------------------------------------------------------------------------------
Before running the data_load script, the path variable at the beginning of the script should be set appropriately for the user's environment. 
-------------------------------------------------------------------------------------------------------------------
 The location where data is stored for this project has to be specified in a string for the dynamic SQL to operate, and is not part of the Python "PATH" variable.   The location where the postgres server is installed and runs is almost certainly different from computer to computer, so a path relative to that location would not be very meaningful.

----------------------------------------------------------------------------------------------------------------
If the load script is not run and the data is imported through the PgAdmin4 GUI, the ISO date type must be set first, to 'ISO, MDY'.  
----------------------------------------------------------------------------------------------------------------
The sql data load script does this first.  This is because the .csv input files have dates in the format mm/dd/yy, and the postgress date type is in yyyy-mm-dd format.  If the data type is not set, an intermediate script would have to be written to convert the dates, or to load them as strings and then reformat them.  The datestyle setting entered by "SET datestyle to 'ISO, MDY';" as the script uses, or entered manually within a session, is only applicable for that local session, and has no effect on the database itself or the server.  Starting a new instance of the Query tool will create a new session, or pgAdmin4 also has a disconnect from database option.

----------------------------------------------------------------------------------------------------------------
If the load_data script is not run, any existing tables have to be emptied in the proper order, to account for the foreign key constraints, before they can be reloaded.  Data also has to be imported in essentially the reverse order of the table emptying. 
 ----------------------------------------------------------------------------------------------------------------

Similarly, the schema sql deletes any existing tables in a specific order, then creates them in essentially the reverse order, to account for the foreign key constraints.   More information on the ordering is contained in the employees_schema.sql and employees_data_load.sql.

The output files from the analysis queries are all stored in the "output" directory.  

To re-run the results, each of the sql files can be loaded with the "file" option in PgAdmin4 and the entire file executed using the run button, but only the last set of results will display.   To see the results of the earlier operations, the query statements can be selected and run individually.   The output does not save automatically; the "download" button must be used in the GUI to save each set of results before running the next.

Some of the files, for both input and output, are very large.  The employee data, for example, is 300,023 rows plus a header, and the employee-department junction file is more than 330,000 rows, because some employees belong to more than one department.  While the queries run quickly, importing data into the employees table and exporting that table joined with others may take quite a long time.  The imports of all of the tables, run together, are averaging about 14.5 seconds, whereas the longest query is about 1.3 seconds.  Creating the output .csv file for Question 4, which has 331,603 rows plus a header, takes far longer than any of the others and may say "Downloading results..." for quite a while, even though the query executes quickly, pgAdmin4 displays 1,000 rows at a time, and displays more as they are requested.  

During the analysis phase, a separate query was run, and a separate output file was created, ordered by employee_id rather than by department_id, so that the employees who were in more than one department could be examined.  This output, discussed below, is not part of the data delivered.  Consider three examples:

d002	10050	Dredge	Yinghua	Finance
d007	10050	Dredge	Yinghua	Sales
---

d005	10070	Garigliano	Reuven	Development
d008	10070	Garigliano	Reuven	Research

-----

d007	10088	Syrzycki	Jungsoon	Sales
d009	10088	Syrzycki	Jungsoon	Customer Service

From this data, is is not clear if the employees had more than one job at a time, or if they were promoted or changed positions.  A quick visual examination shows some form of relationship between the different departments involved.  Moving from Customer Service to Sales, Sales to Finance, or Research to Development, as these three examples indicate, as well as the numbers involved {31,580), suggests that it is more likely these were promotions, but the only date we have available about hiring is the original hire date, nothing about any promotion dates, if that is what these multiple rows represent.

Another notable characteristic of this data is that, while there were more than 300,000 employees during this time period, there are only 1,639 distinct last names.  The names appear to be largely German, with some Italian and some Eastern European as the next largest groups.  This might suggest a German or Swiss company, but neither the names themselves, nor the relatively small number of last names, seem likely to be typical of a U.S. company, in any location that would have this many employees.   Some of the names appear to be famous authors or scientists, so maybe they are all AI generated.


