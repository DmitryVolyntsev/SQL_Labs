--Определить начальника, у которого в непосредственном подчинении находится наибольшее число служащих, стаж которых не превышает 4 года

SELECT TOP 1 WITH TIES COUNT(e.employee_id) AS number, CONCAT(m.first_name, ' ', m.middle_initial, '.', ' ', m.last_name) AS 
manager_name
	FROM EMPLOYEE e, JOB ej, EMPLOYEE m, JOB mj
	WHERE e.manager_id is not null
	AND	m.job_id = mj.job_id
	AND	m.employee_id = e.manager_id
	AND CAST(DATEDIFF (YEAR, e.hire_date, GETDATE()) AS DECIMAL) < 4
	AND mj."function" = 'manager'
	AND e.job_id = ej.job_id
	AND ej."function" = 'salesperson'
	GROUP BY m.employee_id, m.first_name, m.middle_initial, m.last_name
	ORDER BY number DESC
