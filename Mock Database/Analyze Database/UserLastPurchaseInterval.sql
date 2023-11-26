WITH LastPurchase AS (
    SELECT 
        UserID, 
        MAX(OrderDate) AS LastOrderDate
    FROM 
        Orders
    GROUP BY 
        UserID
)
SELECT 
    Users.UserID,
    Users.Username,
    DATEDIFF(CURRENT_DATE, LastPurchase.LastOrderDate) AS DaysSinceLastPurchase
FROM 
    Users
LEFT JOIN 
    LastPurchase ON Users.UserID = LastPurchase.UserID;