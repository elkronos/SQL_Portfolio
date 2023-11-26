-- Replace `YourTable` and `YourColumn`
UPDATE YourTable
SET YourColumn = CONCAT(UPPER(SUBSTRING(YourColumn, 1, 1)), LOWER(SUBSTRING(YourColumn, 2)));