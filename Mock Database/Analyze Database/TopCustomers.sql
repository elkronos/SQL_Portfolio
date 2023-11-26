SELECT
    Users.Username,
    SUM(OrderDetails.Quantity * OrderDetails.PriceAtTimeOfOrder) AS TotalSpent
FROM
    Users
JOIN
    Orders ON Users.UserID = Orders.UserID
JOIN
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Users.UserID
ORDER BY
    TotalSpent DESC
LIMIT 10;