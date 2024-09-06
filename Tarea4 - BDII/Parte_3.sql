//tabla creada para las dietas
create table animalDietaObsoleta(
        ANIMALID VARCHAR2(20),
        DIETAID VARCHAR2(20),
        FECHAINICIO date,
        FECHAFINAL date,
        DESCRIPCION VARCHAR2(500),
        constraint pk_primary primary key (ANIMALID, DIETAID)
);

//funcion para ver la diferencia de meses
create or replace function fn_obtener_diferencia_mes(fecha_inicial date, fecha_final date)
return number
is

    resultado number;

begin

        resultado := round(((fecha_final)-(fecha_inicial))/30, 0);
        
        return resultado;

end;


//proceso de insercion
create or replace procedure sp_obtener_dietas_obsoletas 
is

    dietas_obsoletas SYS_REFCURSOR;
    
    type datos_dietas is record (
        animalid animalxdieta.animalid%type,
        dietaid animalxdieta.dietaid%type,
        fechainicio date,
        fechafinal date,
        descripcion dieta.descripcion%type
    );
    fila datos_dietas;

begin

    open dietas_obsoletas for 
    select animalid, a.dietaid, fechainicio, fechafinal, descripcion 
    from animalxdieta a left join dieta b on a.dietaid = b.dietaid;
    
    loop
    
        fetch dietas_obsoletas into fila;
        
        if (fn_obtener_diferencia_mes(fila.fechainicio, fila.fechafinal) <= 1) then 
            
            insert into animaldietaobsoleta values (fila.animalid, fila.dietaid, fila.fechainicio, fila.fechafinal, fila.descripcion);
            
        end if;
        
        exit when dietas_obsoletas%notfound;
    
    end loop;
    
    commit;
    
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(concat('Ha ocurrido una excepcion: ', sqlcode));
            rollback;
    

end;

//Pruebas
execute SP_OBTENER_DIETAS_OBSOLETAS;

select * from animaldietaobsoleta;





