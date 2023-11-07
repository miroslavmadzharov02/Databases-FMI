SELECT EMPNO, LASTNAME, SALARY, WORKDEPT
FROM EMPLOYEE
WHERE WORKDEPT IN ('D11', 'D21')
AND SALARY BETWEEN 22000 AND 24000;

/*Now, Joe's manager wants information about the yearly salary. He wants to know
the minimum, the maximum, and average yearly salary of all employees with an
education level of 16. He also wants to know how many employees have this
education level*/
SELECT MIN(SALARY) AS MIN, MAX(SALARY) AS MAX,
 AVG(SALARY) AS AVG, COUNT(*) AS COUNT
FROM EMPLOYEE
WHERE EDLEVEL = 16;

/*Joe's manager is interested in some additional salary information. This time, he
wants information for every department that appears in the EMPLOYEE table,
provided that the department has more than five employees. The report needs to
show the department number, the minimum, maximum, and average yearly salary,
and the number of employees who work in the department*/
SELECT WORKDEPT, MIN(SALARY) AS MIN, MAX(SALARY) AS MAX,
 AVG(SALARY) AS AVG, COUNT(*) AS COUNT
FROM EMPLOYEE
GROUP BY WORKDEPT
HAVING COUNT(*) > 5;

/*Joe's manager wants information about employees grouped by department,
grouped by sex and in addition by the combination of department and sex. List only
those who work in a department which start with the letter D.
List the department, the sex, sum of the salaries, minimum salary and maximum
salary.
Note, the solution of this and the next problem can only be used on DB2 UDB for
UNIX, Windows and OS/2.*/
SELECT WORKDEPT,SEX,MIN(SALARY) AS MIN,MAX(SALARY) AS MAX,
 SUM(SALARY) AS SUM
FROM EMPLOYEE
WHERE WORKDEPT LIKE 'D%'
GROUP BY CUBE (WORKDEPT,SEX);

/*Joe's manager wants information about the average total salary for all departments.
List in department order, the department, average total salary and rank over the
average total salary*/
SELECT WORKDEPT, AVG(SALARY+BONUS) AS AVG_TOTAL_SALARY,
 RANK() OVER (ORDER BY AVG(SALARY+BONUS) DESC) AS RANK_AVG_SAL
 FROM EMPLOYEE
 GROUP BY WORKDEPT
 ORDER BY WORKDEPT;

