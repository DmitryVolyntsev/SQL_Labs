--������� ��� ��������� (��������� - 'SALESPERSON'), ������� ������������ ����� 1500 � �������� ������ 5 ���

select distinct last_name, middle_initial, first_name from employee, job
	where job.job_id=employee.job_id
	and job."function"='salesperson'
	and iif (commission is not null,commission+salary,salary) > 1500
	and cast (datediff (year,hire_date,getdate()) as decimal) < 5