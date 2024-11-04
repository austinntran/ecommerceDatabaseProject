-- 1. A view that restricts user data to contain only usernames, emails, and full names
CREATE VIEW UserInfo AS
(
    SELECT u.username, u.fullname, e.email
    FROM [User] u LEFT OUTER JOIN User_email e
    ON u.username = e.username
);

-- 2. View that shows all available listed items and their conditions
CREATE VIEW AvailableItems AS
(
    SELECT l.seller_username, l.description, l.quantity, l.list_date, c.condition_name
    FROM ListedItem l Inner JOIN Condition c
    ON l.condition_id = c.condition_id
    WHERE l.buyer_username IS NULL
);

-- 3. View that shows all sold listed items and their conditions
CREATE VIEW SoldItems AS
(
    SELECT l.seller_username, l.description, l.quantity, l.list_date, c.condition_name
    FROM ListedItem l Inner JOIN Condition c
    ON l.condition_id = c.condition_id
    WHERE l.buyer_username IS NOT NULL;
);