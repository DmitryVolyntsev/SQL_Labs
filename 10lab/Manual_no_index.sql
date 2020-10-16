--Покупатели из Испании с должностью Sales Manager

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

--Запрос без индекса
SELECT * FROM Customers
WHERE Country = 'Spain'
AND ContactTitle = 'Sales Manager'

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;