-- Update Last Login Timestamp
DELIMITER //
CREATE PROCEDURE UpdateLastLogin(IN userID INT)
BEGIN
    UPDATE Users
    SET LastLogin = NOW()
    WHERE UserID = userID;
END //
DELIMITER ;