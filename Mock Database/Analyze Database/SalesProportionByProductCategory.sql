WITH TotalSales AS (
    SELECT 
        SUM(OrderDetails.Quantity * OrderDetails.PriceAtTimeOfOrder) AS Total
    FROM 
        OrderDetails
),
CategorySales AS (
    SELECT 
        Products.Category,
        SUM(OrderDetails.Quantity * OrderDetails.PriceAtTimeOfOrder) AS CategoryTotal
    FROM 
        Products
    JOIN 
        OrderDetails ON Products.ProductID = OrderDetails.ProductID
    GROUP BY 
        Products.Category
)
SELECT 
    CategorySales.Category,
    CategorySales.CategoryTotal / TotalSales.Total AS SalesProportion
FROM 
    CategorySales, TotalSales;