SELECT * FROM public.tabla1

	delete from tabla1

create or replace function incremento_id(varchar, varchar, date) returns int as $$
declare 
id_lugar int;

begin 

	select into id_lugar max(id_lugar_tabla1) from tabla1;

	if (id_lugar is null) then
		id_lugar := 1;
	else 
		id_lugar := id_lugar +1;
	end if;

	insert into tabla1 (id_lugar_tabla1, texto_1, texto_2, fecha) values (id_lugar, $1, $2, $3);

return id_lugar;
end;
$$ language 'plpgsql';

select incremento_id ('hola', 'jeje', '2024-12-26')

--------------------------------------------------------------------------------------------------------------

create or replace function eliminacion_id(int) returns int as $$
begin 

	delete from tabla1 where id_lugar_tabla1 = $1;

return $1;
end;
$$ language 'plpgsql';

select eliminacion_id (4)

--------------------------------------------------------------------------------------------------------------

create or replace function actualizacion_datos(int, varchar, varchar, date) returns int as $$
begin 

	update tabla1 set texto_1 = $2, texto_2 = $3, fecha = $4 where id_lugar_tabla1 = $1;

return $1;
end;
$$ language 'plpgsql';

select actualizacion_datos (6,'','','2020-11-11')


