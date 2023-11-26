SELECT
    YEAR(Orders.OrderDate) AS Year,
    MONTH(Orders.OrderDate) AS Month,
    COUNT(*) AS NumberOfOrders,
    SUM(OrderDetails.Quantity * OrderDetails.PriceAtTimeOfOrder) AS TotalSales
FROM
    Orders
JOIN
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Year, Month
ORDER BY
    Year, Month;