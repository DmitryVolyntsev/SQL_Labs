USE best
DROP USER testuser
/*DROP LOGIN testlog
CREATE LOGIN testlog WITH PASSWORD = 'testlog'*/
CREATE USER testuser FOR LOGIN testlog
GO

--1
GRANT SELECT,UPDATE,INSERT ON REVIEW TO testuser

EXECUTE AS USER = 'testuser'/*���������� ��� ������*/

SELECT * FROM REVIEW
UPDATE REVIEW
SET rating = 1
WHERE traveler_id = 208
SELECT * FROM REVIEW

REVERT/*������������ � ����� ������*/

--2
GRANT SELECT (hotel_name, stars, email, phone_number) ON HOTEL TO testuser
GRANT UPDATE (stars, email) ON HOTEL TO testuser

EXECUTE AS USER = 'testuser'/*���������� ��� ������*/

SELECT location_id FROM HOTEL/*�� ��������*/
UPDATE HOTEL
SET stars = 1
WHERE hotel_id = 105
SELECT stars FROM HOTEL

REVERT/*������������ � ����� ������*/

--3
DENY SELECT ON TRAVELER TO testuser
GRANT SELECT ON TRAVELER TO testuser

EXECUTE AS USER = 'testuser'/*���������� ��� ������*/
SELECT * FROM TRAVELER
REVERT/*������������ � ����� ������*/

--4 - view
GRANT SELECT ON test_view TO testuser

--5 - �������� ���� ����� ALTER
CREATE ROLE tester 
DENY UPDATE, SELECT ON  HOTEL TO tester
ALTER ROLE tester
ADD member testuser

/*select * from sys.database_role_members
select * from sys.database_principals*/

/*REVOKE/*������ ����������/��������*/ UPDATE, SELECT ON  test_view TO tester*/
GRANT UPDATE, SELECT ON  HOTEL/*test_view*/ TO testuser

EXECUTE AS USER = 'testuser'/*���������� ��� ������*/
SELECT * FROM test_view
REVERT/*������������ � ����� ������*/

ALTER ROLE tester 
DROP member testuser
DROP ROLE tester

--6 - �������� ���� ����� ��������� ���������
CREATE ROLE testrole

GRANT UPDATE([�����]) ON test_view TO testrole
EXECUTE sp_addrolemember testrole, testuser

DROP ROLE testrole