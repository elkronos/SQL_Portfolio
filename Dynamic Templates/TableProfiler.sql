/*
    Assumptions and Notes:
    1. The script assumes the use of SQL Server, as it utilizes specific system views and functions available in SQL Server.
    2. It is assumed that the user executing this script has sufficient permissions to access system views and all tables in the database.
    3. The script calculates the size of each table in kilobytes. It assumes that the database uses standard page sizes (8 KB per page).
    4. The summary report includes all tables in the database. If you need to limit the report to specific schemas or tables, modifications to the query will be required.
    5. The script does not account for table partitions. If the database uses table partitioning, the size calculation might need adjustments.
    6. Performance considerations: This script may take longer to execute in databases with a large number of tables or large table sizes.
    7. Security considerations: Ensure that the dynamic SQL does not expose the database to SQL injection risks, especially if modifying the script to accept external input.
*/

DECLARE @Sql NVARCHAR(MAX);

SET @Sql = (
    SELECT STRING_AGG(CAST('
SELECT 
    ''' + TABLE_SCHEMA + '.' + TABLE_NAME + ''' AS TableName,
    (SELECT COUNT(*) FROM [' + TABLE_SCHEMA + '].[' + TABLE_NAME + ']) AS TotalRows,
    ' + CAST(COUNT(COLUMN_NAME) AS VARCHAR(10)) + ' AS NumberOfColumns,
    ' + CAST(COUNT(CASE WHEN IS_NULLABLE = ''YES'' THEN 1 END) AS VARCHAR(10)) + ' AS NullableColumns,
    (SELECT SUM(alloUni.used_pages) * 8 FROM sys.tables sysTab
        INNER JOIN sys.indexes ind ON sysTab.object_id = ind.object_id
        INNER JOIN sys.partitions parti ON ind.object_id = parti.object_id AND ind.index_id = parti.index_id
        INNER JOIN sys.allocation_units alloUni ON parti.partition_id = alloUni.container_id
        WHERE sysTab.name = ''' + TABLE_NAME + ''' AND sysTab.schema_id = SCHEMA_ID(''' + TABLE_SCHEMA + ''')) AS TableSizeKB'
        AS NVARCHAR(MAX)), ' UNION ALL ')
    FROM INFORMATION_SCHEMA.COLUMNS
    GROUP BY TABLE_SCHEMA, TABLE_NAME
);

EXEC sp_executesql @Sql;
