-- Add New Product Script
DELIMITER //
CREATE PROCEDURE AddNewProduct(IN productName VARCHAR(100), IN description TEXT, IN price DECIMAL(10, 2), IN stock INT)
BEGIN
    IF price < 0 OR stock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid price or stock value';
    ELSE
        INSERT INTO Products (ProductName, Description, Price, Stock, DateAdded)
        VALUES (productName, description, price, stock, NOW());
    END IF;
END //
DELIMITER ;