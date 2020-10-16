--Таблицы, принадлежащие пользователю
SELECT so.name AS 'Таблица', su.name AS 'Пользователь' FROM sysobjects so, sysusers su
WHERE so.xtype = 'U' --тип таблица
AND so.uid = su.uid
AND su.name = USER_NAME()
/*AND so.id NOT IN (SELECT major_id FROM sys.extended_properties)*/


--Таблица, столбец, допускает ли null, тип данных столбца, его размер
SELECT so.name AS 'Таблица', sa.name AS 'Столбец', sa.is_nullable AS 'Возможен ноль?', TYPE_NAME(sa.user_type_id/*Идентификатор определенного пользователем типа столбца*/) AS 'Тип', sa.max_length AS 'Размер'
FROM sys.all_columns /*и пользовательские, и системные*/ sa, sysobjects so, sysusers su
WHERE so.xtype = 'U'
AND so.id = sa.object_id --идентификатор объекта, которому принадлежит столбец
AND so.uid = su.uid
AND su.name = USER_NAME()


--Ограничение целостности, его таблица, что за ключ
SELECT so1.name AS 'Constraint', so2.name AS 'Таблица', so1.xtype AS 'Ключ' FROM sysobjects so1, sysobjects so2, sysusers su
WHERE (so1.xtype = 'PK' OR so1.xtype = 'F')
AND so1.parent_obj /*идентификатор родительской таблицы*/= so2.id
AND su.uid = so2.uid
AND su.name = USER_NAME()


--Внешний ключ, его таблица, таблица родительского ключа
SELECT so1.name AS 'Constraint', so2.name AS 'Таблица', so3.name AS 'Таблица родительского ключа' 
FROM sysobjects so1, sysobjects so2, sysobjects so3, sysreferences ref, sysusers su
WHERE so1.id = ref.constid --constid - идентификатор ссылочного ограничения на внешний ключ из sys.objects
AND so2.id = ref.fkeyid --идентификатор таблицы, содержащей внешний ключ
AND so3.id = ref.rkeyid --идентификатор таблицы, содерж. его родительский ключ
AND su.uid = so2.uid
AND su.name = USER_NAME()


--Представление и его запрос
SELECT so.name AS 'Представление', sc.text /*описание объекта*/ AS 'Скрипт' FROM sysobjects so, sysusers su, syscomments sc
WHERE so.xtype = 'V'
AND so.id = sc.id
AND su.uid = so.uid
AND su.name = USER_NAME()


--Триггер, его таблица
SELECT sotr.name AS 'Триггер', sotb.name AS 'Таблица' FROM sysobjects sotr, sysobjects sotb, sysusers su
WHERE sotr.xtype = 'TR'
AND sotr.parent_obj = sotb.id
AND su.uid = sotr.uid
AND su.name = USER_NAME()