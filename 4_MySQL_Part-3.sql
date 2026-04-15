-- Transactions-: Series of Operations

-- By default, MySQL operates in AUTOCOMMIT mode(1). This means that every single SQL statement execution treated as Standalone Transaction. 
-- To disable set to 0 and enable set to 1
SELECT @@AUTOCOMMIT;
SET AUTOCOMMIT = 0;

CREATE DATABASE IF NOT EXISTS prime;
USE prime;
CREATE TABLE accounts (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(30), balance DECIMAL(10,2));
INSERT INTO accounts (name,balance) VALUES ('Adam',500.00),('Bob',300.00),('Charlie',1000.00);
SELECT * FROM accounts;

-- Run the Transaction as whole as we disable Autocommit. At last we run COMMIT which permanently saves all changes.
START TRANSACTION;
UPDATE accounts SET balance = balance-50 WHERE id=1;
UPDATE accounts SET balance = balance+50 WHERE id=2;
COMMIT;

-- ROLLBACK is used to undo changes made during a transaction and restore the data to its previous state.
-- ROLLBACK only undo the uncommited data but not commited data. If use COMMIT in middle of transaction it will save the above changes.
START TRANSACTION;
UPDATE accounts SET balance = balance-100 WHERE id=1;
UPDATE accounts SET balance = balancw+100 WHERE id=3;
-- Error occured
ROLLBACK;

-- SAVEPOINT is used to mark a point within a transaction so you can roll back part of the transaction without undoing everything.
START TRANSACTION;
UPDATE accounts SET balance = balance+1000 WHERE id=2;
SAVEPOINT after_wallet_topup;
UPDATE accounts SET balance = balance +10 WHERE id=2;
-- Error occured.
ROLLBACK TO after_wallet_topup;
COMMIT;

-- --------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE account (account_id INT PRIMARY KEY, name VARCHAR(30), balance DECIMAL(10,2), branch VARCHAR(50));
INSERT INTO account VALUES (1,'Adam',500.00,'Mumbai'), (2,'Bob',300.00,'Delhi'), (3,'Charlie',700.00,'Bangalore'), (4,'David',1000.00,'Noida');
SELECT * FROM account;

-- INDEX in SQL
-- Indexes are special database objects that make 'Data Retrival Faster'
-- Primary Key is the default Index
-- Index fasts the Read(SELECT) queries but it slowdown the Write(UPDATE,CHANGE,DELETE etc.) queries.
CREATE INDEX idx_branch ON account(branch);
SHOW INDEX FROM account;
SELECT * FROM account WHERE branch = 'Mumbai';
-- Composite Index (Multiple Index)
CREATE INDEX idx_2 ON account(branch,name);
-- Delete an Index
DROP INDEX idx_branch ON account;
DROP INDEX idx_2 ON account;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Stored Procedures (= Python Functions)
-- Predefined set of SQL statements that we can save in the database & execute whenever we needed.
-- MySQL normally ends commands with ;. Stored Procedures contain many ;, so we temporarily change delimiter.
DELIMITER $$
CREATE PROCEDURE check_balance(IN ac_id INT)
BEGIN
     SELECT balance FROM account WHERE account_id = ac_id;
END $$
DELIMITER ;
CALL check_balance(1);
CALL check_balance(3);
DROP PROCEDURE IF EXISTS check_balance;

-- We can return a value using an output parameter.
-- To define user defined variable, we have to declare it with '@' prefix. We don't have to declare a data type. MySQL assigns the type based on the value we give it.
DELIMITER %%
CREATE PROCEDURE chk_balance (IN ac_id INT, OUT bal DECIMAL(10,2))
BEGIN
     SELECT balance INTO bal 
     FROM account WHERE account_id = ac_id;
END %%
DELIMITER ;
CALL chk_balance(1,@balance);
SELECT @balance;
-- This Procedure fetches the balance from the account table. It stores that value into OUT variable'bal'.So this procedure retuens balance for a given account id.









