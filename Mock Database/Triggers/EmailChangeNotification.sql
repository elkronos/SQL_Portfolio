CREATE TABLE EmailChangeLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    OldEmail VARCHAR(100),
    NewEmail VARCHAR(100),
    ChangeDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

DELIMITER //
CREATE TRIGGER AfterEmailUpdate
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    IF NEW.Email <> OLD.Email THEN
        INSERT INTO EmailChangeLog(UserID, OldEmail, NewEmail, ChangeDate)
        VALUES (NEW.UserID, OLD.Email, NEW.Email, NOW());
    END IF;
END;
//
DELIMITER ;