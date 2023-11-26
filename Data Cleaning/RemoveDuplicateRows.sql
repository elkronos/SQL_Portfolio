-- This is a template script; replace `YourTable` and `YourColumn` with actual table and column names
DELETE t1
FROM
    YourTable t1
JOIN
    YourTable t2 
WHERE
    t1.Id < t2.Id AND
    t1.YourColumn = t2.YourColumn;