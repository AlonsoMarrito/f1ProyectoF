create table pilotos
(
	id_piloto int primary key,
	nombre varchar,
	escuderia varchar
);

create table gran_premio
(
	numero_de_carrera int,	
	nombre_del_gran_premio int,
	numero_de_piloto int,
	puntos_por_gp int
);

create table campeonato
(
	id_piloto int primary key,
	posicion int,
	puntos int
);

