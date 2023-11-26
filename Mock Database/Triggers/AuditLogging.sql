CREATE TABLE UserLoginAudit (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    LoginTime DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

DELIMITER //
CREATE TRIGGER AfterUserLogin
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    IF NEW.LastLogin <> OLD.LastLogin THEN
        INSERT INTO UserLoginAudit(UserID, LoginTime)
        VALUES (NEW.UserID, NEW.LastLogin);
    END IF;
END;
//
DELIMITER ;