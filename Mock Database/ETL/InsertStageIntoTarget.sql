INSERT INTO ProductSalesAnalysis (ProductID, ProductName, Category, TotalSales, TotalUnitsSold, AverageSaleAmount, AverageUnitPrice)
SELECT
    ProductID,
    ProductName,
    Category,
    SUM(SaleAmount) AS TotalSales,
    SUM(Quantity) AS TotalUnitsSold,
    AVG(SaleAmount) AS AverageSaleAmount,
    AVG(Price) AS AverageUnitPrice
FROM
    Staging_ProductSales
GROUP BY
    ProductID, ProductName, Category;