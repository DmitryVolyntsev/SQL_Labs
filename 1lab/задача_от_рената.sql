--Для всех отделов инициалы сотрудников у которых отношение 
--(зарпл.+комиссионные/общая сумма зарплат и комиссионых по отделу) макс
with tab as
(select e.employee_id, tmp2.department_id, tmp1.sal/tmp2.sum_ as need
from employee e
join 
(
	select employee_id, salary + ISNULL(commission, 0) as sal 
	from EMPLOYEE
) tmp1
on tmp1.employee_id = e.employee_id 
join
(
	select sum(salary+isnull(commission, 0)) as sum_, department_id 
	from EMPLOYEE
	group by department_id
) tmp2
on tmp2.department_id = e.department_id)
select emp.employee_id
from EMPLOYEE emp
join tab t1
on emp.employee_id = t1.employee_id and emp.department_id = t1.department_id
join
(
	select tab.employee_id, tab.department_id, max(tab.need) as max_
	from tab 
	group by  tab.employee_id, tab.department_id
) t
on t1.employee_id = t.employee_id and emp.department_id = t1.department_id
and  t1.need = t.max_;
 




select TOP 1 with ties count(e.employee_id) as num,last_name,employee.department_id,salary,commission from employee,
(select sum(salary.total) as maxs, sum(commission.total) as maxc, department_id from employee
group by department_id) temp
where temp.department_id=employee.department_id

order by num desc