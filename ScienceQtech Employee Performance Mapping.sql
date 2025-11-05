create database Employee
use Employee
--- Imported all the three tables into the database Employee
select * from proj_table
select * from data_science_team
select * from emp_record_table
----Question 3
select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,dept from emp_record_table

-----Question 4 less than
select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,dept, EMP_RATING from emp_record_table where EMP_RATING < 2

-----Question 4 greater than
select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,dept, EMP_RATING from emp_record_table where EMP_RATING > 4

-----Question 4 greater and equal
select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,dept, EMP_RATING from emp_record_table where EMP_RATING > 2 and EMP_RATING < 4

----Question 5
select EMP_ID,FIRST_NAME, LAST_NAME,concat(FIRST_NAME, ' ' ,LAST_NAME) as NAME from emp_record_table where dept='FINANCE'

----Question 6
SELECT Manager_ID AS EMP_ID, COUNT(*) AS Number_of_Reporters FROM emp_record_table WHERE Manager_ID IS NOT NULL GROUP BY Manager_ID

----Question 7
SELECT EMP_ID,FIRST_NAME, LAST_NAME, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME, dept FROM emp_record_table WHERE dept = 'FINANCE'
UNION
SELECT EMP_ID,FIRST_NAME, LAST_NAME, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME, dept FROM emp_record_table WHERE dept = 'HEALTHCARE'

----Question 8
SELECT EMP_ID, FIRST_NAME, LAST_NAME, role,dept, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING IN (SELECT MAX(EMP_RATING) FROM emp_record_table GROUP BY dept)

---Question 9
SELECT ROLE, MIN(salary) AS Min_Salary, MAX(salary) AS Max_Salary FROM emp_record_table GROUP BY ROLE

---Question 10
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, RANK() OVER (ORDER BY EXP DESC) AS `Rank` FROM emp_record_table

---Question 11
CREATE VIEW emp_top_earners AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, country, salary from emp_record_table where salary > 6000
select * from emp_top_earners

---Question 12
select EMP_ID, FIRST_NAME, LAST_NAME,EXP from emp_record_table where EMP_ID in (select EMP_ID from emp_record_table where EXP > 10)

---Question 13
DELIMITER $$
CREATE PROCEDURE GetEmployeesByExp(IN exp_threshold INT)
BEGIN SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, EXP, Salary
FROM emp_record_table
WHERE EXP > exp_threshold
END$$
DELIMITER 

CALL GetEmployeesByExp(3)

--Question 14
DELIMITER $$
CREATE Procedure GetJobProfile(exp INT) RETURNS VARCHAR(50)
BEGIN
    DECLARE job_profile VARCHAR(50);
    IF exp <= 2 THEN
        SET job_profile = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp > 2 AND exp <= 5 THEN
        SET job_profile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp > 5 AND exp <= 10 THEN
        SET job_profile = 'SENIOR DATA SCIENTIST';
    ELSEIF exp > 10 AND exp <= 12 THEN
        SET job_profile = 'LEAD DATA SCIENTIST';
    ELSEIF exp > 12 AND exp <= 16 THEN
        SET job_profile = 'MANAGER';
    ELSE
        SET job_profile = 'OTHER';
    END IF;
    RETURN job_profile;
END$$
DELIMITER ;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, GetJobProfile(EXP) AS Job_Profile
FROM emp_record_table;

----Question 15
select EMP_ID,FIRST_NAME from emp_record_table where FIRST_NAME like 'Eric%' 

---Question 16
select EMP_ID,FIRST_NAME,LAST_NAME,salary, EMP_RATING, (5/100 * salary * Emp_rating) as Bonus from emp_record_table

---Question 17
SELECT country, continent, AVG(salary) AS Average_Salary FROM emp_record_table GROUP BY country, continent

