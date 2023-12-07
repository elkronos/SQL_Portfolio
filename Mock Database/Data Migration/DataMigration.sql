-- Old user table
CREATE TABLE Old_Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Password VARCHAR(50) NOT NULL, -- Note: Storing passwords in plain text is a bad practice.
    DateJoined DATETIME NOT NULL
);

-- To move to the new user table
CREATE TABLE New_Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL, -- Passwords are now hashed.
    DateJoined DATETIME NOT NULL,
    LastLogin DATETIME
);


-- Assuming you have a function to hash passwords, replace HASH_PASSWORD with the actual function
-- Inserting data into the new table
INSERT INTO New_Users (UserID, Username, Email, PasswordHash, DateJoined)
SELECT 
    UserID, 
    Username, 
    Email, 
    HASH_PASSWORD(Password), -- Replace with actual hash function
    DateJoined 
FROM 
    Old_Users;

-- Optional: If you want to verify the number of rows transferred
SELECT COUNT(*) FROM Old_Users;
SELECT COUNT(*) FROM New_Users;