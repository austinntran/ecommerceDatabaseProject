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

-- 2 subqueries

-- 4 anything that uses something above