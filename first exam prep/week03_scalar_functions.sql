--For employees whose salary, increased by 5 percent, is less than or equal to $20,000, list the following:
--Last name, Current Salary. Salary increased by 5 percent, Monthly salary increased by 5 percent
--Use the following column names for the two generated columns:
--INC-Y-SALARY and INC-M-SALARY Use the proper conversion function to display
--the increased salary and monthly salary with two of the digits to the right of the
--decimal point. Sort the results by annual salary.
SELECT LASTNAME, SALARY,
DECIMAL(SALARY*1.05,9,2) AS "INC-Y-SALARY",
--DECIMAL(value you want to format, total number of digits in result, number of digits to the right of decimal point)
DECIMAL(SALARY*1.05/12,9,2) AS "INC-M-SALARY"
FROM EMPLOYEE
WHERE SALARY*1.05 <= 20000
ORDER BY SALARY;

/*All employees with an education level of 18 or 20 will receive a salary increase of
$1,200 and their bonus will be cut in half. List last name, education level, new salary,
and new bonus for these employees. Display the new bonus with two digits to the
right of the decimal point.
Use the column names NEW-SALARY and NEW-BONUS for the generated
columns.
Employees with an education level of 20 should be listed first. For employees with
the same education level, sort the list by salary*/
SELECT LASTNAME, EDLEVEL,
SALARY+1200 AS "NEW-SALARY",
DECIMAL(BONUS*0.5,9,2) AS "NEW-BONUS"
FROM EMPLOYEE
WHERE EDLEVEL IN (18, 20)
ORDER BY EDLEVEL DESC, SALARY;

/*The salary will be decreased by $1,000 for all employees matching the following
criteria:
 • They belong to department D11
 • Their salary is more than or equal to 80 percent of $20,000
 • Their salary is less than or equal to 120 percent of $20,000
Use the name DECR-SALARY for the generated column.
List department number, last name, salary, and decreased salary. Sort the result by
salary*/
SELECT WORKDEPT, LASTNAME, SALARY,
SALARY-1000 AS "DECR-SALARY"
FROM EMPLOYEE
WHERE SALARY BETWEEN 20000 * 0.80 AND 20000 * 1.20
AND WORKDEPT = 'D11'
ORDER BY SALARY;

/*Produce a list of all employees in department D11 that have an income (sum of
salary, commission, and bonus) that is greater than their salary increased by 10
percent.
Name the generated column INCOME.
List department number, last name, and income. Sort the result in descending order
by income.
For this problem assume that all employees have non-null salaries, commissions,
and bonuses*/
SELECT WORKDEPT, LASTNAME, SALARY+COMM+BONUS AS INCOME
FROM EMPLOYEE
WHERE SALARY+COMM+BONUS > 1.1*SALARY
AND WORKDEPT = 'D11'
ORDER BY INCOME DESC;

/*List all departments that have no manager assigned. List department number,
department name, and manager number. Replace unknown manager numbers with
the word UNKNOWN and name the column MGRNO.*/
SELECT DEPTNO, DEPTNAME , COALESCE(MGRNO, 'UNKNOWN') AS MGRNO
-- coalesce looks in column for non null values if they are null it replaces them with the second argument
FROM DEPARTMENT
WHERE MGRNO IS NULL;

/*List the project number and major project number for all projects that have a project
number beginning with MA. If the major project number is unknown, display the text
'MAIN PROJECT.'
Name the derived column MAJOR PROJECT.
Sequence the results by PROJNO*/
SELECT PROJNO,
COALESCE(MAJPROJ,'MAIN PROJECT') AS "MAJOR PROJECT"
FROM PROJECT
WHERE SUBSTR(PROJNO,1,2) ='MA'
ORDER BY PROJNO;

/*List all employees who were younger than 25 when they joined the company.
List their employee number, last name, and age when they joined the company.
Name the derived column AGE.
Sort the result by age and then by employee number.*/
SELECT EMPNO, LASTNAME, YEAR(HIREDATE-BIRTHDATE) AS AGE -- YEAR extracts the year off a date
FROM EMPLOYEE
WHERE YEAR(HIREDATE-BIRTHDATE) < 25
ORDER BY AGE, EMPNO;

/*Provide a list of all projects which ended on December 1, 1982. Display the year and
month of the starting date and the project number. Sort the result by project number.
Name the derived columns YEAR and MONTH. */
SELECT YEAR(PRSTDATE) AS YEAR, MONTH(PRSTDATE) AS MONTH, PROJNO
FROM PROJECT
WHERE PRENDATE = '1982-12-01'
ORDER BY PROJNO;

/*List the project number and duration, in weeks, of all projects that have a project
number beginning with MA. The duration should be rounded and displayed with one
decimal position.
Name the derived column WEEKS.
Order the list by the project number. */
SELECT PROJNO,
DECIMAL((DAYS(PRENDATE)-DAYS(PRSTDATE))/7.0+0.05,8,1) AS WEEKS
FROM PROJECT
WHERE PROJNO LIKE 'MA%'
ORDER BY PROJNO;

/*For projects that have a project number beginning with MA, list the project number,
project ending date, and a modified ending date assuming the projects will be
delayed by 10 percent.
Name the column containing PRENDATE, ESTIMATED. Name the derived column
EXPECTED.
Order the list by project number*/
SELECT PROJNO, PRENDATE AS ESTIMATED,
PRSTDATE + ((DAYS(PRENDATE) - DAYS(PRSTDATE))*1.1) DAYS
AS EXPECTED
FROM PROJECT
WHERE PROJNO LIKE 'MA%'
ORDER BY PROJNO;

/*How many days are between the first manned landing on the moon (July 20, 1969)
and the first day of the year 2000?
Since no columns from a specific table are used in this problem, you can use any
table in the FROM clause but you should indicate a WHERE condition that derives a
single result row (unique key). You may also select from the SYSIBM.SYSDUMMY1
table which produces a one row result.
Name the derived column DAYS.*/
SELECT DAYS('2000-01-01')-DAYS('1969-07-20') AS DAYS
FROM EMPLOYEE
WHERE EMPNO = '000010';


SELECT DAYS('2000-01-01')-DAYS('1969-07-20') AS DAYS
FROM SYSIBM.SYSDUMMY1;