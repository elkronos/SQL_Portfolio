-- Insert mock data into each table
INSERT INTO Users (Username, Email, PasswordHash, DateJoined) VALUES ('TestUser', 'testuser@example.com', 'hash', NOW());
INSERT INTO Products (ProductName, Description, Price, Stock, DateAdded) VALUES ('TestProduct', 'Description', 10.00, 100, NOW());
INSERT INTO Orders (UserID, OrderDate, TotalAmount, Status) VALUES (1, NOW(), 100.00, 'Processing');
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, PriceAtTimeOfOrder) VALUES (1, 1, 10, 10.00);

-- Test data retrieval
SELECT * FROM Users;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;