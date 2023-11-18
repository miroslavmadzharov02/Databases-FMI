set schema FN3MI0700050;

CREATE OR REPLACE MODULE HW1;

CREATE OR REPLACE FUNCTION HW1.CountDigits(IN p_number INT) RETURNS INT
BEGIN
    DECLARE v_digit_count INT;
    SET v_digit_count = LENGTH(TO_CHAR(p_number));
    RETURN v_digit_count;
END;

SELECT HW1.COUNTDIGITS(565565) FROM SYSIBM.SYSDUMMY1;




SET SCHEMA DB2HR;

CREATE OR REPLACE PROCEDURE DB2HR.PrintEmployeeData(IN p_employee_id INT)
BEGIN
    DECLARE v_dept_name VARCHAR(50);
    DECLARE v_manager_name VARCHAR(60);
    DECLARE v_previous_jobs VARCHAR(300);

    SELECT DEPARTMENT_NAME INTO v_dept_name
    FROM EMPLOYEES e
    JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
    WHERE e.EMPLOYEE_ID = p_employee_id;

    SELECT (FIRST_NAME || ' ' || LAST_NAME) INTO v_manager_name
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = (SELECT MANAGER_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = p_employee_id));

     IF v_manager_name IS NULL THEN
        SET v_manager_name = 'NO MANAGER';
    END IF;

    SELECT LISTAGG('Previous Employee ID:' || EMPLOYEE_ID || '; Worked as ' || j.JOB_TITLE
                       || '; Years worked: ' || TO_CHAR(YEAR(END_DATE - START_DATE))
                       || '; Months worked: ' || TO_CHAR(MONTH(END_DATE - START_DATE))
                       || '; Days worked: ' || TO_CHAR(DAY(END_DATE - START_DATE)) || '; ')
    INTO v_previous_jobs
    FROM JOB_HISTORY jh, JOBS j
    WHERE EMPLOYEE_ID = p_employee_id AND jh.JOB_ID = j.JOB_ID;

    CALL DBMS_OUTPUT.PUT_LINE('Department name: ' || v_dept_name || ';');
    CALL DBMS_OUTPUT.PUT_LINE('Manager name: ' || v_manager_name || ';');
    CALL DBMS_OUTPUT.PUT_LINE(v_previous_jobs);

end;

BEGIN
    CALL DB2HR.PrintEmployeeData(200);
end;
