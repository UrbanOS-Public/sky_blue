--connect sql to purview

Create user 'pbi-aim-purview-dev-eus' FROM EXTERNAL PROVIDER
GO
EXEC sp_addrolemember 'db_owner', 'pbi-aim-purview-dev-eus'
GO
Create master key
Go


--connect sql to data factory

Create user 'pbi-aim-purview-dev-eus' FROM EXTERNAL PROVIDER
GO
EXEC sp_addrolemember 'db_owner', 'pbi-aim-purview-dev-eus'
GO