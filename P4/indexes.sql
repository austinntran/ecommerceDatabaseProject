-- Allows users to search the table based on an items listed date.
CREATE NONCLUSTERED INDEX idx_listed_date ON ListedItem(listed_date)

-- Allows users to search the table based on condition of an item.
CREATE NONCLUSTERED INDEX idx_condition_id ON ListedItem(condition_id)

-- Allows users to search the table with respect to their price.
CREATE NONCLUSTERED INDEX idx_price ON ListedItem(price)
