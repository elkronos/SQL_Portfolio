-- Replace `YourTable`, `YourDateColumn`, and date formats as needed
UPDATE YourTable
SET YourDateColumn = STR_TO_DATE(YourDateColumn, '%d/%m/%Y')
WHERE YourDateColumn REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$';