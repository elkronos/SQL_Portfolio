SELECT
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(OrderDetails.Quantity * OrderDetails.PriceAtTimeOfOrder) AS MonthlySales,
    SUM(SUM(OrderDetails.Quantity * OrderDetails.PriceAtTimeOfOrder)) OVER (ORDER BY YEAR(OrderDate), MONTH(OrderDate)) AS CumulativeSales
FROM
    Orders
JOIN
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Year, Month
ORDER BY
    Year, Month;