/* =============================================================
   APEX BANK - DATA INSERTION SCRIPT
   Database: Power_BI
   Tables: Customers, Accounts, Transactions
   ============================================================= */

USE Power_BI;
GO

/* -------------------------------------------------------------
   1. CUSTOMERS - 1,500 records
   ------------------------------------------------------------- */

CREATE TABLE #FirstNames (
    RowNum INT IDENTITY(1,1),
    Name NVARCHAR(50)
);

INSERT INTO #FirstNames (Name)
VALUES
('Aarav'),('Vivaan'),('Aditya'),('Vihaan'),('Arjun'),('Sai'),
('Reyansh'),('Ayaan'),('Ananya'),('Diya'),('Aadhya'),('Saanvi'),
('Myra'),('Anika'),('Navya'),('Prisha'),('Rahul'),('Rohit'),
('Priya'),('Sneha'),('Kavya'),('Meera'),('Neha'),('Pooja'),
('Vikram'),('Suresh'),('Anita'),('Deepak'),('Ramesh'),('Lakshmi');


CREATE TABLE #LastNames (
    RowNum INT IDENTITY(1,1),
    Name NVARCHAR(50)
);

INSERT INTO #LastNames (Name)
VALUES
('Sharma'),('Verma'),('Patel'),('Reddy'),('Nair'),('Iyer'),
('Kulkarni'),('Deshmukh'),('Chopra'),('Malhotra'),('Kapoor'),('Rao'),
('Menon'),('Pillai'),('Krishnan'),('Raman'),('Joshi'),('Gupta'),
('Singh'),('Mishra'),('Bose'),('Das'),('Chatterjee'),('Banerjee'),
('Reddy'),('Rao'),('Khan'),('Ali'),('Shaikh'),('Pawar');


CREATE TABLE #Occupations (
    RowNum INT IDENTITY(1,1),
    Name NVARCHAR(50)
);

INSERT INTO #Occupations (Name)
VALUES
('Software Engineer'),('Teacher'),('Doctor'),('Business Owner'),
('Accountant'),('Sales Manager'),('Government Employee'),('Consultant'),
('Driver'),('Retail Associate'),('Student'),('Homemaker');


DECLARE @i INT = 1,
        @r INT,
        @first NVARCHAR(50),
        @last NVARCHAR(50),
        @gender NVARCHAR(20),
        @dob DATE,
        @city NVARCHAR(50),
        @state NVARCHAR(50),
        @occupation NVARCHAR(50),
        @income NVARCHAR(20),
        @score INT,
        @scoreBand NVARCHAR(20),
        @since DATE,
        @email NVARCHAR(150),
        @phone NVARCHAR(25);

