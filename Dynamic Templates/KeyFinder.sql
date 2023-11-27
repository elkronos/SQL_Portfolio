/*
    Assumptions and Notes:
    1. This script is for SQL Server and uses its system views and functions.
    2. It first finds exact column name matches across tables. If none are found, it uses SOUNDEX for fuzzy matching.
    3. The script requires permissions to access system views.
    4. SOUNDEX and DIFFERENCE provide basic phonetic comparisons, which can approximate fuzzy matching.
    5. Performance considerations: The script may execute more slowly in databases with many tables and columns.
    6. Security considerations: Ensure safe usage, as with any script querying system views.
*/

DECLARE @ExactMatches TABLE (
    ColumnName NVARCHAR(256),
    Tables NVARCHAR(MAX)
);

DECLARE @FuzzyMatches TABLE (
    ColumnName NVARCHAR(256),
    MatchedWith NVARCHAR(256),
    Tables NVARCHAR(MAX)
);

-- Finding exact matches
INSERT INTO @ExactMatches
SELECT
    c.COLUMN_NAME,
    STRING_AGG(t.TABLE_NAME, ', ') AS TablesSharingColumnName
FROM 
    INFORMATION_SCHEMA.COLUMNS c
JOIN 
    INFORMATION_SCHEMA.TABLES t ON c.TABLE_NAME = t.TABLE_NAME
WHERE 
    t.TABLE_TYPE = 'BASE TABLE'
GROUP BY 
    c.COLUMN_NAME
HAVING 
    COUNT(DISTINCT t.TABLE_NAME) > 1;

-- Finding fuzzy matches if no exact matches are found
IF NOT EXISTS (SELECT * FROM @ExactMatches)
BEGIN
    INSERT INTO @FuzzyMatches
    SELECT 
        c1.COLUMN_NAME, 
        c2.COLUMN_NAME AS MatchedWith,
        STRING_AGG(DISTINCT c1.TABLE_NAME, ', ') + ', ' + STRING_AGG(DISTINCT c2.TABLE_NAME, ', ') AS Tables
    FROM 
        INFORMATION_SCHEMA.COLUMNS c1
    CROSS JOIN 
        INFORMATION_SCHEMA.COLUMNS c2
    WHERE 
        c1.COLUMN_NAME != c2.COLUMN_NAME
        AND SOUNDEX(c1.COLUMN_NAME) = SOUNDEX(c2.COLUMN_NAME)
        AND c1.TABLE_NAME != c2.TABLE_NAME
    GROUP BY 
        c1.COLUMN_NAME, c2.COLUMN_NAME;
END

-- Outputting results
SELECT * FROM @ExactMatches
UNION ALL
SELECT * FROM @FuzzyMatches;