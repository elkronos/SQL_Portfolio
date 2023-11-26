-- Replace `YourTable` and `YourPhoneColumn`
UPDATE YourTable
SET YourPhoneColumn = REGEXP_REPLACE(YourPhoneColumn, '[^0-9]', '')
WHERE YourPhoneColumn REGEXP '[^0-9]';