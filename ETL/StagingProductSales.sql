CREATE TABLE Staging_ProductSales AS
SELECT
    s.SaleID,
    s.ProductID,
    p.ProductName,
    p.Category,
    s.SaleDate,
    s.Quantity,
    s.SaleAmount,
    p.Price
FROM
    SalesData s
JOIN
    ProductData p ON s.ProductID = p.ProductID;
