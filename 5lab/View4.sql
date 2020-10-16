--Место отдыха, отель, продолжительность отдыха - для тур-поездок, стоимость которых не превышает 3000

IF OBJECT_ID ('hotel_view') IS NOT NULL
    DROP VIEW hotel_view;
GO

CREATE VIEW hotel_view
AS
SELECT l.name AS 'Место', h.hotel_name AS 'Отель', DATEDIFF(dd,o.starts_date,o.end_date) AS 'Отпуск', MIN(DATEDIFF(dd,o.starts_date,o.end_date) * (p.price - (d.procent / 100 * p.price))) AS 'Стоимость' 
	FROM HOTEL h, PRICE p, LOCATION l, ROOM r, DISCOUNT d, ORDERS o
WHERE h.location_id = l.location_id
AND h.hotel_id = r.hotel_id
AND r.room_id = p.room_id
AND p.discount_id = d.discount_id
AND r.room_id = o.room_id
GROUP BY h.hotel_name, l.name, o.starts_date, o.end_date
GO

SELECT * FROM hotel_view
WHERE [Стоимость] < 3000
ORDER BY [Отпуск] DESC