# SQL_Portfolio
Examples of SQL scripts. Includes scripts designed for creating a data base, common table expressions, analyzing data, ETL, and admin.

## Admin
Scripts which illustrate basic admin commands using SQL Server.
- `Backup` -  Perform a full backup of the database.
- `Deadlock` - Retrieves all the current lock information for database objects from the system dynamic management view.
- `MonitorPerformance` - Lists SQL Server queries that have been running for longer than 5 minutes, showing details like the query text, session ID, status, command type, CPU time, and total elapsed time, ordered by the longest running queries first.
- `Restore` - Restores database from a backup file.

## Data Cleaning
Scripts which illustrate how to clean data using SQL.
- `ConvertCase` - Format each entry so that the first letter is uppercase and all subsequent letters are lowercase.
- `CorrectingNulls` - Replaces any NULL values in that column with a 'Default Value'.
- `DeleteOprhans` - Deletes rows from a child table (ChildTable) where values in a specified column (ChildColumn) do not have corresponding entries in a column (ParentColumn) of a parent table (ParentTable).
- `RemoveDuplicates` - Removes duplicate rows from a specified table based on a specific column, keeping the row with the higher ID value and deleting the others.
- `StandardizingDates` - Updates a date column in a specified table by converting date strings from a DD/MM/YYYY format to a standard date format, applying this change only to those entries that match the DD/MM/YYYY pattern.
- `StandardizingPhoneNumbers` - Updates a phone number column in a specified table by removing any non-numeric characters from the phone numbers, applying this change only to entries that contain non-numeric characters.
- `TrimeWhiteSpace` - Removes leading and trailing white spaces from specified columns applying this operation only to entries in those columns where leading or trailing spaces are detected.
- `UpdateValues` - Replaces a user specified value with a different user specified value.

## Mock Database
Scripts which illustrate the set-up, use, and maintence for a fake (mock) database. These scripts are organized into the following directories.

- `Analyze Database` - Scripts that demonstrate how to analyze the mock database. Calculate outcomes such as sales trends over time, sales proportion by product category, average purchase per user, and more.
- `CTEs` - Common table expresion scripts; Illustrating how to delete, join, query recent orders, recursive joining, updating, analyzing records, and more.
- `Create Database` - Scripts used to construct a mock database (see schema for database below).
- `ETL` - How to stage, create, ad insert a product sales table for reproducible reporting.
- `Feature Engineering` - How to econde, normalize, and extract features from tables for establishing pipelines.
- `Roles` - Create and manage role and user role information.
- `Security` - Scripts designed with security in mind. Illustrates encryption, validation, authentication, etc.
- `Triggers` - Demonstrating how to automatically update tables based on event occurences. Includes scripts such as audit logging, email change notifications, stock management, etc.


A schema of the mock database is listed below.

### Users Table
- `UserID` (Primary Key, Auto Increment)
- `Username` (Varchar(50), Not Null)
- `Email` (Varchar(100), Not Null, Unique)
- `PasswordHash` (Varchar(255), Not Null)
- `DateJoined` (Datetime, Not Null)
- `LastLogin` (Datetime)

**Relationships**:
- Has multiple `Orders` via `UserID`.


### OrderDetails Table
- `OrderDetailID` (Primary Key, Auto Increment)
- `OrderID` (Foreign Key referencing `Orders.OrderID`)
- `ProductID` (Foreign Key referencing `Products.ProductID`)
- `Quantity` (Integer, Not Null, Check Constraint: Quantity > 0)
- `PriceAtTimeOfOrder` (Decimal(10, 2), Not Null)

**Relationships**:
- Belongs to an `Order` via `OrderID`.
- References a `Product` via `ProductID`.


### Orders Table
- `OrderID` (Primary Key, Auto Increment)
- `UserID` (Foreign Key referencing `Users.UserID`)
- `OrderDate` (Datetime, Not Null)
- `TotalAmount` (Decimal(10, 2), Not Null, Check Constraint: TotalAmount >= 0)
- `Status` (Varchar(50), Not Null)

**Relationships**:
- Belongs to a `User` via `UserID`.
- Contains multiple `OrderDetails` via `OrderID`.


### Products Table
- `ProductID` (Primary Key, Auto Increment)
- `ProductName` (Varchar(100), Not Null)
- `Description` (Text)
- `Price` (Decimal(10, 2), Not Null, Check Constraint: Price >= 0)
- `Stock` (Integer, Not Null, Check Constraint: Stock >= 0)
- `DateAdded` (Datetime, Not Null)

**Relationships**: Can be related to `OrderDetails` as needed.
