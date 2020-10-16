--�������, ������������� ������������
SELECT so.name AS '�������', su.name AS '������������' FROM sysobjects so, sysusers su
WHERE so.xtype = 'U' --��� �������
AND so.uid = su.uid
AND su.name = USER_NAME()
/*AND so.id NOT IN (SELECT major_id FROM sys.extended_properties)*/


--�������, �������, ��������� �� null, ��� ������ �������, ��� ������
SELECT so.name AS '�������', sa.name AS '�������', sa.is_nullable AS '�������� ����?', TYPE_NAME(sa.user_type_id/*������������� ������������� ������������� ���� �������*/) AS '���', sa.max_length AS '������'
FROM sys.all_columns /*� ����������������, � ���������*/ sa, sysobjects so, sysusers su
WHERE so.xtype = 'U'
AND so.id = sa.object_id --������������� �������, �������� ����������� �������
AND so.uid = su.uid
AND su.name = USER_NAME()


--����������� �����������, ��� �������, ��� �� ����
SELECT so1.name AS 'Constraint', so2.name AS '�������', so1.xtype AS '����' FROM sysobjects so1, sysobjects so2, sysusers su
WHERE (so1.xtype = 'PK' OR so1.xtype = 'F')
AND so1.parent_obj /*������������� ������������ �������*/= so2.id
AND su.uid = so2.uid
AND su.name = USER_NAME()


--������� ����, ��� �������, ������� ������������� �����
SELECT so1.name AS 'Constraint', so2.name AS '�������', so3.name AS '������� ������������� �����' 
FROM sysobjects so1, sysobjects so2, sysobjects so3, sysreferences ref, sysusers su
WHERE so1.id = ref.constid --constid - ������������� ���������� ����������� �� ������� ���� �� sys.objects
AND so2.id = ref.fkeyid --������������� �������, ���������� ������� ����
AND so3.id = ref.rkeyid --������������� �������, ������. ��� ������������ ����
AND su.uid = so2.uid
AND su.name = USER_NAME()


--������������� � ��� ������
SELECT so.name AS '�������������', sc.text /*�������� �������*/ AS '������' FROM sysobjects so, sysusers su, syscomments sc
WHERE so.xtype = 'V'
AND so.id = sc.id
AND su.uid = so.uid
AND su.name = USER_NAME()


--�������, ��� �������
SELECT sotr.name AS '�������', sotb.name AS '�������' FROM sysobjects sotr, sysobjects sotb, sysusers su
WHERE sotr.xtype = 'TR'
AND sotr.parent_obj = sotb.id
AND su.uid = sotr.uid
AND su.name = USER_NAME()