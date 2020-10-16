--Выбрать названия тех товаров, которые продаются более 3 лет

select distinct description from product
where product_id in
	(select product_id from price
	group by product_id
	having max(datediff(year,start_date,getdate()))>3)