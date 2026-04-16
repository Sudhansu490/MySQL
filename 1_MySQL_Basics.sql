CREATE DATABASE IF NOT EXISTS Instagram;
SHOW DATABASES;
USE Instagram;
SHOW TABLES;
CREATE TABLE User(
id INT,
age INT,
name VARCHAR(30) NOT NULL,
email VARCHAR(50) UNIQUE,
followers INT DEFAULT 0,
following INT,
CONSTRAINT age_check CHECK (age>13),
PRIMARY KEY (id)
);
INSERT INTO User (id,age,name,email,followers,following) VALUES (1,14,"Adam","adam@yahoo.in",123,145),(2,15,"Bob","bob@gmail.com",200,200),
(3,16,"Cherry","cherry@email.com",300,306),(4,17,"Don","don@gmail.com",200,105),(5,14,"Eve","eve@yahoo.in",400,145),(6,16,"Farah","farah@gmail.com",10000,1000);
SELECT id,age,name FROM user;
SELECT DISTINCT followers FROM user;
SELECT * FROM user;

-- NOT NULL,UNIQUE,DEFAULT,CHECK,PRIMARY KEY -> CONSTRAINTS
-- CONSTRAINT -> Rules Applied to a column.
-- CHECK -> Ensures that all values in a column satisfy a specific condition.
-- PRIMARY KEY -> Makes a column UNIQUE & NOT NULL but a table have only 1 PRIMARY KEY
-- FOREIGN KEY -> Creates link between 2 tables. it's a column of a table that points to PRIMARY KEY of another table to keep the data connected.
-- DISTINCT -> Print only UNIQUE values

CREATE TABLE Posts(
id INT PRIMARY KEY,
content VARCHAR(50),
user_id INT,
FOREIGN KEY (user_id) REFERENCES User(id)
);
INSERT INTO Posts(id,content,user_id) VALUES
(101,"Hello World",3),(102,"Bye Bye",1),(103,"Prime Batch",3);
SELECT * FROM Posts;

-- AS -> Rename columns/expressions in query results.
SELECT name AS Full_Name FROM user;

-- WHERE CLAUSE -> To define some Conditions
SELECT name,followers FROM user WHERE (followers >= 200);
SELECT * FROM user WHERE (following >= 200);
SELECT * FROM user WHERE (age>15) AND (followers>200);
SELECT name,age FROM user WHERE age BETWEEN 13 AND 15;
SELECT name,email FROM user WHERE email IN ("bob@gmail.com","abc@gmail.com","don@gmail.com");
SELECT name,age FROM user WHERE age NOT IN (14,16);

-- IS NULL -> check FOR NULL values in the WHERE clause
SELECT * FROM user WHERE email IS NULL;

-- LIKE -> Like operator used in a WHERE clause to search for a specified pattern in a column.
        -- (%) represents 0,1 or multiple characters   (_) represents one,single character
SELECT * FROM user WHERE name LIKE 'A%M';  -- Name starts with A and ends with M
SELECT * FROM user WHERE name LIKE '%O%';  -- Name contain O in any position
SELECT * FROM user WHERE name LIKE 'D__%';  -- Name starts with D and atleast 3 characters in length

-- LIMIT CLAUSE -> Set an Uppe Limit on number of (Tuples) Rows to be returned.
SELECT name,age FROM user WHERE (age>13) LIMIT 2;

-- ORDER BY CLAUSE -> To sort in Ascending (ASC) or Descending (DESC) order. By default ASC order.
SELECT name,age,followers FROM user ORDER BY followerS ASC;
SELECT * FROM user ORDER BY age DESC;

-- AGGREGATE FUNCTIONS -> It perform a Calculation on a set of values & return a single value.
SELECT MAX(followers) FROM user;
SELECT MIN(age) FROM user;
SELECT COUNT(age) FROM user WHERE (age>15);
SELECT AVG(followers) FROM user;
SELECT SUM(following) FROM user;
-- COUNT(*)->Count all rows,includes rows with NULL values   COUNT(column_name)->Counts rows where column is NOT NULL

-- GROUP BY CLAUSE ->  Uused to Group Rows from a table based on 1 or more Columns. Generally we use GROUP BY with some AGGREGATE Function.
					-- If we SELECT any Parameter and don't AGGREGATE it, we must GROUP BY it.
SELECT age,COUNT(id) FROM user GROUP BY age;
SELECT age,MAX(followers) FROM user GROUP BY age;

-- HAVING CLAUSE -> Similar to WHERE i.e. applies some Condition on Rows. But it is used when we want to apply any CONDITION AFTER GROUPING.
                 -- WHERE is for the Table, HAVING is for a Group. Grouping is necessary for HAVING.
SELECT age,MAX(followers) FROM user GROUP BY age HAVING MAX(followers)>200;

-- GENERAL ORDER -> SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY
SELECT age, MAX(followers) FROM user GROUP BY age HAVING MAX(followers)>200 ORDER BY age DESC;

-- UPDATE -> to Update existing rows. For first time update in MySQl we have to run below command.
SET SQL_SAFE_UPDATES = 0;
UPDATE user SET following=350 WHERE age=16;
SELECT * FROM user;

-- DELETE -> to delete existing rows. If we don't write any condition it delete all rows.
INSERT INTO Posts(id,content,user_id) VALUES(104,"Delete Row",4);
DELETE FROM Posts WHERE id=104;
SELECT * FROM Posts;

-- ALTER -> to change the Schema (Modify Columns, Modify Table, Manage Constraints)
         -- ADD Column, DROP Column, RENAME Table, CHANGE Column(Rename), MODIFY Column(Modify DataType/Constraint)
CREATE TABLE creator (id INT PRIMARY KEY, age INT, name VARCHAR(30),CONSTRAINT age_chk CHECK(age>13));
INSERT INTO creator(id,age,name) VALUES (1,25,"Alice"),(2,27,"Belly"),(3,29,"Cherry");
SELECT * FROM creator;
ALTER TABLE creator ADD COLUMN city VARCHAR(25) DEFAULT "delhi";
ALTER TABLE creator DROP COLUMN city;
ALTER TABLE creator RENAME TO Insta_Creator;
SELECT * FROM Insta_Creator;
ALTER TABLE Insta_Creator RENAME TO Creator;
ALTER TABLE creator CHANGE COLUMN name user_name VARCHAR(25) UNIQUE;
ALTER TABLE creator MODIFY age INT CHECK (age>=18);  -- Minimum age changes to 18

-- TRUNCATE -> used to delete table's data
-- DROP -> used to delete entire table (data+structure)
CREATE TABLE likes (user_id INT NOT NULL, post_id INT NOT NULL, liked_at TIMESTAMP, reaction VARCHAR(20));
INSERT INTO likes(user_id,post_id,liked_at,reaction) VALUES (1,101,'2026-02-20 10:00:00','sad'),(2,102,'2026-03-12','fire'),(3,103,'2024-04-15 08:35:50','laugh');
TRUNCATE TABLE likes;
SELECT * FROM likes;
DROP TABLE likes;











