-- Check if index idx_username is created on Users(Username)
SHOW INDEX FROM Users WHERE Key_name = 'idx_username';

-- Check if index idx_productname is created on Products(ProductName)
SHOW INDEX FROM Products WHERE Key_name = 'idx_productname';

-- Check if index idx_orderdate is created on Orders(OrderDate)
SHOW INDEX FROM Orders WHERE Key_name = 'idx_orderdate';
