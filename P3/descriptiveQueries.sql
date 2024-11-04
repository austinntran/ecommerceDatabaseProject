GO
USE PROJECT

-- 2 aggregate
-- Select the number of items that each user is selling
SELECT seller_username, COUNT(item_id)
FROM ListedItem
GROUP BY seller_username;

-- Select the price of the most expensive item each seller is selling 
SELECT seller_username, MAX(price)
FROM ListedItem
GROUP BY seller_username;

-- 2 joins
-- Select users names with their emails
SELECT fullname, email 
FROM (
    [User] INNER JOIN User_email ON User.username = User_email.username
);

-- Select users along with their ratings
SELECT fullname, rating
FROM (
    [User] INNER JOIN User_Rates ON [User].username = User_Rates.ratee
);

-- 2 subqueries
-- Get all payment methods for users who are buyers
SELECT pm.method_name
FROM PaymentMethod pm
WHERE pm.payment_id IN (
    SELECT p.payment_id
    FROM User_PaymentMethods p
    JOIN [User] u ON p.username = u.username
    WHERE u.isbuyer = 1
);
-- Find sellers who have more than one email registered
SELECT u.username, u.fullname
FROM [User] u
WHERE u.isseller = 1 AND 
      (SELECT COUNT(*) FROM User_email e WHERE e.username = u.username) > 1;

-- 4 anything that uses something above
-- Get average user rating, listed by their fullname
SELECT fullname, AVG(rating) AS average_rating 
FROM (
    [User] INNER JOIN User_Rates ON User.username = rating.ratee
) GROUP BY User.fullname;

-- Aggregate: Select the the sum of items each seller is selling
SELECT seller_username, MIN(price)
FROM ListedItem
GROUP BY seller_username

-- Join: Select listedItems along with their condition
SELECT item_id, [name], condition_name
FROM (
    ListedItem INNER JOIN Condition ON ListedItem.condition_id = Condition.condition_id
);

-- Subqueries: Select from the seller which have 
SELECT u.username
FROM [User] u
WHERE u.isseller = 1 AND u.username IN (
    SELECT l.seller_username
    FROM (
        ListedItem l INNER JOIN Condition c ON l.condition_id = c.condition_id
    )
    WHERE condition_name = 'New'
);

