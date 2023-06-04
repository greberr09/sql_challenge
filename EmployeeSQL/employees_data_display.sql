-- Querying the employee_db, per requirements of challenge

-- Set the date style because default date in postgres is yyyy-mm-dd and
-- this script does date comparisons on U.S. formats, mm/dd/yy.  
-- More sql could be used to reformat the U.S. dates, but this solution was in 
-- line with how the data was imported.

SET datestyle TO 'ISO, MDY';


------------------------------------------
--	List the employee number, last name, first name, sex, and salary of each employee 
------------------------------------------

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM Employees
inner join Salaries ON
     Employees.emp_no = Salaries.emp_no
ORDER BY Employees.emp_no;

------------------------------------------
--	List the first name, last name, and hire date for the employees who were hired in 1986
------------------------------------------

SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date >= '01/01/1986'
    AND hire_date < '01/01/1987'
ORDER BY last_name, first_name, hire_date;

------------------------------------------
--	List the manager of each department along with their department number, department name, employee number, 
--  last name, and first name.
------------------------------------------

SELECT  dm.dept_no, Departments.dept_name, Employees.emp_no, Employees.last_name, Employees.first_name
FROM DeptMngrs dm
inner join Departments ON 
    dm.dept_no = Departments.dept_no
inner join Employees ON
    dm.emp_no = Employees.emp_no
ORDER BY Departments.dept_name, Employees.last_name, Employees.first_name;

------------------------------------------
--	List the department number for each employee along with that employee’s employee number, last name, 
--  first name, and department name.
------------------------------------------

SELECT  em.dept_no, employees.emp_no, employees.last_name, employees.first_name, Departments.dept_name 
FROM Employees
inner join DeptEmps em ON
     Employees.emp_no = em.emp_no
inner join Departments ON
     em.dept_no = Departments.dept_no
ORDER BY Departments.dept_no, Employees.emp_no;

------------------------------------------
--  List first name, last name, and sex of each employee whose first name is Hercules and whose last name 
--  begins with the letter B.
------------------------------------------

SELECT first_name, last_name, sex
FROM Employees
WHERE first_name= 'Hercules'
    AND last_name LIKE 'B%'
ORDER BY last_name;

------------------------------------------
-- 	List each employee in the Sales department, including their employee number, last name, and first name.
------------------------------------------

SELECT Employees.emp_no, Employees.last_name, Employees.first_name
FROM DeptEmps em
inner join Departments ON 
    em.dept_no = Departments.dept_no
inner join Employees ON
    em.emp_no = Employees.emp_no
WHERE Departments.dept_name = 'Sales'
ORDER BY Employees.emp_no ;

------------------------------------------
--	List each employee in the Sales and Development departments, including their employee number, last name, 
--  first name, and department name.
------------------------------------------

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM DeptEmps em
inner join Departments ON 
    em.dept_no = Departments.dept_no
inner join Employees ON 
    em.emp_no = Employees.emp_no
WHERE Departments.dept_name = 'Sales' OR
     Departments.dept_name = 'Development'
ORDER BY Departments.dept_name, Employees.emp_no;

------------------------------------------
--	List the frequency counts, in descending order, of all the employee last names (that is, 
--  how many employees share each last name).
------------------------------------------

SELECT last_name, COUNT(last_name) AS "name_counts"
FROM Employees
GROUP BY last_name
ORDER BY name_counts desc, last_name asc;