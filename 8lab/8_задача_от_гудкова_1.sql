SELECT so.name AS 'Таблица',
		sc.name AS 'Столбец',
		sc.is_identity AS 'Is identity?',
		CASE WHEN sc.is_identity = 0 THEN 'NULL' ELSE STR(CONVERT(int, seed_value)) END AS 'Seed',
		CASE WHEN sc.is_identity = 0 THEN 'NULL' ELSE STR(CONVERT(int, increment_value)) END AS 'Increment'
FROM sysobjects so, sys.columns sc, sys.identity_columns sic
WHERE so.id = sc.object_id
AND so.xtype = 'U'
AND so.uid = (SELECT uid FROM sysusers WHERE name = 'dbo')
AND so.id NOT IN (SELECT major_id FROM sys.extended_properties)
AND sc.object_id = sic.object_id