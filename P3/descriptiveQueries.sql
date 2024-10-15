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
    User INNER JOIN User_email ON User.username = User_email.username
);

-- Select users along with their ratings
SELECT fullname, rating
FROM (
    User INNER JOIN User_Rates ON User.username = rating.ratee
);

-- 2 subqueries


-- 4 anything that uses something above
-- Get average user rating, listed by their fullname
SELECT fullname, AVG(rating) AS average_rating 
FROM (
    USER INNER JOIN User_Rates ON User.username = rating.ratee
) GROUP BY User.fullname;