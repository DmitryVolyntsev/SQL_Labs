--Unrepeated read

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

BEGIN TRANSACTION
Select stars FROM HOTEL
WHERE hotel_id = 120

Select stars FROM HOTEL
WHERE hotel_id = 120

COMMIT