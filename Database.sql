Create database Power_BI
use Power_BI

-----------------------------------------

/* -------------------------------------------------------------
   1. CUSTOMERS
   One row per customer.
   Intentional issues:
   - Duplicate customer names
   - Inconsistent gender values
   - Missing phone numbers
   - Invalid emails
   - Inconsistent city spelling/capitalization
   - Customers below age 18
   - Future dates of birth
   ------------------------------------------------------------- */
CREATE TABLE Customers (
    CustomerID        INT           NOT NULL PRIMARY KEY,
    CustomerName      NVARCHAR(100) NULL,
    Gender            NVARCHAR(20)  NULL,
    DateOfBirth       DATE          NULL,
    Age               INT           NULL,
    City              NVARCHAR(50)  NULL,
    State             NVARCHAR(50)  NULL,
    Occupation        NVARCHAR(50)  NULL,
    IncomeBand        NVARCHAR(20)  NULL,
    CreditScore       INT           NULL,
    CreditScoreBand   NVARCHAR(20)  NULL,
    CustomerSinceDate DATE          NULL,
    Email             NVARCHAR(150) NULL,
    PhoneNumber       NVARCHAR(25)  NULL
);


/* -------------------------------------------------------------
   2. ACCOUNTS
   One row per bank account.
   Intentional issue:
   - A few AccountCloseDate values earlier than AccountOpenDate
   ------------------------------------------------------------- */
CREATE TABLE Accounts (
    AccountID        INT           NOT NULL PRIMARY KEY,
    CustomerID       INT           NOT NULL,
    AccountOpenDate  DATE          NOT NULL,
    AccountCloseDate DATE          NULL,
    AccountStatus    NVARCHAR(20)  NOT NULL,
    CurrentBalance   DECIMAL(14,2) NOT NULL,
    AccountType      NVARCHAR(30)  NOT NULL,

);


/* -------------------------------------------------------------
   3. TRANSACTIONS
   One row per transaction event.
   TransactionRowID is the technical primary key.
   TransactionID is the business key and intentionally contains
   duplicate values for Power Query deduplication practice.
   Intentional issues:
   - Duplicate TransactionID values
   - Leading/trailing spaces
   - Inconsistent capitalization
   - Invalid zero/negative deposit amounts
   - Extreme transaction outliers
   - Future transaction dates
   - Inconsistent currency values
   ------------------------------------------------------------- */
CREATE TABLE Transactions (
    TransactionRowID        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TransactionID           INT               NOT NULL,
    CustomerID              INT               NOT NULL,
    AccountID               INT               NOT NULL,
    TransactionDate         DATE              NOT NULL,
    TransactionType         NVARCHAR(30)      NULL,
    Channel                 NVARCHAR(30)      NULL,
    Amount                  DECIMAL(14,2)     NULL,
    BalanceAfterTransaction DECIMAL(14,2)     NULL,
    TransactionStatus       NVARCHAR(20)      NULL,
    Currency                NVARCHAR(10)      NULL,


);