WHILE @i <= 1500
BEGIN
    /* Select first name */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 30 AS INT) + 1;
    SELECT @first = Name 
    FROM #FirstNames 
    WHERE RowNum = @r;

    /* Select last name */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 30 AS INT) + 1;
    SELECT @last = Name 
    FROM #LastNames 
    WHERE RowNum = @r;

    /* Gender with intentional inconsistencies */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 100 AS INT) + 1;

    IF @r <= 45
        SET @gender = 'Male';
    ELSE IF @r <= 90
        SET @gender = 'Female';
    ELSE IF @r <= 93
        SET @gender = 'M';
    ELSE IF @r <= 96
        SET @gender = 'female ';
    ELSE
        SET @gender = 'UNKNOWN';

    /* Date of birth with intentional issues */
    IF @i IN (37, 512, 1001)
        SET @dob = '2015-06-15';  -- Customers below 18
    ELSE IF @i IN (88, 777)
        SET @dob = '2030-01-01';  -- Future date of birth
    ELSE
        SET @dob = DATEADD(
            DAY,
            CAST(RAND(CHECKSUM(NEWID())) * 14600 AS INT),
            '1965-01-01'
        );

    /* City and state */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 5 AS INT) + 1;

    SELECT
        @city = CASE @r
            WHEN 1 THEN 'Mumbai'
            WHEN 2 THEN 'Delhi'
            WHEN 3 THEN 'Bengaluru'
            WHEN 4 THEN 'Chennai'
            ELSE 'Hyderabad'
        END,
        @state = CASE @r
            WHEN 1 THEN 'Maharashtra'
            WHEN 2 THEN 'Delhi'
            WHEN 3 THEN 'Karnataka'
            WHEN 4 THEN 'Tamil Nadu'
            ELSE 'Telangana'
        END;

    /* Inconsistent city spelling and capitalization */
    IF @i % 40 = 0
        SET @city = 'mumbai ';

    IF @i % 55 = 0
        SET @city = 'MUMBAI';

    IF @i % 70 = 0
        SET @city = 'Bengaluru ';

    IF @i % 85 = 0
        SET @city = 'chennai';

    /* Occupation */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 12 AS INT) + 1;
    SELECT @occupation = Name 
    FROM #Occupations 
    WHERE RowNum = @r;

    /* Income band */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 4 AS INT) + 1;

    SET @income = CASE @r
        WHEN 1 THEN 'Below 3L'
        WHEN 2 THEN '3L-6L'
        WHEN 3 THEN '6L-12L'
        ELSE 'Above 12L'
    END;

    /* Credit score */
    SET @score = 550 + CAST(RAND(CHECKSUM(NEWID())) * 350 AS INT);

    SET @scoreBand = CASE
        WHEN @score < 650 THEN 'Poor'
        WHEN @score < 720 THEN 'Fair'
        WHEN @score < 780 THEN 'Good'
        ELSE 'Excellent'
    END;

    /* Customer since date */
    SET @since = DATEADD(
        DAY,
        CAST(RAND(CHECKSUM(NEWID())) * 4380 AS INT),
        '2012-01-01'
    );

    /* Email with intentional invalid values */
    SET @email = 'customer' + CAST(@i AS NVARCHAR(10)) + '@example.com';

    IF @i % 25 = 0
        SET @email = 'customer' + CAST(@i AS NVARCHAR(10)) + '@example';

    /* Phone number with missing and inconsistent formats */
    IF @i % 30 = 0
        SET @phone = NULL;
    ELSE IF @i % 7 = 0
        SET @phone = '+91 98' + RIGHT('00000000' + CAST(@i * 137 AS NVARCHAR(10)), 8);
    ELSE IF @i % 11 = 0
        SET @phone = '98' + RIGHT('00000000' + CAST(@i * 137 AS NVARCHAR(10)), 8);
    ELSE
        SET @phone = '+91-98' + RIGHT('00000000' + CAST(@i * 137 AS NVARCHAR(10)), 8);

    /* Insert customer */
    INSERT INTO Customers
        (
            CustomerID,
            CustomerName,
            Gender,
            DateOfBirth,
            Age,
            City,
            State,
            Occupation,
            IncomeBand,
            CreditScore,
            CreditScoreBand,
            CustomerSinceDate,
            Email,
            PhoneNumber
        )
    VALUES
        (
            @i,
            @first + ' ' + @last,
            @gender,
            @dob,
            DATEDIFF(YEAR, @dob, GETDATE()),
            @city,
            @state,
            @occupation,
            @income,
            @score,
            @scoreBand,
            @since,
            @email,
            @phone
        );

    SET @i += 1;
END;

/* Duplicate customer names */
UPDATE Customers
SET CustomerName = 'Rahul Sharma'
WHERE CustomerID IN (101, 202, 303, 404, 505, 606, 707, 808, 909, 1010);
GO


/* -------------------------------------------------------------
   2. ACCOUNTS - 1,000 records
   ------------------------------------------------------------- */

DECLARE @a INT = 1,
        @cust INT,
        @open DATE,
        @close DATE,
        @status NVARCHAR(20),
        @balance DECIMAL(14,2),
        @accountType NVARCHAR(30),
        @r INT;

