--Lost changes

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION

SELECT * from a

UPDATE HOTEL SET stars =
(SELECT q FROM a 
WHERE id = 1)
WHERE hotel_id = 120
COMMIT















/*begin transaction [1]
select @@TRANCOUNT
begin transaction [2]
select @@TRANCOUNT
save transaction [2]
rollback transaction [2]
select @@TRANCOUNT*/