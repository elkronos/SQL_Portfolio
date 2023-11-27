/*
    Assumptions and Notes:
    1. The script assumes the use of SQL Server, as it utilizes specific system views and functions of SQL Server.
    2. It assumes that the table name provided in the variable '@TableName' exists in the current database.
    3. The script dynamically generates statistics for each column in the specified table.
    4. It calculates count, percentage of total responses, minimum, and maximum values for each column.
    5. For numeric columns (types: int, bigint, decimal, numeric, float, real), additional statistics like average, and standard deviation are calculated.
    6. The script does not include calculations for median and mode as these are not directly supported in SQL Server and would require custom implementation.
    7. User executing this script must have appropriate permissions to access the specified table and to execute dynamic SQL.
    8. The script uses STRING_AGG function, which is available in SQL Server 2017 and later versions. For earlier versions, an alternative method for string aggregation must be used.
    9. Security considerations: Ensure that the table name input is validated to avoid SQL injection risks, especially if the script is modified to accept external input.
    10. This script is designed for analytical and reporting purposes and may have performance implications on large tables.
*/

DECLARE @TableName NVARCHAR(128) = 'YourTableName';
DECLARE @Sql NVARCHAR(MAX);

SET @Sql = (SELECT STRING_AGG(CAST('
SELECT 
    ''' + COLUMN_NAME + ''' AS ColumnName,
    COUNT(' + COLUMN_NAME + ') AS Count,
    COUNT(' + COLUMN_NAME + ')*100.0/(SELECT COUNT(*) FROM ' + @TableName + ') AS PercentOfResponses,
    MIN(' + COLUMN_NAME + ') AS MinValue,
    MAX(' + COLUMN_NAME + ') AS MaxValue' +
    CASE WHEN DATA_TYPE IN ('int', 'bigint', 'decimal', 'numeric', 'float', 'real') THEN 
    ',
    AVG(CAST(' + COLUMN_NAME + ' AS DECIMAL(18,2))) AS Mean,
    STDEV(CAST(' + COLUMN_NAME + ' AS DECIMAL(18,2))) AS StandardDeviation,
    ELSE '' END +
    ' FROM ' + @TableName AS NVARCHAR(MAX)), ' UNION ALL ')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName);

EXEC sp_executesql @Sql;
