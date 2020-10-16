--Lost changes
drop table a
create table a(id int, q int)
insert into a values (1,0)
select * from a

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION


UPDATE a SET q =
(SELECT stars from HOTEL
WHERE hotel_id = 120)
WHERE id = 1

UPDATE HOTEL SET stars=
(SELECT q + 1  FROM a 
WHERE id = 1)
WHERE hotel_id = 120

COMMIT;
select stars from hotel where hotel_id = 120;