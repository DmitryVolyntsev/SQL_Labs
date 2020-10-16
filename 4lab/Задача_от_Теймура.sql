select * from hotel
select * from room
select * from orders



DELETE FROM HOTEL
WHERE hotel_name = 'TRYP Tenerife'



UPDATE ORDERS
SET orders.room_id=(SELECT TOP 1 room_id FROM ROOM r1,HOTEL h1
				WHERE r1.hotel_id=h1.hotel_id
				AND h1.stars=3
				--не работает вложенный селект из-за удаления отеля, из-за этого выбрать звезды невозможно
				/*(SELECT stars from HOTEL h2
								WHERE h2.hotel_name='TRYP Tenerife')*/)
				FROM ROOM
WHERE orders.room_id IS NULL