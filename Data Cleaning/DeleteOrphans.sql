-- Replace `ChildTable`, `ChildColumn`, `ParentTable`, and `ParentColumn`
DELETE FROM ChildTable
WHERE ChildColumn NOT IN (SELECT ParentColumn FROM ParentTable);