--���������� �������
declare @TestTable as table (A int identity)

insert into @TestTable default values
insert into @TestTable default values
insert into @TestTable default values

select * from @TestTable


--������� ��������
declare @TestValue as nvarchar(10)
set @TestValue = 'aaa   '
select len(@TestValue + 'a')-1
