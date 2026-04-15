-- Create a Database college.
CREATE DATABASE IF NOT EXISTS college;
USE college;

-- Q.1 -> Create a table(id,name,subject,salary). Insert 4 values.
CREATE TABLE teacher (id INT PRIMARY KEY, name VARCHAR(30), subject VARCHAR(25), salary INT);
INSERT INTO teacher(id,name,subject,salary) VALUES (23,'ajay','math',50000),(47,'bharat','english',60000),(18,'chetan','chemistry',45000),(9,'divya','physics',75000);
SELECT * FROM teacher;

-- i. Select teachers whose salary is more than 55K.
SELECT * FROM teacher WHERE salary>55000;

-- ii. Rename the salary column of teacher table to ctc.
ALTER TABLE teacher CHANGE COLUMN salary ctc INT;

-- iii. Update ctc of all teachers by giving them an increment of 25%.
SET SQL_SAFE_UPDATES = 0;
UPDATE teacher SET ctc = ctc + ctc*0.25;

-- iv. Add a new column for teachers called city. The default city should be 'Gurgaon'.
ALTER TABLE teacher ADD COLUMN city VARCHAR(20) DEFAULT 'Gurgaon';

-- v. Delete the ctc column for teacher table.
ALTER TABLE teacher DROP COLUMN ctc;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q.2 -> Create a table to store student info (roll_no,name,city,marks). Insert 4 values.
CREATE TABLE student(roll_no INT PRIMARY KEY, name VARCHAR(30), city VARCHAR(25), marks INT);
INSERT INTO student(roll_no,name,city,marks) VALUES (110,'Adam','Delhi',76),(108,'Bob','Mumbai',65),(124,'Casey','Pune',94),(112,'Duke','Pune',80);
SELECT * FROM student;

-- i. Select all students who scored 75+
SELECT * FROM student WHERE marks>75;

-- ii. Finds names of all cities where students are from.
SELECT DISTINCT city FROM student;
SELECT city FROM student GROUP BY city;

-- iii. Find the maximum marks of students from each city.
SELECT city,MAX(marks) FROM student GROUP BY city;

-- iv. Find the average marks of the class.
SELECT AVG(marks) FROM student;

-- v. Add a new column grade, assign grade such that: marks>80,grade=O     marks 70-80,grade=A     marks 60-70,grade=B
ALTER TABLE student ADD COLUMN grade VARCHAR(5);
SET SQL_SAFE_UPDATES = 0;
UPDATE student SET grade = 'O' WHERE marks>80;
UPDATE student SET grade = 'A' WHERE marks BETWEEN 70 AND 80;
UPDATE student SET grade = 'B' WHERE marks>60 AND marks<=70; -- 2nd WAY

-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Q.3 -> Create a table Employee. Insert 10 values.
CREATE TABLE employee (EmpID INT PRIMARY KEY,FirstName VARCHAR(30), LastName VARCHAR(25), Department VARCHAR(20), Salary INT, HireDate DATE);
INSERT INTO employee(EmpID,FirstName,LastName,Department,Salary,HireDate) VALUES (101,'Alice','Johnson','IT',6500,'2020-03-15'),
(102,'Mark','Rivera','HR',4800,'2019-07-22'),(103,'Sophia','Lee','Finance',7200,'2021-01-10'),(104,'Daniel','Kim','IT',5800,'2018-11-05'),
(105,'Emma','Brown','Marketing',5300,'2022-04-18'),(106,'Liam','Patel','Finance',6900,'2020-09-29'),(107,'Olivia','Garcia','HR',4600,'2017-06-30'),
(108,'Noah','Thompson','IT',7500,'2023-02-12'),(109,'Ava','Martinez','Marketing',5100,'2019-12-02'),(110,'Ethan','Davis','Finance',8000,'2016-05-14');

-- i. Write a query to display every employee and all their data.
SELECT * FROM employee;

-- ii. List only the FirstName, LastName & Salary of every employee.
SELECT Firstname,LastName,Salary FROM employee;

-- iii. Show all eployees who work in the 'IT' department.
SELECT * FROM employee WHERE Department='IT';

-- iv. Retrieve employees with a salary greater than 6000.
SELECT * FROM employee WHERE Salary>6000;

-- v. List all employees ordered by HireDate from newest to oldest.
SELECT * FROM employee ORDER BY HireDate DESC;

-- vi. Show a list of all unique departments present in the table.
SELECT DISTINCT Department FROM employee;

-- vii. Find employees whose first name starts with 'A'.
SELECT * FROM employee WHERE FirstName LIKE 'A%';

-- viii. Show employees whose salaries are between 4000 & 7000.
SELECT * FROM employee WHERE salary BETWEEN 4000 AND 7000;

-- ix. Find the average salary of all employees.
SELECT AVG(salary) FROM employee;

-- x. List each department along with the number of employees, but only include departments with more than 2 employees.
SELECT Department, COUNT(*) AS TotalEmployees FROM employee GROUP BY Department HAVING COUNT(*)>2;











