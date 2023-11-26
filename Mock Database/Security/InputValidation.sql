-- Example of a Parameterized Query for Product Search
DELIMITER //
CREATE PROCEDURE SearchProducts(IN searchQuery VARCHAR(100))
BEGIN
    SELECT * FROM Products WHERE ProductName LIKE CONCAT('%', searchQuery, '%');
END //
DELIMITER ;