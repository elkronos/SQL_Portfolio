SELECT 
    Users.UserID,
    Users.Username,
    COALESCE(SUM(Orders.TotalAmount), 0) AS TotalSpend
FROM 
    Users
LEFT JOIN 
    Orders ON Users.UserID = Orders.UserID
GROUP BY 
    Users.UserID;