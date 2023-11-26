SELECT
    Users.Username,
    Products.ProductName,
    OrderDetails.Quantity,
    OrderDetails.PriceAtTimeOfOrder,
    Orders.OrderDate
FROM
    Users
JOIN
    Orders ON Users.UserID = Orders.UserID
JOIN
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN
    Products ON OrderDetails.ProductID = Products.ProductID
ORDER BY
    Users.Username, Orders.OrderDate;