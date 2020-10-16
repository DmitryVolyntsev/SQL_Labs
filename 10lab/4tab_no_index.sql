SET STATISTICS IO ON
SET STATISTICS TIME ON

SELECT TOP 15 WITH TIES AVG(p.UnitPrice) AS 'Average unit price', c.City FROM Products p, OrderDetails od, Orders o, Customers c
WHERE p.ProductID = od.ProductID
AND o.OrderID = od.OrderID
AND o.CustomerID = c.CustomerID
AND od.Discount > 0.15
AND o.ShipRegion IS NOT NULL
GROUP BY c.City
ORDER BY AVG(p.UnitPrice) DESC

SET STATISTICS IO OFF
SET STATISTICS TIME OFF