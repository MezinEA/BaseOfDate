use employees;

delimiter //

CREATE FUNCTION func_find_employee (f_name VARCHAR(14), l_name VARCHAR(16))
RETURNS INT(11)
BEGIN
	SELECT emp_no INTO @emp_id FROM employees.employees
		where first_name = f_name AND last_name = l_name;
	RETURN @emp_id;
END//

delimiter ;

SELECT func_find_employee ('Sumant','Peac') AS ID_NUMBER;