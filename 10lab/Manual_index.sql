--���������� �� ������� � ���������� Sales Manager

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

CREATE CLUSTERED INDEX customers_country_index ON Customers(country)

--������ � ��������
SELECT * FROM Customers
WHERE Country = 'Spain'
AND ContactTitle = 'Sales Manager'

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

DROP INDEX customers_country_index ON Customers
