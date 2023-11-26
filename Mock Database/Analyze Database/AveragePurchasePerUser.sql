SELECT
    Users.Username,
    AVG(OrderDetails.Quantity * OrderDetails.PriceAtTimeOfOrder) AS AvgPurchaseValue
FROM
    Users
JOIN
    Orders ON Users.UserID = Orders.UserID
JOIN
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Users.UserID;