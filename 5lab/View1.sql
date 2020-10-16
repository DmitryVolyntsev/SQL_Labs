--Место отдыха, количество человек, отдыхавших там, средняя стоимость отдыха в день

IF OBJECT_ID ('location_view') IS NOT NULL
    DROP VIEW location_view;
GO

CREATE VIEW location_view
AS
SELECT l.name AS 'Место', COUNT(DISTINCT h.hotel_id) AS [Количество], COUNT(DISTINCT trv.[Отдыхающие]) AS 'Отдыхающих', AVG(p.price) AS [Средняя стоимость]
	FROM LOCATION l
JOIN
	(SELECT l1.location_id AS lid, COUNT(t1.traveler_id) AS [Отдыхающие]
	FROM LOCATION l1,HOTEL h1,ROOM r1,ORDERS o1,TRAVELER t1
	WHERE l1.location_id = h1.location_id
	AND h1.hotel_id = r1.hotel_id
	AND r1.room_id = o1.room_id
	AND o1.traveler_id = t1.traveler_id
	GROUP BY l1.location_id) AS trv ON trv.lid = l.location_id
JOIN HOTEL h ON l.location_id = h.location_id
JOIN ROOM r ON h.hotel_id = r.hotel_id
JOIN PRICE p ON r.room_id = p.room_id
GROUP BY l.name, [Отдыхающие]
GO
SELECT [Место], [Отдыхающих], [Средняя стоимость] FROM location_view;
GO