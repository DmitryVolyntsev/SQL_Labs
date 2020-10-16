--Определить продавцов, которые в 1989 году совершили не менее 20 продаж на общую сумму не менее 10000

select last_name, middle_initial, first_name from  employee,customer,sales_order
where customer.customer_id=sales_order.customer_id
	and salesperson_id=employee_id
	and year(order_date)=1989
group by last_name, middle_initial, first_name
having sum(total)>=10000 and count(order_id)>=20