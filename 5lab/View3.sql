--�������� �����, ��� ����� � ����, � ������� ���� ������ ���

IF OBJECT_ID ('facility_view') IS NOT NULL
    DROP VIEW facility_view;
GO

CREATE VIEW facility_view
AS
SELECT distinct h.hotel_name AS '�����', l.name AS '�����', hs.name AS '������' FROM HOTEL_SERVICES hs, SERVICESS s, HOTEL h, LOCATION l, CITY c
	WHERE h.location_id = l.location_id
	AND l.city_id = c.city_id
	AND c.name = '���'
	AND s.hotel_id = h.hotel_id
	AND hs.service_id = s.service_id
	AND hs.name = '���'
GROUP BY h.hotel_name, l.name, hs.name
GO

SELECT [�����], [�����] FROM facility_view
WHERE [������] = '���'