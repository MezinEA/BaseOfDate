use employees;

SET @maxsalary = (SELECT max(salary) FROM salaries);

SELECT first_name, last_name, salary from employees
	LEFT JOIN salaries
		ON employees.emp_no = salaries.emp_no
			where salary = @maxsalary;