/*Produce a report listing all employees whose last name ends with 'N'. List the
employee number, the last name, and the last character of the last name used to
control the result. The LASTNAME column is defined as VARCHAR. There is a
function which provides the length of the last name.*/
SELECT EMPNO,LASTNAME,
 SUBSTR(LASTNAME,LENGTH(LASTNAME),1) AS LASTCHAR
 FROM EMPLOYEE
WHERE LASTNAME LIKE '%N';

/*If the column LASTNAME had been defined as CHAR(x) one way to code this
WHERE clause could be:
WHERE LASTNAME LIKE '%N %' OR LASTNAME LIKE '%N'*/

/*For each project, display the project number, project name, department number, and
project number of its associated major project (COLUMN = MAJPROJ). If the value
in MAJPROJ is NULL, show a literal of your choice instead of displaying a null value.
List only projects assigned to departments D01 or D11. The rows should be listed in
project number sequence.*/
SELECT PROJNO, PROJNAME, DEPTNO,
 COALESCE(MAJPROJ,'NO MAJOR PROJECT') AS MAJPROJ
FROM PROJECT
WHERE DEPTNO IN ('D01','D11')
ORDER BY PROJNO;

/*The salaries of the employees in department E11 will be increased by 3.75 percent.
What will be the increase in dollars? Display the last name, actual yearly salary, and
the salary increase rounded to the nearest dollar. Do not show any cents*/
SELECT EMPNO, LASTNAME, WORKDEPT, SALARY,
 DECIMAL(SALARY * 0.0375 + 0.5, 5,0) AS AMOUNT
 FROM EMPLOYEE
WHERE WORKDEPT = 'E11';

--or by using ROUND():
SELECT EMPNO, LASTNAME, WORKDEPT, SALARY,
 INTEGER(ROUND(SALARY * 0.0375 ,0)) AS AMOUNT
 FROM EMPLOYEE
WHERE WORKDEPT = 'E11';
/*Round() gives in OS/390 a DECIMAL; in UNIX, Windows and OS/2
a FLOATING point value.*/

/*Repeat Problem 3 but this time express the amount of salary increase as an integer,
that is, a number with no decimal places and no decimal point. (QMF users, you do
not get a decimal point even for Problem 3, so there is no point in doing this problem
if you are using QMF.)*/
SELECT EMPNO, LASTNAME, WORKDEPT, SALARY,
 INTEGER(SALARY * 0.0375 + 0.5) AS AMOUNT
 FROM EMPLOYEE
WHERE WORKDEPT = 'E11';

/*For each female employee in the company present her department, her job and her
last name with only one blank between job and last name.*/
SELECT WORKDEPT, CAST(RTRIM(JOB) AS VARCHAR(10))
 !! ': ' !! LASTNAME AS LISTING
FROM EMPLOYEE
WHERE SEX='F';
--RTRIM removes trailing spaces !! is used for string concatenation

/*Calculate the difference between the date of birth and the hiring date for all
employees for whom the hiring date is more than 30 years later than the date of
birth. Display employee number and calculated difference. The difference should be
shown in years, months, and days - each of which should be shown in a separate
column. Make sure that the rows are in employee number sequence. */
SELECT EMPNO, YEAR(HIREDATE - BIRTHDATE) AS YEARS,
            MONTH(HIREDATE - BIRTHDATE) AS MONTHS,
            DAY(HIREDATE - BIRTHDATE) AS DAYS
FROM EMPLOYEE
WHERE YEAR(HIREDATE - BIRTHDATE) > 30
ORDER BY EMPNO;

/*Display project number, project name, project start date, and project end date of
those projects whose duration was less than 10 months. Display the project duration
in days*/
SELECT PROJNO, PROJNAME, PRSTDATE, PRENDATE,
 DAYS(PRENDATE) - DAYS(PRSTDATE) AS DAYS_DURATION
FROM PROJECT
WHERE PRENDATE - 10 MONTHS < PRSTDATE;

/*Find out which employees were hired on a Saturday or a Sunday. List their last
names and their hiring dates.*/
SELECT E.EMPNO, LASTNAME, FIRSTNME, ACTNO, EMSTDATE,
 DAYS(EMENDATE) - DAYS(EMSTDATE) AS DAYS_DURATION
FROM EMPLOYEE E JOIN EMP_ACT EA
 ON E.EMPNO = EA.EMPNO
WHERE EMSTDATE = (SELECT MAX(EMSTDATE) FROM EMP_ACT
 WHERE EMPNO = E.EMPNO)
AND E.WORKDEPT = 'D11';
