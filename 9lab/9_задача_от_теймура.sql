DROP TABLE TAB1;
CREATE TABLE TAB1 ([�����] VARCHAR(50), [�������] VARCHAR(300));

IF OBJECT_ID ('DDLTRIG', 'TR') IS NOT NULL
DROP TRIGGER DDLTRIG ON ALL SERVER
DROP TRIGGER DDLTRIG ON DATABASE
GO

CREATE TRIGGER DDLTRIG ON DATABASE
FOR CREATE_TABLE
AS
INSERT INTO dbo.TAB1 VALUES (
	ORIGINAL_LOGIN(), 
	(SELECT EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)'))
						)

select * from TAB1