WHILE @a <= 1000
BEGIN
    /* Customer ID */
    SET @cust = CAST(RAND(CHECKSUM(NEWID())) * 1500 AS INT) + 1;

    /* Account open date */
    SET @open = DATEADD(
        DAY,
        CAST(RAND(CHECKSUM(NEWID())) * 2555 AS INT),
        '2018-01-01'
    );

    /* Current balance */
    SET @balance = 1000 + CAST(RAND(CHECKSUM(NEWID())) * 499000 AS DECIMAL(14,2));

    /* Account status */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 100 AS INT) + 1;

    IF @r <= 85
    BEGIN
        SET @status = 'Active';
        SET @close = NULL;
    END
    ELSE IF @r <= 95
    BEGIN
        SET @status = 'Closed';

        SET @close = DATEADD(
            DAY,
            CAST(RAND(CHECKSUM(NEWID())) * 365 AS INT),
            '2025-01-01'
        );
    END
    ELSE
    BEGIN
        SET @status = 'Dormant';
        SET @close = NULL;
    END

    /* Invalid close date before open date */
    IF @a IN (111, 222, 333)
        SET @close = DATEADD(DAY, -30, @open);

    /* Account type */
    SET @accountType = CASE
        WHEN @a % 4 = 1 THEN 'Savings Account'
        WHEN @a % 4 = 2 THEN 'Current Account'
        WHEN @a % 4 = 3 THEN 'Salary Account'
        ELSE 'Fixed Deposit Account'
    END;

    /* Insert account */
    INSERT INTO Accounts
        (
            AccountID,
            CustomerID,
            AccountOpenDate,
            AccountCloseDate,
            AccountStatus,
            CurrentBalance,
            AccountType
        )
    VALUES
        (
            @a,
            @cust,
            @open,
            @close,
            @status,
            @balance,
            @accountType
        );

    SET @a += 1;
END;
GO


/* -------------------------------------------------------------
   3. TRANSACTIONS - 8,000 records
   ------------------------------------------------------------- */

DECLARE @t INT = 1,
        @acct INT,
        @cust INT,
        @txnDate DATE,
        @txnType NVARCHAR(30),
        @channel NVARCHAR(30),
        @amount DECIMAL(14,2),
        @balance DECIMAL(14,2),
        @status NVARCHAR(20),
        @currency NVARCHAR(10),
        @r INT;

WHILE @t <= 8000
BEGIN
    /* Select an existing account */
    SET @acct = CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT) + 1;

    SELECT @cust = CustomerID
    FROM Accounts
    WHERE AccountID = @acct;

    /* Transaction date between 2023 and 2025 */
    SET @txnDate = DATEADD(
        DAY,
        CAST(RAND(CHECKSUM(NEWID())) * 1095 AS INT),
        '2023-01-01'
    );

    /* Transaction type */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 6 AS INT) + 1;

    SET @txnType = CASE @r
        WHEN 1 THEN 'Deposit'
        WHEN 2 THEN 'Withdrawal'
        WHEN 3 THEN 'Transfer'
        WHEN 4 THEN 'Bill Payment'
        WHEN 5 THEN 'Card Purchase'
        ELSE 'Fee Charge'
    END;

    /* Channel */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 5 AS INT) + 1;

    SET @channel = CASE @r
        WHEN 1 THEN 'ATM'
        WHEN 2 THEN 'Branch'
        WHEN 3 THEN 'Mobile App'
        WHEN 4 THEN 'Internet Banking'
        ELSE 'UPI'
    END;

    /* Base balance */
    SET @balance = 10000 + CAST(RAND(CHECKSUM(NEWID())) * 400000 AS DECIMAL(14,2));

    /* Transaction amount based on type */
    SET @amount =
        CASE @txnType
            WHEN 'Deposit'
                THEN 500 + CAST(RAND(CHECKSUM(NEWID())) * 50000 AS DECIMAL(14,2))

            WHEN 'Withdrawal'
                THEN -1 * (
                    500 + CAST(
                        RAND(CHECKSUM(NEWID())) * (@balance - 2000) AS DECIMAL(14,2)
                    )
                )

            WHEN 'Transfer'
                THEN 1000 + CAST(RAND(CHECKSUM(NEWID())) * 100000 AS DECIMAL(14,2))

            WHEN 'Bill Payment'
                THEN 200 + CAST(RAND(CHECKSUM(NEWID())) * 20000 AS DECIMAL(14,2))

            WHEN 'Card Purchase'
                THEN 100 + CAST(RAND(CHECKSUM(NEWID())) * 30000 AS DECIMAL(14,2))

            ELSE 100 + CAST(RAND(CHECKSUM(NEWID())) * 2000 AS DECIMAL(14,2))
        END;

    /* Transaction status */
    SET @r = CAST(RAND(CHECKSUM(NEWID())) * 100 AS INT) + 1;

    SET @status =
        CASE
            WHEN @r <= 92 THEN 'Success'
            WHEN @r <= 97 THEN 'Failed'
            ELSE 'Pending'
        END;

    /* Currency */
    SET @currency = 'INR';

    /* Inconsistent currency values */
    IF @t % 500 = 0
        SET @currency = 'Rs.';

    IF @t % 750 = 0
        SET @currency = N'₹';

    /* Insert transaction */
    INSERT INTO Transactions
        (
            TransactionID,
            CustomerID,
            AccountID,
            TransactionDate,
            TransactionType,
            Channel,
            Amount,
            BalanceAfterTransaction,
            TransactionStatus,
            Currency
        )
    VALUES
        (
            @t,
            @cust,
            @acct,
            @txnDate,
            @txnType,
            @channel,
            @amount,
            @balance + @amount,
            @status,
            @currency
        );

    SET @t += 1;
