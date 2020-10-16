declare @TestTable as table (a int)
insert into @TestTable(a) values (1), (1), (1), (3), (3), (5), (7), (9), (9)

;with CTE as 
(
select A, row_number() over (partition by A order by A) as Number
from @TestTable
)
delete
from CTE
where Number <> 1

select * from @TestTable 



;WITH Summa(a) AS
(
SELECT 1
UNION ALL
SELECT a + 1 FROM Summa WHERE a < 1000
)

SELECT * FROM Summa
option (MAXRECURSION 0)