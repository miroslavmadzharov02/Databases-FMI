--Produce a report that lists employees' last names, first names, and department
--names. Sequence the report on first name within last name, within department name.
SELECT E.LASTNAME, E.FIRSTNME, D.DEPTNAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.WORKDEPT = D.DEPTNO
ORDER BY D.DEPTNAME, E.LASTNAME, E.FIRSTNME;

--Modify the previous query to include job. Also, list data for only departments
--between A02 and D22, and exclude managers from the list. Sequence the report on
--first name within last name, within job, within department name.
SELECT E.LASTNAME, E.FIRSTNME, D.DEPTNAME, E.JOB
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.WORKDEPT = D.DEPTNO
 AND E.WORKDEPT BETWEEN 'A02' AND 'D22'
 AND JOB <> 'MANAGER'      --   <> means "not equal"
ORDER BY D.DEPTNAME, E.LASTNAME, E.FIRSTNME;

--List the name of each department and the lastname and first name of its manager.
--Sequence the list by department name. Use the EMPNO and MGRNO columns to
--relate the two tables. Sequence the result rows by department name.
SELECT D.DEPTNAME, E.LASTNAME, E.FIRSTNME
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.MGRNO = E.EMPNO
ORDER BY D.DEPTNAME;

