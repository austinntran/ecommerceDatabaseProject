-- 1. Insert user into database
-- important to reduce need for multiple insert lines 
CREATE PROCEDURE AddCustomer
    @username VARCHAR(50),
    @passhash VARCHAR(100),
    @fullname VARCHAR(30),
    @isbuyer BIT,
    @isseller BIT
AS
BEGIN
    IF (LEN(@username) < 5) 
    BEGIN
        RAISERROR('Username must be over 5 characters', 16, 1)
        RETURN;
    END;

    IF (EXISTS (SELECT username FROM customer WHERE username=@username))
    BEGIN
        RAISERROR('Username already exists', 16, 1)
        RETURN;
    END;

    OPEN SYMMETRIC KEY UserPasswordKey
    DECRYPTION BY CERTIFICATE UserPasswordCert;

    INSERT INTO Customer (username, EncryptedPasswordHash, fullname, isbuyer, isseller)
    VALUES (@username, EncryptByKey(Key_GUID('UserPasswordKey'), @passhash), @fullname, @isbuyer, @isseller);

    CLOSE SYMMETRIC KEY UserPasswordKey;
END;

-- 2. Update listed item with buyer and purchase date
-- important to ensure item is not bought twice

-- 3. Remove item from wishlist/shopping cart when bought
-- important to ensure item can no longer be bought
