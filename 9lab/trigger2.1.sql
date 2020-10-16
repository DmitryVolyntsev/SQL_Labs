/*
При удалении места отдыха удаляются все будущие тур-поездки в это место отдыха,
а у уже совершенных тур-поездок идентификатор места отдыха заменяется на NULL
*/

IF OBJECT_ID ('Exterminator2', 'TR') IS NOT NULL
DROP TRIGGER Exterminator2;
GO

CREATE TRIGGER Exterminator2
ON LOCATION INSTEAD OF DELETE, UPDATE
AS
BEGIN
	DELETE FROM ORDERS
	FROM ORDERS o LEFT JOIN ROOM r ON o.room_id = r.room_id
				  LEFT JOIN HOTEL h ON r.hotel_id = h.hotel_id
				  LEFT JOIN LOCATION l ON h.location_id = l.location_id
	WHERE l.location_id IN (SELECT location_id FROM deleted)
	AND o.starts_date > GETDATE()


	UPDATE ORDERS
	SET room_id = NULL
	FROM ORDERS o LEFT JOIN ROOM r ON o.room_id = r.room_id
				  LEFT JOIN HOTEL h ON r.hotel_id = h.hotel_id
				  LEFT JOIN LOCATION l ON h.location_id = l.location_id
	WHERE o.starts_date <= GETDATE()
	AND l.location_id IN (SELECT location_id FROM deleted)


	DELETE FROM LOCATION WHERE location_id IN (SELECT location_id FROM deleted)

END


BEGIN TRANSACTION
DELETE FROM LOCATION WHERE (location_id = 51)
SELECT o.order_id, o.traveler_id, o.room_id, o.starts_date, o.end_date, r.hotel_id, h.location_id, h.hotel_name
	  FROM ORDERS o LEFT JOIN ROOM r ON o.room_id = r.room_id
					LEFT JOIN HOTEL h ON r.hotel_id = h.hotel_id
					LEFT JOIN LOCATION l ON h.location_id = l.location_id
ROLLBACK