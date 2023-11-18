SET SCHEMA FN3MI0700050;

-- Зад. 1. Създайте модул във вашата схема с име mod1.
CREATE MODULE MOD1;

-- Зад. 2. Създайте процедура в модула, която има един входен параметър - дата на раждане и един изходен
-- параметър  число. Процедурата записва в изходния параметър на колко години е човекът към днешна дата.
-- Извикайте процедурата.

ALTER MODULE MOD1 PUBLISH PROCEDURE AGE(IN P_BIRTHDATE DATE, OUT P_AGE INT);

ALTER MODULE MOD1 ADD PROCEDURE AGE(IN P_BIRTHDATE DATE, OUT P_AGE INT)
    BEGIN
        SET P_AGE = YEAR(CURRENT_DATE - P_BIRTHDATE); -- 771003
        CALL DBMS_OUTPUT.PUT_LINE('AGE IS:' || P_AGE);
    end;

BEGIN
  DECLARE V_AGE INT;
  CALL FN3MI0700050.MOD1.AGE('2010-01-15',V_AGE);
end;

-- Зад. 3. Създайте процедура към вашия модул, която за таблиците COUNTRIES  от схемата DB2HR,
-- по входен параметър код на държава, връща като изходен параметър името на държавата. Извикайте процедурата.
ALTER MODULE MOD1
DROP PROCEDURE CNTNAME;

ALTER MODULE MOD1
PUBLISH PROCEDURE CNTNAME(IN P_CNTID ANCHOR DB2HR.COUNTRIES.COUNTRY_ID,
                          OUT P_CNTNAME ANCHOR DB2HR.COUNTRIES.COUNTRY_NAME);

ALTER MODULE MOD1
ADD PROCEDURE CNTNAME(IN P_CNTID ANCHOR DB2HR.COUNTRIES.COUNTRY_ID,
                          OUT P_CNTNAME ANCHOR DB2HR.COUNTRIES.COUNTRY_NAME)
    SET P_CNTNAME = (SELECT COUNTRY_NAME FROM DB2HR.COUNTRIES WHERE COUNTRY_ID = P_CNTID);


BEGIN
  DECLARE V_CNTNAME VARCHAR(50);
  CALL FN3MI0700050.MOD1.CNTNAME('CH',V_CNTNAME);
  CALL DBMS_OUTPUT.PUT_LINE('COUNTRY IS: ' || V_CNTNAME);
end;

-- Зад. 4. Създайте процедура към вашия модул, която за таблиците COUNTRIES и REGIONS от схемата DB2HR,
-- връща като изходни параметри името на региона и броя на страните за този регион с най-много страни.
-- Извикайте процедурата.

SELECT R.REGION_NAME, COUNT(C.COUNTRY_ID)
FROM DB2HR.COUNTRIES C, DB2HR.REGIONS R
WHERE C.REGION_ID=R.REGION_ID
GROUP BY R.REGION_ID, R.REGION_NAME
HAVING COUNT(C.COUNTRY_ID) >= ALL(SELECT  COUNT(C.COUNTRY_ID)
                               FROM DB2HR.COUNTRIES C, DB2HR.REGIONS R
                               WHERE C.REGION_ID=R.REGION_ID
                               GROUP BY R.REGION_ID, R.REGION_NAME);

SELECT R.REGION_NAME, COUNT(C.COUNTRY_ID) CNT
FROM DB2HR.COUNTRIES C, DB2HR.REGIONS R
WHERE C.REGION_ID=R.REGION_ID
GROUP BY R.REGION_ID, R.REGION_NAME
ORDER BY CNT DESC
FETCH FIRST 1 ROWS ONLY;

ALTER MODULE MOD1 PUBLISH PROCEDURE P_REG_MAX_CNT(OUT P_REGNAME ANCHOR DB2HR.REGIONS.REGION_NAME,
                                                  OUT P_MAX_CNT INT);
ALTER MODULE MOD1 ADD PROCEDURE P_REG_MAX_CNT(OUT P_REGNAME ANCHOR DB2HR.REGIONS.REGION_NAME,
                                                  OUT P_MAX_CNT INT)
 BEGIN
     SELECT R.REGION_NAME, COUNT(C.COUNTRY_ID) CNT  INTO P_REGNAME, P_MAX_CNT
     FROM DB2HR.COUNTRIES C, DB2HR.REGIONS R
     WHERE C.REGION_ID=R.REGION_ID
     GROUP BY R.REGION_ID, R.REGION_NAME
     ORDER BY CNT DESC
     FETCH FIRST 1 ROWS ONLY;

     SET (P_REGNAME, P_MAX_CNT) = (SELECT R.REGION_NAME, COUNT(C.COUNTRY_ID) CNT
                                FROM DB2HR.COUNTRIES C, DB2HR.REGIONS R
                                WHERE C.REGION_ID=R.REGION_ID
                                GROUP BY R.REGION_ID, R.REGION_NAME
                                ORDER BY CNT DESC
                                FETCH FIRST 1 ROWS ONLY);
 end;

BEGIN
    DECLARE V_REGNAME ANCHOR DB2HR.REGIONS.REGION_NAME;
    DECLARE V_MAX_CNT INT;
    CALL FN3MI0700050.MOD1.P_REG_MAX_CNT(V_REGNAME, V_MAX_CNT);
    CALL DBMS_OUTPUT.PUT_LINE('--------------------');
    CALL DBMS_OUTPUT.PUT_LINE('REGION WITH MAX COUNTRIES IS: ' || V_REGNAME || ', NUMBER IS: ' || V_MAX_CNT);
    CALL DBMS_OUTPUT.PUT_LINE('--------------------');
end;

-- Зад. 5. Премахнете процедурата от зад 4. от модула.
ALTER MODULE MOD1 DROP PROCEDURE P_REG_MAX_CNT;

-- Зад. 6. Изтрийте модула mod1
DROP MODULE MOD1;
