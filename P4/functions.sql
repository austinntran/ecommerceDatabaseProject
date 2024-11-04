-- 1. Selects all listed items available (not already bought) in a certain category

-- 2. Select all items listed by a user (identified by their email)

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
