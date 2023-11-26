WITH OldRecords AS (
    SELECT *
    FROM Sales
    WHERE SaleDate < '2021-01-01'
)
DELETE FROM OldRecords;