-- Alter table to add new columns for time-based features
ALTER TABLE Orders
ADD COLUMN DayOfWeek INT,
ADD COLUMN DayOfMonth INT,
ADD COLUMN Month INT,
ADD COLUMN Quarter INT,
ADD COLUMN Year INT,
ADD COLUMN IsWeekend BIT,
ADD COLUMN Season VARCHAR(10),
ADD COLUMN SecondsSinceEpoch BIGINT,
ADD COLUMN FiscalYear INT,
ADD COLUMN DaysToChristmas INT;

-- Update table to set values for the new columns
UPDATE Orders
SET 
    DayOfWeek = EXTRACT(DOW FROM OrderDate),
    DayOfMonth = EXTRACT(DAY FROM OrderDate),
    Month = EXTRACT(MONTH FROM OrderDate),
    Quarter = EXTRACT(QUARTER FROM OrderDate),
    Year = EXTRACT(YEAR FROM OrderDate),
    IsWeekend = CASE WHEN EXTRACT(DOW FROM OrderDate) IN (0, 6) THEN 1 ELSE 0 END, -- Sunday=0, Saturday=6
    Season = CASE 
        WHEN EXTRACT(MONTH FROM OrderDate) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM OrderDate) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM OrderDate) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Autumn'
    END,
    SecondsSinceEpoch = EXTRACT(EPOCH FROM OrderDate),
    FiscalYear = CASE 
        WHEN EXTRACT(MONTH FROM OrderDate) >= 4 THEN EXTRACT(YEAR FROM OrderDate)
        ELSE EXTRACT(YEAR FROM OrderDate) - 1
    END,
    DaysToChristmas = DATE_PART('day', DATE '2022-12-25' - OrderDate); -- Assuming the current year is 2022