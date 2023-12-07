-- Check primary key and auto-increment for Users
SELECT COLUMN_NAME, COLUMN_KEY, EXTRA 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'UserID';

-- Check primary key and auto-increment for OrderDetails
SELECT COLUMN_NAME, COLUMN_KEY, EXTRA 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'OrderDetails' AND COLUMN_NAME = 'OrderDetailID';

-- Check primary key and auto-increment for Orders
SELECT COLUMN_NAME, COLUMN_KEY, EXTRA 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Orders' AND COLUMN_NAME = 'OrderID';

-- Check primary key and auto-increment for Products
SELECT COLUMN_NAME, COLUMN_KEY, EXTRA 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Products' AND COLUMN_NAME = 'ProductID';
