SELECT * FROM public.pilotos
SELECT * FROM public.gran_premio
	
ORDER BY id_piloto ASC 

	delete from gran_premio
	update pilotos set puntos = 0 
--------------------------------------------------------------------------------------------------------------

create or replace function registro_de_pilotos(int, varchar, varchar) returns int as $$
declare
piloto_escuderia int;
begin 
	select count (*) into piloto_escuderia from pilotos where escuderia = $3;
	if (piloto_escuderia <= 1) then 
		insert into pilotos (id_piloto, nombre, escuderia, puntos) values ($1, $2, $3, 0);
	else 
		$1 := 0;
	end if;
return $1;
end;
$$ language 'plpgsql';

select registro_de_pilotos(11, 'Sergio Perez', 'Red Bull')

--------------------------------------------------------------------------------------------------------------

create or replace function suma_de_campeonato() returns trigger as $$
declare 
	puntos_por_gp int;

begin 
		if (new.lugar_por_gp = 1) then
			puntos_por_gp := 25;
		elseif (new.lugar_por_gp = 2) then
			puntos_por_gp := 18;
		elseif (new.lugar_por_gp = 3) then
			puntos_por_gp := 15;
		elseif (new.lugar_por_gp = 4) then
			puntos_por_gp := 12;
		elseif (new.lugar_por_gp = 5) then
			puntos_por_gp := 10;
		elseif (new.lugar_por_gp = 6) then
			puntos_por_gp := 8;
		elseif (new.lugar_por_gp = 7) then
			puntos_por_gp := 6;	
		elseif (new.lugar_por_gp = 8) then
			puntos_por_gp := 4;
		elseif (new.lugar_por_gp = 9) then
			puntos_por_gp := 2;
		elseif (new.lugar_por_gp = 10) then
			puntos_por_gp := 1;
		elseif (new.lugar_por_gp > 10) then
			puntos_por_gp := 0;
		end if;

	update pilotos set puntos = (puntos + puntos_por_gp) where id_piloto = new.numero_de_piloto;

return new;
end;
$$ language 'plpgsql';

create trigger suma_de_campeonato
after insert on gran_premio
for each row execute function suma_de_campeonato();

--------------------------------------------------------------------------------------------------------------

create or replace function resultado_gp(varchar, int, int) returns varchar as $$
declare 
numero_de_carrera_interno int;
begin
select into numero_de_carrera_interno (numero_de_carrera) from gran_premio where nombre_del_gran_premio = $1;
	if (numero_de_carrera_interno is null) then
	select into numero_de_carrera_interno max (numero_de_carrera) from gran_premio;
		if (numero_de_carrera_interno is null) then
			numero_de_carrera_interno := 1;
		else 
			numero_de_carrera_interno := numero_de_carrera_interno + 1
		end if;
	end if;

insert into gran_premio (numero_de_carrera, nombre_del_gran_premio, numero_de_piloto, lugar_por_gp) values
	(numero_de_carrera_interno, $1, $2, $3);
return $1;
end;
$$ language 'plpgsql';

select resultado_gp('Miami', 11, 1)

--------------------------------------------------------------------------------------------------------------

create or replace function sumapuntos(int, int) returns int as $$
begin

	update pilotos set puntos = (puntos + $2) where id_piloto = $1;
	
return $1;
end;
$$ language 'plpgsql';

select sumapuntos(11, 1)

--------------------------------------------------------------------------------------------------------------

create or replace function restapuntos(int, int) returns int as $$
begin

	update pilotos set puntos = (puntos - $2) where id_piloto = $1;
	
return $1;
end;
$$ language 'plpgsql';

select restapuntos(11, 2)

--------------------------------------------------------------------------------------------------------------

create or replace function eliminar_gp_porpiloto(int) returns int as $$
begin

	delete from gran_premio where id_del_registro = $1;
	
return $1;
end;
$$ language 'plpgsql';

select restapuntos(1)