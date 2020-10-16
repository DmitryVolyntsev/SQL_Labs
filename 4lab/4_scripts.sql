--Выбрать отдыхающего, наибольшее число раз посетившего 'Египет', это количество и его затраты на поездки.
SELECT TOP 1 WITH TIES COUNT(o.order_id) AS Количество,t.second_name,SUM(p.price) AS Стоимость FROM TRAVELER t,ORDERS o,ROOM r,HOTEL h,LOCATION l,CITY c,COUNTRY ctr,PRICE p
WHERE t.traveler_id=o.traveler_id
AND o.room_id=r.room_id
AND r.hotel_id=h.hotel_id
AND h.location_id=l.location_id
AND l.city_id=c.city_id
AND c.country_id=ctr.country_id
AND r.room_id=p.room_id
AND ctr.name='Египет'
GROUP BY second_name
ORDER BY COUNT(o.order_id)


--Выбрать моря /города/ и названия отелей, которые посетил 'Коновалов' /Уоттерс/ в прошлом году.
SELECT c.name AS Город,h.hotel_name AS Отель FROM TRAVELER t,ORDERS o,ROOM r,HOTEL h,LOCATION l,CITY c
WHERE t.traveler_id=o.traveler_id
AND o.room_id=r.room_id
AND r.hotel_id=h.hotel_id
AND h.location_id=l.location_id
AND l.city_id=c.city_id
AND t.second_name='Уоттерс'
GROUP BY c.name,h.hotel_name,o.starts_date
HAVING (DATEPART(yyyy,GETDATE())-DATEPART(yyyy,o.starts_date))-
	CASE
	WHEN (DATEPART(mm,GETDATE())<DATEPART(mm,o.starts_date))
	or (DATEPART(mm,GETDATE())=DATEPART(mm,o.starts_date))
	and (DATEPART(dd,GETDATE())<DATEPART(dd,o.starts_date))
	THEN 1
	ELSE 0
	END < 2
AND (DATEPART(yyyy,GETDATE())-DATEPART(yyyy,o.starts_date))-
	CASE
	WHEN (DATEPART(mm,GETDATE())<DATEPART(mm,o.starts_date))
	or (DATEPART(mm,GETDATE())=DATEPART(mm,o.starts_date))
	and (DATEPART(dd,GETDATE())<DATEPART(dd,o.starts_date))
	THEN 1
	ELSE 0
	END >= 1
ORDER BY c.name


--Выбрать все возможные варианты не более двух тур-поездок /в отели/ на сумму 3000, так чтобы отдых прошел на 'Средиземном' море /в Риме/.
SELECT DISTINCT CASE
		WHEN p1.price + p2.price < 3000 THEN CAST(r1.room_id AS varchar) + ' ' + CAST(r2.room_id AS varchar)
		WHEN p1.price > 3000 AND p2.price < 3000 THEN CAST(r2.room_id AS varchar)
		WHEN p2.price > 3000 AND p1.price < 3000 THEN CAST(r1.room_id AS varchar)
	   END Варианты
FROM HOTEL h1,HOTEL h2,LOCATION l1,LOCATION l2,CITY c,ROOM r1,ROOM r2,PRICE p1,PRICE p2
WHERE h1.location_id = l1.location_id
AND h2.location_id = l2.location_id
AND l1.city_id = c.city_id
AND l2.city_id = c.city_id
AND c.name = 'Рим'
AND r1.hotel_id = h1.hotel_id
AND r2.hotel_id = h2.hotel_id
AND p1.room_id = r1.room_id
AND p2.room_id = r2.room_id
AND NOT r1.room_id = r2.room_id


--Выбрать количество дней отдыха и количество мест отдыха в прошлом году для каждого клиента фирмы.
SELECT t.second_name AS Отдыхающий,DATEDIFF(dd,o.starts_date,o.end_date) AS Отпуск,COUNT(h.hotel_id) AS Места
FROM HOTEL h,ROOM r,ORDERS o,TRAVELER t
WHERE h.hotel_id=r.hotel_id
AND r.room_id=o.room_id
AND o.traveler_id=t.traveler_id
GROUP BY t.second_name,o.starts_date,o.end_date
HAVING (DATEPART(yyyy,GETDATE())-DATEPART(yyyy,o.starts_date))-
	CASE
	WHEN (DATEPART(mm,GETDATE())<DATEPART(mm,o.starts_date))
	OR (DATEPART(mm,GETDATE())=DATEPART(mm,o.starts_date))
	AND (DATEPART(dd,GETDATE())<DATEPART(dd,o.starts_date))
	THEN 1
	ELSE 0
	END < 2
AND (DATEPART(yyyy,GETDATE())-DATEPART(yyyy,o.starts_date))-
	CASE
	WHEN (DATEPART(mm,GETDATE())<DATEPART(mm,o.starts_date))
	OR (DATEPART(mm,GETDATE())=DATEPART(mm,o.starts_date))
	AND (DATEPART(dd,GETDATE())<DATEPART(dd,o.starts_date))
	THEN 1
	ELSE 0
	END >= 1
ORDER BY t.second_name