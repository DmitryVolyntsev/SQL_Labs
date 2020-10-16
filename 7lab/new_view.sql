--����� ������, �����, ����������������� ������, ���������

IF OBJECT_ID ('test_view') IS NOT NULL
    DROP VIEW test_view;
GO

CREATE VIEW test_view
AS
SELECT l.name AS '�����', h.hotel_name AS '�����', DATEDIFF(dd,o.starts_date,o.end_date) AS '������', MIN(DATEDIFF(dd,o.starts_date,o.end_date) * (p.price - (d.procent / 100 * p.price))) AS '���������' 
	FROM HOTEL h, PRICE p, LOCATION l, ROOM r, DISCOUNT d, ORDERS o
WHERE h.location_id = l.location_id
AND h.hotel_id = r.hotel_id
AND r.room_id = p.room_id
AND p.discount_id = d.discount_id
AND r.room_id = o.room_id
GROUP BY h.hotel_name, l.name, o.starts_date, o.end_date
GO
SELECT * FROM test_view