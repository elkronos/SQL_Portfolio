-- Example: Normalize Product Prices
ALTER TABLE Products ADD NormalizedPrice DECIMAL(10, 4);

UPDATE Products
SET NormalizedPrice = (Price - MinPrice) / (MaxPrice - MinPrice)
FROM (
    SELECT MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice FROM Products
) AS PriceStats;