-- View to Monitor Unusual Login Activities
-- X being a threshold indicating unusual activity
CREATE VIEW UnusualLoginActivities AS
SELECT 
    UserID, 
    COUNT(*) AS LoginAttempts, 
    MAX(LastLogin) AS LastLogin
FROM Users
GROUP BY UserID
HAVING COUNT(*) > X;