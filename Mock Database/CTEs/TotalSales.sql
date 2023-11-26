WITH TotalSales AS (
    SELECT CustomerID, SUM(TotalAmount) AS TotalSpent
    FROM Orders
    GROUP BY CustomerID
)
SELECT CustomerID, TotalSpent
FROM TotalSales
WHERE TotalSpent > 5000;