-- Example: Assigning 'Admin' role to a user with UserID = 1
INSERT INTO UserRoles (UserID, RoleID) VALUES (1, (SELECT RoleID FROM Roles WHERE RoleName = 'Admin'));