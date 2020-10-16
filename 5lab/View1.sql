--����� ������, ���������� �������, ���������� ���, ������� ��������� ������ � ����

IF OBJECT_ID ('location_view') IS NOT NULL
    DROP VIEW location_view;
GO

CREATE VIEW location_view
AS
SELECT l.name AS '�����', COUNT(DISTINCT h.hotel_id) AS [����������], COUNT(DISTINCT trv.[����������]) AS '����������', AVG(p.price) AS [������� ���������]
	FROM LOCATION l
JOIN
	(SELECT l1.location_id AS lid, COUNT(t1.traveler_id) AS [����������]
	FROM LOCATION l1,HOTEL h1,ROOM r1,ORDERS o1,TRAVELER t1
	WHERE l1.location_id = h1.location_id
	AND h1.hotel_id = r1.hotel_id
	AND r1.room_id = o1.room_id
	AND o1.traveler_id = t1.traveler_id
	GROUP BY l1.location_id) AS trv ON trv.lid = l.location_id
JOIN HOTEL h ON l.location_id = h.location_id
JOIN ROOM r ON h.hotel_id = r.hotel_id
JOIN PRICE p ON r.room_id = p.room_id
GROUP BY l.name, [����������]
GO
SELECT [�����], [����������], [������� ���������] FROM location_view;
GO