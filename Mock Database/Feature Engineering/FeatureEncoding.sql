-- Example: One-Hot Encoding for Product Categories
-- First, identify unique categories
SELECT DISTINCT Category FROM Products;

-- Then, add a column for each category
ALTER TABLE Products
ADD Category_Electronics BIT,
    Category_Clothing BIT,
    -- Add more categories as needed
;

-- Update the new columns to 1 or 0 based on the category
UPDATE Products
SET Category_Electronics = CASE WHEN Category = 'Electronics' THEN 1 ELSE 0 END,
    Category_Clothing = CASE WHEN Category = 'Clothing' THEN 1 ELSE 0 END
    -- Continue for other categories
;