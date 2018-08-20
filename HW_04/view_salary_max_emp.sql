use employees;

CREATE VIEW view_salary_max_emp AS
SELECT first_name, last_name, salary from employees
	LEFT JOIN salaries
		ON employees.emp_no = salaries.emp_no
			where salary = (SELECT max(salary) FROM salaries);