use employees;

DROP TRIGGER IF EXISTS trigg_new_manager;

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	values ('1000000004','1954-05-01', 'BOB', 'MARLEY', 'M', '2018-08-20');

DELIMITER //

CREATE TRIGGER trigg_new_manager BEFORE INSERT ON employees.employees 
	FOR EACH ROW
		BEGIN
			INSERT INTO salaries (emp_no, salary, from_date, to_date, bonus)
				VALUES (new.emp_no, '0', new.hire_date, '9999-12-31', '10000');        
        END//
        
DELIMITER ;