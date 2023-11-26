WITH CustomersCTE AS (
    SELECT CustomerID, Name
    FROM Customers
    WHERE Location = 'New York'
),
OrdersCTE AS (
    SELECT OrderID, CustomerID
    FROM Orders
    WHERE OrderDate > '2022-01-01'
)
SELECT c.Name, o.OrderID
FROM CustomersCTE c
JOIN OrdersCTE o ON c.CustomerID = o.CustomerID;
