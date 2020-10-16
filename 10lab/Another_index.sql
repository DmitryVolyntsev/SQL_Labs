SET STATISTICS IO ON
SET STATISTICS TIME ON

CREATE CLUSTERED INDEX Customers_Country_Index ON Customers(Country) 
CREATE CLUSTERED INDEX Orders_EmployeeID_Index ON Orders(Freight)

--Index
SELECT c.ContactName, o.OrderID, o.OrderDate FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
AND o.Freight > 20
AND (c.Country = 'Portugal'
	OR c.Country = 'Brazil')


DROP INDEX Customers_Country_Index ON Customers
DROP INDEX Orders_EmployeeID_Index ON Orders

SET STATISTICS IO OFF
SET STATISTICS TIME OFF