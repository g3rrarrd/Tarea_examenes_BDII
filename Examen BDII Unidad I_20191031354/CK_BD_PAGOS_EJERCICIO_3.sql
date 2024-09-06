declare 
    
begin 
    
    
    insert into empleado values (3, 'Maria', 'Gonsalez', 1, 'MariGon@ejemplo.com', 1, 1, 'Maria', 'sadljsalkdnasklnda', sysdate);
    savepoint estadoGuardado;
    insert into empleado values (4, 'Pedro', 'Gonsalez', 1, 'PedroGon@ejemplo.com', 1, 1, 'Pedro', 'sasddljsalkdnasklnda', sysdate);
    savepoint estadoGuardado;
    insert into empleado values (5, 'Juan', 'Gonsalez', 1, 'MariGon@ejemplo.com', 2, 1, 'Juan', 'sadfasfalkdnasklnda', sysdate);
    savepoint estadoGuardado;
    insert into empleado values (6, 'Leon', 'Gonsalez', 1, 'MariGon@ejemplo.com', 2, 1, 'Leon', 'sadljsacxvxcvkdnasklnda', sysdate);
    savepoint estadoGuardado;
    
    commit;
    
    EXCEPTION
        when dup_val_on_index then
            dbms_output.put_line('Llave primaria duplicada');
            rollback to savepoint estadoGuardado;
            commit;
        when others then
            if sqlcode = -01843 then
                dbms_output.put_line('Error en insertar la fecha de actualizacion, valor incorrecto en el mes');
                rollback to savepoint estadoGuardado;
                commit;
            elsif sqlcode = -01839 then
                dbms_output.put_line('Error en insertar la fecha de actualizacion, valor incorrecto en el dia');
                rollback to savepoint estadoGuardado;
                commit;
            end if;
            rollback to savepoint estadoGuardado;
            commit;
end;
