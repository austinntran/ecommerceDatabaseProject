CREATE TRIGGER trg_UserToSeller
ON ListedItem
AFTER INSERT
AS
BEGIN
    UPDATE [User]
    SET isseller = 1
    FROM [User] u 
    INNER JOIN inserted i ON u.username = i.seller_username;
END;
