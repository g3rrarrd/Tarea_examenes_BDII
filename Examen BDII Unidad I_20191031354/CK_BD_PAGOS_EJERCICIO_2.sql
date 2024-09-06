
/*Se crearia una tabla bitacoras para manejar la informacion alterada dentro de la tabla cliente
Asi se maneja toda la informacion que se inserta, actualza y elimina dentro de la misma y la almacena
dentro de la tabla bitacora junto al usuario que hizo la accion
*/

//Tabla bitacora
create table BITACORAS_CLIENTES_20191031354 (
    id_bitacora number primary key,
    Usuario varchar2(100) not null,
    tipo_operacion varchar2(20) not null,
    Descripcion varchar2(4000) not null,
    fecha_hora_operacion timestamp not null
);

//Sequencia para bitacoras
create sequence sq_bit_pk_20191031354 start with 1 increment by 1 nocache;

//Triger para manejar las operaciones que se hacen dentro de la tabla clientes
create or replace trigger tg_bitacoras_20191031354 after delete or insert or update on cliente
for each row 
declare 
    pragma autonomous_transaction;
begin
    if deleting then
        insert into BITACORAS_CLIENTES_20191031354 values (sq_bit_pk_20191031354.nextval,user , 'DELETE', 
        'Se ha eliminado el cliente con la siguiente informacion: ID: ' || :old.id_cliente || 
        ' Nombre: ' || :old.nombre || ' ' || :old.apellido || ' Email: ' || :old.email || ' Id_direccion: ' || :old.ID_DIRECCION || 
        ' Fecha Creacion: ' || :old.FECHA_CREACION || ' Activo: ' || :old.ACTIVO || ' Id_tienda: ' || :old.ID_TIENDA,
        systimestamp
        );
        commit;
    elsif inserting then
        insert into BITACORAS_CLIENTES_20191031354 values (sq_bit_pk_20191031354.nextval,user , 'INSERT', 
        'Se ha insertando el cliente con la siguiente informacion: ID: ' || :new.id_cliente || 
        ' Nombre: ' || :new.nombre || ' ' || :new.apellido || ' Email: ' || :new.email || ' Id_direccion: ' || :new.ID_DIRECCION || 
        ' Fecha Creacion: ' || :new.FECHA_CREACION || ' Activo: ' || :new.ACTIVO || ' Id_tienda: ' || :new.ID_TIENDA,
        systimestamp
        );
        commit;
    elsif updating then
        insert into BITACORAS_CLIENTES_20191031354 values (sq_bit_pk_20191031354.nextval, user , 'UPDATE', 
        'Se ha actualizado el cliente con la siguiente informacion: ID: ' || :new.id_cliente || 
        ' Nombre: ' || :new.nombre || ' ' || :new.apellido || ' Email: ' || :new.email || ' Id_direccion: ' || :new.ID_DIRECCION || 
        ' Fecha Creacion: ' || :new.FECHA_CREACION || ' Activo: ' || :new.ACTIVO || ' Id_tienda: ' || :new.ID_TIENDA,
        systimestamp
        );
        commit;
    end if;
    
    EXCEPTION 
        when others then
            rollback;
end;

//Pruebas

declare

begin
    insert into cliente values (10, 1, 'Pedro', 'Mendez', 'Pmendez@amil.com', 1, 'ACTIVO', sysdate, sysdate);

    delete cliente where id_cliente = 10;

    update cliente set nombre = 'Maria' where id_cliente = 10;
end;