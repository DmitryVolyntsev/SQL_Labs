--Страна, имена отдыхавших в этой стране, количество раз, когда они отдыхали там (для каждого отдыхающего)

IF OBJECT_ID ('country_view') IS NOT NULL
    DROP VIEW country_view;
GO

CREATE VIEW country_view
AS
SELECT ctr.name AS 'Страна', t.second_name AS 'Отдыхающий', COUNT(distinct t.traveler_id) AS 'Количество раз' FROM 
COUNTRY ctr, TRAVELER t, LOCATION l, HOTEL h, ROOM r, CITY c, ORDERS o
		WHERE ctr.country_id = c.country_id
		AND c.city_id = l.city_id
		AND l.location_id = h.location_id
		AND h.hotel_id = r.hotel_id
		AND r.room_id = o.room_id
		AND o.traveler_id = t.traveler_id
GROUP BY ctr.name, t.second_name
GO
SELECT * FROM country_view
ORDER BY 'Страна'