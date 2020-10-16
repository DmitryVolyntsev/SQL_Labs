--Название отеля, его район в Риме, у которых есть услуга СПА

IF OBJECT_ID ('facility_view') IS NOT NULL
    DROP VIEW facility_view;
GO

CREATE VIEW facility_view
AS
SELECT distinct h.hotel_name AS 'Отель', l.name AS 'Район', hs.name AS 'Услуга' FROM HOTEL_SERVICES hs, SERVICESS s, HOTEL h, LOCATION l, CITY c
	WHERE h.location_id = l.location_id
	AND l.city_id = c.city_id
	AND c.name = 'Рим'
	AND s.hotel_id = h.hotel_id
	AND hs.service_id = s.service_id
	AND hs.name = 'СПА'
GROUP BY h.hotel_name, l.name, hs.name
GO

SELECT [Отель], [Район] FROM facility_view
WHERE [Услуга] = 'СПА'