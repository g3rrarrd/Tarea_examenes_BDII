--ENCABEZADO DEL PAQUETE
CREATE OR REPLACE PACKAGE PG_CALCULOS_20191031354
IS
    PROCEDURE SP_CALCULAR_PROM_20191031354(TIPO_PROPIEDAD PROPERTYS.PROPERTY_TYPE%TYPE, PROMEDIO OUT PROPERTYS.PRICE%TYPE);
    
    PROCEDURE SP__SUM_TOTAL_20191031354(ID_JOB JOBS.ID_JOBS%TYPE, SUMA_TOTAL OUT EMPLOYEES.SALARY%TYPE);
END;

--CUERPO DEL PAQUETE
CREATE OR REPLACE PACKAGE BODY PG_CALCULOS_20191031354
IS

    --CALCULAR EL PROMEDIO
    PROCEDURE SP_CALCULAR_PROM_20191031354(TIPO_PROPIEDAD PROPERTYS.PROPERTY_TYPE%TYPE, PROMEDIO OUT PROPERTYS.PRICE%TYPE)
    IS
        DATOS_PROPIEDADES SYS_REFCURSOR;
        
        CANT_PROPIEDADES NUMBER(3) := 0;
        
        SUMA_PROPIEDADES PROPERTYS.PRICE%TYPE := 0;
        
        PRECIO PROPERTYS.PRICE%TYPE;
        
    BEGIN
    
        OPEN DATOS_PROPIEDADES FOR
        SELECT PRICE FROM PROPERTYS WHERE property_type = TIPO_PROPIEDAD;
        
        LOOP
            
            FETCH DATOS_PROPIEDADES INTO PRECIO;
            EXIT WHEN DATOS_PROPIEDADES%NOTFOUND;
            
            SUMA_PROPIEDADES := SUMA_PROPIEDADES+PRECIO;
            CANT_PROPIEDADES := CANT_PROPIEDADES+1;
            
        END LOOP;
        
        PROMEDIO := SUMA_PROPIEDADES/CANT_PROPIEDADES;
    
    
    END;
    
    --SUMA DE SALARIO
    PROCEDURE SP__SUM_TOTAL_20191031354(ID_JOB JOBS.ID_JOBS%TYPE, SUMA_TOTAL OUT EMPLOYEES.SALARY%TYPE)
    IS
        EMPLEADOS SYS_REFCURSOR;
        
        SALARIO EMPLOYEES.SALARY%TYPE;
        
        SUMA_SALARIO EMPLOYEES.SALARY%TYPE := 0;
    BEGIN
    
        OPEN EMPLEADOS FOR
        SELECT SALARY FROM EMPLOYEES A INNER JOIN JOBS B ON A.ID_JOBS = B.ID_JOBS WHERE A.ID_JOBS = ID_JOB;
        
        LOOP
            FETCH EMPLEADOS INTO SALARIO;
            EXIT WHEN EMPLEADOS%NOTFOUND;
            
            SUMA_SALARIO := SUMA_SALARIO+SALARIO;
        END LOOP;
        
        SUMA_TOTAL := SUMA_SALARIO;
    
    END;

END;

DECLARE

    PROMEDIO PROPERTYS.PRICE%TYPE;
    
    SUMA_TOTAL EMPLOYEES.SALARY%TYPE;

BEGIN

    PG_CALCULOS_20191031354.SP_CALCULAR_PROM_20191031354('Home', PROMEDIO);
    
    PG_CALCULOS_20191031354.SP__SUM_TOTAL_20191031354(7, SUMA_TOTAL);
    
    DBMS_OUTPUT.PUT_LINE('EL PROMEDIO ES: ' || PROMEDIO);
    DBMS_OUTPUT.PUT_LINE('LA SUMA ES: ' || SUMA_TOTAL);

END;



SELECT * FROM PROPERTYS WHERE property_type = 'Home';

SELECT * FROM jobs;

SELECT SUM(SALARY) FROM EMPLOYEES A INNER JOIN JOBS B ON A.ID_JOBS = B.ID_JOBS WHERE A.ID_JOBS = 7;