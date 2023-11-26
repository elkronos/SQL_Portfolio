-- Replace `YourTable` and add conditions for specific columns if needed
UPDATE YourTable
SET 
    Column1 = TRIM(Column1),
    Column2 = TRIM(Column2),
    -- Add more columns as needed
WHERE
    Column1 LIKE ' %' OR Column1 LIKE '% ' OR
    Column2 LIKE ' %' OR Column2 LIKE '% ';