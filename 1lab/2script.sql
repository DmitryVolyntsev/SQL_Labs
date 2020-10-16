--¬ыбрать тех продавцов (должность - 'SALESPERSON'), которые зарабатывают более 1500 и работают меньше 5 лет

select distinct last_name, middle_initial, first_name from employee, job
	where job.job_id=employee.job_id
	and job."function"='salesperson'
	and iif (commission is not null,commission+salary,salary) > 1500
	and cast (datediff (year,hire_date,getdate()) as decimal) < 5