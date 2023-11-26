CREATE TABLE ProductsArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2),
    Stock INT,
    DateAdded DATETIME,
    DateArchived DATETIME
);

DELIMITER //
CREATE TRIGGER BeforeProductDelete
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductsArchive(ProductID, ProductName, Description, Price, Stock, DateAdded, DateArchived)
    VALUES (OLD.ProductID, OLD.ProductName, OLD.Description, OLD.Price, OLD.Stock, OLD.DateAdded, NOW());
END;
//
DELIMITER ;