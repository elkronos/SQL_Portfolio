-- Add Encrypted Credit Card Info to Users
ALTER TABLE Users ADD COLUMN EncryptedCreditCardInfo VARBINARY(255);

-- Procedure to Update Encrypted Credit Card Information
DELIMITER //
CREATE PROCEDURE UpdateCreditCardInfo(IN userID INT, IN creditCardInfo VARCHAR(255))
BEGIN
    DECLARE encryptedInfo VARBINARY(255);

    -- Encrypt the credit card info
    SET encryptedInfo = AES_ENCRYPT(creditCardInfo, 'your_encryption_key');

    -- Update the user's credit card info
    UPDATE Users SET EncryptedCreditCardInfo = encryptedInfo WHERE UserID = userID;
END //
DELIMITER ;