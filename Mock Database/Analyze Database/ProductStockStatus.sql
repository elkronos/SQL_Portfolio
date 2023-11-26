SELECT
    ProductName,
    Stock
FROM
    Products
WHERE
    Stock < 10
ORDER BY
    Stock;