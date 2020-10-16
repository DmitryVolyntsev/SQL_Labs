SET STATISTICS IO ON
SET STATISTICS TIME ON

--no Index
SELECT c.ContactName, o.OrderID, o.OrderDate FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
AND o.Freight > 20
AND (c.Country = 'Portugal'
	OR c.Country = 'Brazil')

SET STATISTICS IO OFF
SET STATISTICS TIME OFF