-------------------------------=-------------------------
-- Database: employees_db 

-- This is a database of former employees who were working in the 1980s and 1990s
---------------------------------------------------------

--  Do the drops in this order because of the foreign key constraints

DROP TABLE IF exists DeptEmps;
DROP TABLE IF exists DeptMngrs;
DROP TABLE IF exists Salaries;
DROP TABLE IF exists Employees;
DROP TABLE IF exists Departments;
DROP TABLE IF exists Titles;

-------------------------------
--  Do the creates in the reverse order as the drops, because of foreign key constraints

-- Defining a field as a foreign key automatically creates a constraint on the table.
-- The foreign key constraint ensures referential integrity; it ensures that the values in the foreign
-- key column match the values in the referenced primary key column of the referenced table

CREATE TABLE Departments (
    dept_no varchar(10)  NOT NULL PRIMARY KEY,
    dept_name varchar(255)  NOT NULL
);

CREATE TABLE Titles (
    title_id varchar(10)  NOT NULL PRIMARY KEY,
    title varchar(255)  NOT NULL  
);

CREATE TABLE Employees (
    emp_no int  NOT NULL PRIMARY KEY,
    emp_title varchar(10)  NOT NULL,
    FOREIGN KEY (emp_title) REFERENCES Titles(title_id),
    birth_date date  NOT NULL,
    first_name varchar(255)  NOT NULL,
    last_name varchar(255)  NOT NULL,
    sex varchar(1)  NOT NULL,
    hire_date  date  NOT NULL
);


CREATE TABLE Salaries (
    emp_no int NOT NULL PRIMARY KEY,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    salary decimal(10,2)  NOT NULL
);

CREATE TABLE DeptEmps (
    emp_no int  NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    dept_no  varchar(10)  NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE DeptMngrs (
    dept_no varchar(10)  NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    emp_no int  NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    PRIMARY KEY (dept_no, emp_no)
);



