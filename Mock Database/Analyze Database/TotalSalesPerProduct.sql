SELECT
    Products.ProductName,
    SUM(OrderDetails.Quantity * OrderDetails.PriceAtTimeOfOrder) AS TotalSales
FROM
    Products
JOIN
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY
    Products.ProductName
ORDER BY
    TotalSales DESC;