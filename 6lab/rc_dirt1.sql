--Dirty read (RC)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION

Select stars FROM HOTEL
WHERE hotel_id = 120

Select stars FROM HOTEL
WHERE hotel_id = 120

Select stars FROM HOTEL
WHERE hotel_id = 120
COMMIT