--1

--FUNCION
CREATE OR REPLACE FUNCTION FN_RETORNAR_EMPLEADOS_20191031354(OFICINA VARCHAR2)
RETURN SYS_REFCURSOR
IS
    EMPLEADOS SYS_REFCURSOR;
BEGIN
    
    OPEN EMPLEADOS FOR
    SELECT a.id_employee, a.salary FROM employees A 
    INNER JOIN branch_office B 
    ON A.ID_BOFFICE = b.id_boffice
    WHERE b.address_bo = OFICINA;
    
    RETURN EMPLEADOS;
    
END;


--BLOQUE ANONIMO
DECLARE

    DATOS_EMPLEADOS SYS_REFCURSOR;
    
    TYPE TBL_EMP IS RECORD(
        ID_EMP EMPLOYEES.ID_EMPLOYEE%TYPE,
        SALARIO EMPLOYEES.SALARY%TYPE
    );
    
    FILA TBL_EMP;

BEGIN

   DATOS_EMPLEADOS := FN_RETORNAR_EMPLEADOS_20191031354('21 Hermina Trail');
   
   LOOP
        FETCH DATOS_EMPLEADOS INTO FILA;
        EXIT WHEN DATOS_EMPLEADOS%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('ID: ' || FILA.ID_EMP);
        DBMS_OUTPUT.PUT_LINE('SALARIO: ' || FILA.SALARIO);
   
   END LOOP;

END;



SELECT * FROM employees;
DESC EMPLOYEES;


SELECT * FROM branch_office;