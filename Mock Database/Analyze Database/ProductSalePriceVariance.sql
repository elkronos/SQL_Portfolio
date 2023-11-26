SELECT 
    Products.ProductID,
    Products.ProductName,
    VAR_SAMP(OrderDetails.PriceAtTimeOfOrder) AS PriceVariance
FROM 
    Products
JOIN 
    OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY 
    Products.ProductID;