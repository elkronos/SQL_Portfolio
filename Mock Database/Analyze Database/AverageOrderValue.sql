WITH OrderTotals AS (
    SELECT 
        UserID, 
        AVG(TotalAmount) AS AvgOrderValue
    FROM 
        Orders
    GROUP BY 
        UserID
)
SELECT 
    Users.UserID,
    Users.Username,
    COALESCE(OrderTotals.AvgOrderValue, 0) AS AvgOrderValue
FROM 
    Users
LEFT JOIN 
    OrderTotals ON Users.UserID = OrderTotals.UserID;