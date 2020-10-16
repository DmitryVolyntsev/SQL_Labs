USE best
DROP USER testuser
/*DROP LOGIN testlog
CREATE LOGIN testlog WITH PASSWORD = 'testlog'*/
CREATE USER testuser FOR LOGIN testlog
GO

--1
GRANT SELECT,UPDATE,INSERT ON REVIEW TO testuser

EXECUTE AS USER = 'testuser'/*использует как учетку*/

SELECT * FROM REVIEW
UPDATE REVIEW
SET rating = 1
WHERE traveler_id = 208
SELECT * FROM REVIEW

REVERT/*возвращается к своей учетке*/

--2
GRANT SELECT (hotel_name, stars, email, phone_number) ON HOTEL TO testuser
GRANT UPDATE (stars, email) ON HOTEL TO testuser

EXECUTE AS USER = 'testuser'/*использует как учетку*/

SELECT location_id FROM HOTEL/*не работает*/
UPDATE HOTEL
SET stars = 1
WHERE hotel_id = 105
SELECT stars FROM HOTEL

REVERT/*возвращается к своей учетке*/

--3
DENY SELECT ON TRAVELER TO testuser
GRANT SELECT ON TRAVELER TO testuser

EXECUTE AS USER = 'testuser'/*использует как учетку*/
SELECT * FROM TRAVELER
REVERT/*возвращается к своей учетке*/

--4 - view
GRANT SELECT ON test_view TO testuser

--5 - создание роли через ALTER
CREATE ROLE tester 
DENY UPDATE, SELECT ON  HOTEL TO tester
ALTER ROLE tester
ADD member testuser

/*select * from sys.database_role_members
select * from sys.database_principals*/

/*REVOKE/*отмена разрешений/запретов*/ UPDATE, SELECT ON  test_view TO tester*/
GRANT UPDATE, SELECT ON  HOTEL/*test_view*/ TO testuser

EXECUTE AS USER = 'testuser'/*использует как учетку*/
SELECT * FROM test_view
REVERT/*возвращается к своей учетке*/

ALTER ROLE tester 
DROP member testuser
DROP ROLE tester

--6 - создание роли через системную процедуру
CREATE ROLE testrole

GRANT UPDATE([Отель]) ON test_view TO testrole
EXECUTE sp_addrolemember testrole, testuser

DROP ROLE testrole