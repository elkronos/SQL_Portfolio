RESTORE DATABASE [YourDatabaseName]
FROM DISK = N'C:\Backups\YourDatabaseName.bak'
WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 10;