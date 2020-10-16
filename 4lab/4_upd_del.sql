--������ ��� ��������� � ������ �������
SELECT * FROM CITY

UPDATE CITY
SET types_id = 32
WHERE name = '�������'
 
SELECT * FROM CITY


--�������� �������� ���� ������, ������ ������, ��� ��� �� ��� �������� ����������� CHECK
SELECT * FROM ORDERS

UPDATE ORDERS
SET starts_date = '01/01/1999'
WHERE order_id = 601 

SELECT * FROM ORDERS


--������� ������ ���, �� ������ ������, ��� ��� ������������ ��������� ��������
SELECT * FROM COUNTRY

DELETE FROM COUNTRY
WHERE COUNTRY.name = '���'

SELECT * FROM COUNTRY


--������� �������������� ����� (�� ������� ��� �������)
SELECT * FROM HOTEL

--1
DELETE  HOTEL 
WHERE hotel_id IN
	(SELECT hotel_id FROM HOTEL
	WHERE NOT hotel_id IN (SELECT h.hotel_id FROM HOTEL h,ROOM r,ORDERS o
		WHERE h.hotel_id = r.hotel_id
		AND r.room_id = o.room_id
		GROUP BY h.hotel_id))

--2
WITH h(id) AS
     (select distinct hotel.hotel_id
from hotel left join room on hotel.hotel_id = room.hotel_id left join orders on room.room_id = orders.room_id
where order_id is NOT NULL)

delete from hotel
from hotel left join h on hotel.hotel_id = h.id
where h.id is NULL

select * from hotel