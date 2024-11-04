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

    IF (EXISTS (SELECT username FROM [User] WHERE username=@username))
    BEGIN
        RAISERROR('Username already exists', 16, 1)
        RETURN;
    END;

    INSERT INTO [User] (username, passhash, fullname, isbuyer, isseller)
    VALUES (@username, @passhash, @fullname, @isbuyer, @isseller);
END;

-- 2. Update listed item with buyer and purchase date
-- important to ensure item is not bought twice
CREATE PROCEDURE UpdateItem
    @buyer_username VARCHAR(50),
    @item_id INT,
    @purchase_date DATE
AS
BEGIN
    IF (NOT EXISTS (SELECT username FROM Users WHERE username=@buyer_username))
    BEGIN
        RAISERROR('Buyer username does not exist', 16, 1)
        RETURN;
    END;
    IF (NOT EXISTS (SELECT item_id FROM ListedItem WHERE item_id=@item_id))
    BEGIN
        RAISERROR('Item does not exist', 16, 1)
        RETURN;
    END;

    UPDATE ListedItem
    SET buyer_username=@buyer_username, purchase_date=@purchase_date
    WHERE item_id=@item_id;
END;


-- 3. Remove item from wishlist/shopping cart when bought
-- important to ensure item can no longer be bought
