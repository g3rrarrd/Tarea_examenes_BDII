select table_name from user_tables;

declare
    
    type registros_20191031354 is record (
        id_pago pago.id_pago%type,
        id_empleado pago.id_empleado%type,
        nombre_empleado varchar(100),
        monto pago.MONTO%type,
        fecha_pago varchar(50),
        email_empleado empleado.EMAIL%type,
        nombre_cliente varchar(100),
        fecha_cr_cliente varchar(50)
    );
    
    type tbl_datos_20191031354 is table of registros_20191031354;
    
    datos_20191031354 tbl_datos_20191031354;
    
begin

    select  a.ID_PAGO, 
            a.ID_EMPLEADO, 
            to_char(b.nombre || ' ' || b.apellido) nombre_empleado, 
            a.monto,
            to_char(a.FECHA_PAGO, 'yy/dd/mm') fecha_pago,
            b.email,
            to_char(c.nombre || ' ' || c.apellido) nombre_cliente,
            to_char(c.FECHA_CREACION, 'dd/yy/mm') fecha_creacion_cli
    bulk collect into datos_20191031354 
    from pago a
    inner join empleado b
    on a.id_empleado = b.id_empleado
    inner join cliente c
    on a.id_cliente = c.id_cliente
    where a.id_cliente in (1,2) and monto > 1;
    
    for iteracion in 1..sql%rowcount loop
        dbms_output.put_line('Id pago: ' || datos_20191031354(iteracion).id_pago);
        dbms_output.put_line('Id empleado: '|| datos_20191031354(iteracion).id_empleado);
        dbms_output.put_line('Nombre del empleado: ' || datos_20191031354(iteracion).nombre_empleado);
        dbms_output.put_line('Monto: ' || datos_20191031354(iteracion).monto);
        dbms_output.put_line('Fecha de pago: ' || datos_20191031354(iteracion).fecha_pago);
        dbms_output.put_line('Email empleado: ' || datos_20191031354(iteracion).email_empleado);
        dbms_output.put_line('Nombre del cliente: ' || datos_20191031354(iteracion).nombre_cliente);
        dbms_output.put_line('Fecha creacion del cliente: ' || datos_20191031354(iteracion).fecha_cr_cliente);
        dbms_output.put_line(chr(13));
    end loop;
    

end;

set serveroutput on;