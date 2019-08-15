DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS managers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;


--create the six tables for six CSVs
CREATE TABLE departments (
	dept_no VARCHAR (10),
	dept_name VARCHAR(45) NOT NULL
);

CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR (10),
	from_date DATE,
	to_date DATE
);

CREATE TABLE managers (
	dept_no VARCHAR,
	emp_no INT,
	from_date DATE,
	to_date DATE
);

CREATE TABLE employees (
	emp_no INT,
	birth_date DATE,
	first_name VARCHAR (40),
	last_name VARCHAR (40),
	gender CHAR,
	hire_date DATE
);

CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	from_date DATE,
	to_date DATE
);

CREATE TABLE titles (
	emp_no INT,
	title VARCHAR,
	from_date DATE,
	to_date DATE
);


---check if tables created
select * from departments;
select * from dept_emp;
select * from managers;
select * from employees;
select * from salaries;
select * from titles;

--import the CSVs, check tables again

--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT E.emp_no, E.last_name, E.first_name, E.gender, S.salary
FROM employees AS E
INNER JOIN salaries AS S
ON E.emp_no=S.emp_no;

--List employees who were hired in 1986.
SELECT *
FROM employees
WHERE hire_date >= '1/01/1986'
AND hire_date <= '12/31/1986'

--List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.
SELECT M.dept_no, D.dept_name, M.emp_no, E.last_name, E.first_name, M.from_date, M.to_date
FROM managers M
JOIN employees E ON
M.emp_no = E.emp_no
JOIN departments D
ON M.dept_no = D.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, 
--and department name.
SELECT E.emp_no, E.last_name, E.first_name, D.dept_name
FROM employees E
JOIN dept_emp DE
ON E.emp_no = DE.emp_no
JOIN departments D
ON D.dept_no = DE.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT E.emp_no, E.last_name, E.first_name, D.dept_name
FROM employees E
JOIN dept_emp DE ON
E.emp_no = DE.emp_no
JOIN departments D
ON DE.dept_no = D.dept_no
WHERE d.dept_name = 'Sales';

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT E.emp_no, E.last_name, E.first_name, D.dept_name
FROM employees E
JOIN dept_emp DE ON
E.emp_no = DE.emp_no
JOIN departments D
ON DE.dept_no = D.dept_no
WHERE d.dept_name = 'Sales'
OR d.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT COUNT(last_name) AS "LN Count", last_name
FROM employees 
GROUP BY last_name
ORDER BY "LN Count" DESC;

