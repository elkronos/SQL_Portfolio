-- Check constraints in OrderDetails for Quantity
SELECT CONSTRAINT_NAME, CHECK_CLAUSE 
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = 'YourDatabaseName' AND TABLE_NAME = 'OrderDetails';

-- Check constraints in Orders for TotalAmount
SELECT CONSTRAINT_NAME, CHECK_CLAUSE 
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = 'YourDatabaseName' AND TABLE_NAME = 'Orders';

-- Check constraints in Products for Price and Stock
SELECT CONSTRAINT_NAME, CHECK_CLAUSE 
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = 'YourDatabaseName' AND TABLE_NAME = 'Products';