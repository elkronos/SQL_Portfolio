WITH CTE AS (
    SELECT TOP 10 *
    FROM Employees
    ORDER BY HireDate DESC
)
UPDATE CTE
SET Status = 'Under Review';