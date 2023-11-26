-- User Login Script
DELIMITER //
CREATE PROCEDURE UserLogin(IN usernameInput VARCHAR(50), IN passwordHashInput VARCHAR(255))
BEGIN
    SELECT UserID, Username, Email, LastLogin
    FROM Users
    WHERE Username = usernameInput AND PasswordHash = passwordHashInput;
END //
DELIMITER ;