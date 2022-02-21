-- Creating tables for PH-EmployeeDB
CREATE TABLE Departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

	-- Creating table for Employees
CREATE TABLE employees (
	  emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

	-- Creating table for Dept Manage
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

	-- Creating table for Salaries
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

-- Creating table for Dep Employees
CREATE TABLE Dept_Emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
  );
 
 -- Creating table for Titles
 CREATE TABLE Titles (
	 emp_no INT NOT NULL,
	 title VARCHAR(40) NOT NULL,
	 from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
  );


SELECT * FROM departments;
SELECT * FROM employees;  
SELECT * FROM dept_manager; 
SELECT * FROM dept_emp; 
SELECT * FROM salaries; 
SELECT * FROM titles;

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

SELECT * FROM retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Check the table
SELECT * FROM retirement_info;


-- Joining retirement_info and dept_emp tables
SELECT 
	ri.emp_no,
    ri.first_name,
    ri.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM retirement_info as ri
INNER JOIN titles as ti
ON ri.emp_no = ti.emp_no
ORDER BY emp_no ASC;


SELECT * FROM retirement_titles;

SELECT DISTINCT ON (emp_no) emp_no,
   	first_name,
   	last_name,
	title,
	from_date,
	to_date
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

SELECT COUNT(emp_no)
FROM unique_titles;

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;


SELECT DISTINCT ON (emp_no) e.emp_no,
   	e.first_name,
   	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as d
  ON (e.emp_no = d.emp_no)
INNER JOIN titles as ti
  ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
AND (d.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM mentorship_eligibilty;

SELECT COUNT(emp_no)
FROM mentorship_eligibilty;


SELECT DISTINCT ON (emp_no) e.emp_no,
   	e.first_name,
   	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	ti.title
INTO mentorship_eligibilty_expanded
FROM employees as e
INNER JOIN dept_emp as d
  ON (e.emp_no = d.emp_no)
INNER JOIN titles as ti
  ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1985-12-31') 
AND (d.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM mentorship_eligibilty_expanded;

SELECT COUNT(emp_no)
FROM mentorship_eligibilty_expanded;