END;

/* Leading and trailing spaces in Channel */
UPDATE Transactions
SET Channel = ' ' + Channel + ' '
WHERE TransactionRowID % 97 = 0;

/* Inconsistent capitalization in TransactionType */
UPDATE Transactions
SET TransactionType = 'DEPOSIT'
WHERE TransactionRowID % 150 = 0;

UPDATE Transactions
SET TransactionType = 'withdrawal'
WHERE TransactionRowID % 175 = 0;

/* Invalid zero deposit amount */
UPDATE Transactions
SET Amount = 0
WHERE TransactionRowID % 400 = 0
  AND TransactionType = 'Deposit';

/* Invalid negative deposit amount */
UPDATE Transactions
SET Amount = -2500
WHERE TransactionRowID % 650 = 0
  AND TransactionType = 'Deposit';

/* Extreme transaction outliers */
UPDATE Transactions
SET Amount = 1000000 + (TransactionRowID % 10) * 150000
WHERE TransactionRowID IN 
    (100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000);

/* Future transaction dates */
UPDATE Transactions
SET TransactionDate = DATEADD(
    DAY,
    TransactionRowID % 300,
    '2026-01-01'
)
WHERE TransactionRowID % 500 = 0;

/* Duplicate TransactionID values */
INSERT INTO Transactions
    (
        TransactionID,
        CustomerID,
        AccountID,
        TransactionDate,
        TransactionType,
        Channel,
        Amount,
        BalanceAfterTransaction,
        TransactionStatus,
        Currency
    )
SELECT TOP (20)
    TransactionID,
    CustomerID,
    AccountID,
    TransactionDate,
    TransactionType,
    Channel,
    Amount,
    BalanceAfterTransaction,
    TransactionStatus,
    Currency
FROM Transactions
ORDER BY NEWID();
GO


/* -------------------------------------------------------------
   VALIDATE ROW COUNTS
   ------------------------------------------------------------- */

SELECT 
    'Customers' AS TableName,
    COUNT(*) AS Row_Count
FROM Customers

UNION ALL

SELECT 
    'Accounts' AS TableName,
    COUNT(*) AS Row_Count
FROM Accounts

UNION ALL

SELECT 
    'Transactions' AS TableName,
    COUNT(*) AS Row_Count
FROM Transactions;

