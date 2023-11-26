-- Procedure to Add a New Role
DELIMITER //
CREATE PROCEDURE AddNewRole(IN roleName VARCHAR(50))
BEGIN
    INSERT INTO Roles (RoleName) VALUES (roleName);
END //
DELIMITER ;

-- Procedure to Assign a Role to a User
DELIMITER //
CREATE PROCEDURE AssignRoleToUser(IN userID INT, IN roleName VARCHAR(50))
BEGIN
    INSERT INTO UserRoles (UserID, RoleID) 
    VALUES (userID, (SELECT RoleID FROM Roles WHERE RoleName = roleName));
END //
DELIMITER ;

-- Procedure to Check User's Role
DELIMITER //
CREATE PROCEDURE CheckUserRole(IN userID INT, OUT roleName VARCHAR(50))
BEGIN
    SELECT R.RoleName INTO roleName 
    FROM UserRoles UR
    JOIN Roles R ON UR.RoleID = R.RoleID
    WHERE UR.UserID = userID;
END //
DELIMITER ;