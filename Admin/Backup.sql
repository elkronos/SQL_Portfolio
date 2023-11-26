BACKUP DATABASE [YourDatabaseName]
TO DISK = N'C:\Backups\YourDatabaseName.bak'
WITH NOFORMAT, NOINIT, NAME = 'YourDatabaseName-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10;