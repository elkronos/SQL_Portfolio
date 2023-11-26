WITH RecentOrders AS (
    SELECT OrderID, OrderDate, CustomerID
    FROM Orders
    WHERE OrderDate > '2022-01-01'
)
SELECT *
FROM RecentOrders;