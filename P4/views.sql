-- 1. A view that restricts user data to contain only usernames, emails, and full names
CREATE VIEW UserInfo AS
(
    SELECT u.username, u.fullname, e.email
    FROM [User] u LEFT OUTER JOIN User_email e
    ON u.username = e.username
);

-- 2. View that shows all available listed items and their conditions, and who sold them
CREATE VIEW AvailableItems AS
(
    SELECT l.seller_username, u.fullname, l.description, l.quantity, l.list_date, c.condition_name
    FROM ListedItem l 
    Inner JOIN Condition c ON l.condition_id = c.condition_id 
    INNER JOIN [User] u ON l.seller_username = u.username
    WHERE l.buyer_username IS NULL
);

-- 3. View that shows all sold listed items and their conditions, and who bought them
CREATE VIEW SoldItems AS
(
    SELECT l.buyer_username, u.fullname, l.description, l.quantity, l.list_date, c.condition_name
    FROM ListedItem l 
    Inner JOIN Condition c ON l.condition_id = c.condition_id 
    INNER JOIN [User] u ON l.buyer_username = u.username
    WHERE l.buyer_username IS NOT NULL
);