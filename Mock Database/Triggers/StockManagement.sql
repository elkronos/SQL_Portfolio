DELIMITER //
CREATE TRIGGER AfterOrderDetailInsert
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products
    SET Stock = Stock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END;
//
DELIMITER ;