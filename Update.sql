select distinct * from Transactions
select distinct * from Accounts
select distinct * from Customers
------------------------------------------------------------------------

UPDATE Accounts
SET AccountCloseDate = '20251231'
WHERE AccountCloseDate IS NULL
  --AND AccountStatus = 'Closed'
  --AND AccountOpenDate <= '20251231';

update Customers
set PhoneNumber = '+91-9605467120'
where PhoneNumber is null

update Customers 
set PhoneNumber = '+91-' + PhoneNumber
where PhoneNumber not like '+91-%'

UPDATE Customers
SET PhoneNumber = REPLACE(PhoneNumber, '+91-+91 ', '+91-')
WHERE PhoneNumber LIKE '+91-+91%';

