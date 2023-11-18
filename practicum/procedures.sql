set schema FN3MI0700050;

/*Създайте процедура във вашата схема,
която по подаден входен параметър - име (name) извежда на екрана низа - "Hello, <name>!". Извикайте процедурата.*/

CREATE PROCEDURE P_HELLO (IN P_NAME VARCHAR(20))
LANGUAGE SQL
     CALL DBMS_OUTPUT.PUT_LINE('Hello, ' || P_NAME || '!');

CALL FN3MI0700050.P_HELLO('Maria');

/*Създайте процедура във вашата схема, която има два входни параметъра числа - a и b и един изходен число,
като записва в изходния параметър корена от сумата от квадратите на двете числа. Извикайте процедурата.*/

CREATE PROCEDURE P_PITAGOR (IN P_A INT, IN P_B INT,  OUT P_SUM DECIMAL(9,2))
LANGUAGE SQL
 BEGIN
   SET P_SUM = SQRT(POWER(P_A,2) + POWER(P_B,2));
   CALL DBMS_OUTPUT.PUT_LINE('C = ' || P_SUM);
 end;

BEGIN
  DECLARE V_RESULT DECIMAL(9,2);
  CALL FN3MI0700050.P_PITAGOR(3, 4, V_RESULT);
  CALL DBMS_OUTPUT.PUT_LINE('C = ' || V_RESULT);
end;