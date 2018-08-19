use employees;

SELECT count(employees.emp_no), sum(salaries.salary) ,dept_name FROM employees
	left join salaries 
		on employees.emp_no = salaries.emp_no
			left join dept_manager
				ON	dept_manager.emp_no = employees.emp_no
					left join dept_emp
						ON	dept_emp.emp_no = employees.emp_no
							left join departments
								on departments.dept_no = dept_emp.dept_no OR departments.dept_no = dept_manager.dept_no
									group by dept_name;