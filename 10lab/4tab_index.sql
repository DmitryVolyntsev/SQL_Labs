SET STATISTICS IO ON
SET STATISTICS TIME ON

CREATE CLUSTERED INDEX products_index ON Products(ProductID, UnitPrice)
CREATE CLUSTERED INDEX orders_index ON Orders(OrderId, CustomerID)
CREATE CLUSTERED INDEX customers_index ON Customers(CustomerID, City)
CREATE CLUSTERED INDEX orderDetails_index ON OrderDetails(Discount, ProductID)

SELECT TOP 15 WITH TIES AVG(p.UnitPrice) AS 'Average unit price', c.City FROM Products p, OrderDetails od, Orders o, Customers c
WHERE p.ProductID = od.ProductID
AND o.OrderID = od.OrderID
AND o.CustomerID = c.CustomerID
AND od.Discount > 0.15
AND o.ShipRegion IS NOT NULL
GROUP BY c.City
ORDER BY AVG(p.UnitPrice) DESC

DROP INDEX customers_index ON Customers
DROP INDEX orders_index ON Orders
DROP INDEX orderDetails_index ON OrderDetails
DROP INDEX products_index ON Products

SET STATISTICS IO OFF
SET STATISTICS TIME OFF