use employees;

SET @maxsalary = (SELECT max(salary) FROM salaries);

SET @the_reachest_emp = (SELECT employees.emp_no from employees
	LEFT JOIN salaries
		ON employees.emp_no = salaries.emp_no
			where salary = @maxsalary);
            
delete from employees
	where employees.emp_no = @the_reachest_emp;