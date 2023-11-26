SELECT 
    UserID,
    Username,
    DATEDIFF(CURRENT_DATE, DateJoined) AS AccountAgeDays
FROM 
    Users;