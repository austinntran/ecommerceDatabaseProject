GO
USE PROJECT

-- 1. Selects all listed items available (not already bought) in a certain category
CREATE FUNCTION GetAvailableItems
(
    @category varchar(50)
)
RETURNS TABLE
AS 
RETURN (
    SELECT LI.name, LC.item_id
    FROM ListedItem_Category LC
    JOIN Category C ON LC.category_id = C.category_id 
    JOIN ListedItem LI ON LC.item_id = LI.item_id
    WHERE @category = C.category_name AND LI.purchase_date IS NULL
);

-- Checking Function
SELECT * FROM GetAvailableItems('Technology');

-- 2. Select all items listed by a username

CREATE FUNCTION GetUserItems 
(
    @username varchar(100)
) 
RETURNS TABLE
AS 
RETURN (
    SELECT *
    FROM ListedItem LI
    WHERE @username = LI.seller_username 
);

-- Checking Function
SELECT * FROM GetUserItems('amandabrown77');

-- 3. Select all items listed after a certain date cost at most a specified price
CREATE FUNCTION GetLatestCheapItems
(
    @OldestDate date,
    @MaxPrice int
)
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM ListedItem
    WHERE list_date >= @OldestDate AND price <= @MaxPrice
);
