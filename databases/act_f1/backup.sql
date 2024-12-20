PGDMP      )                |         	   formula_1    16.3    16.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    28298 	   formula_1    DATABASE     k   CREATE DATABASE formula_1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE formula_1;
                postgres    false            �            1255    28369    eliminar_gp_porpiloto(integer)    FUNCTION     �   CREATE FUNCTION public.eliminar_gp_porpiloto(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin

	delete from gran_premio where id_del_registro = $1;
	
return $1;
end;
$_$;
 5   DROP FUNCTION public.eliminar_gp_porpiloto(integer);
       public          postgres    false            �            1255    28314 B   registro_de_pilotos(integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.registro_de_pilotos(integer, character varying, character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
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
$_$;
 Y   DROP FUNCTION public.registro_de_pilotos(integer, character varying, character varying);
       public          postgres    false            �            1255    28368    restapuntos(integer, integer)    FUNCTION     �   CREATE FUNCTION public.restapuntos(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin

	update pilotos set puntos = (puntos - $2) where id_piloto = $1;
	
return $1;
end;
$_$;
 4   DROP FUNCTION public.restapuntos(integer, integer);
       public          postgres    false            �            1255    28347 1   resultado_gp(character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.resultado_gp(character varying, integer, integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare 
numero_de_carrera_interno int;
begin
select into numero_de_carrera_interno (numero_de_carrera) from gran_premio where nombre_del_gran_premio = $1;
	if (numero_de_carrera_interno is null) then
	select into numero_de_carrera_interno max (numero_de_carrera) from gran_premio;
		if (numero_de_carrera_interno is null) then
			numero_de_carrera_interno := 1;
		else 
			numero_de_carrera_interno := numero_de_carrera_interno + 1;
		end if;
	end if;

insert into gran_premio (numero_de_carrera, nombre_del_gran_premio, numero_de_piloto, lugar_por_gp) values
	(numero_de_carrera_interno, $1, $2, $3);
return $1;
end;
$_$;
 H   DROP FUNCTION public.resultado_gp(character varying, integer, integer);
       public          postgres    false            �            1255    28378    suma_de_campeonato()    FUNCTION     �  CREATE FUNCTION public.suma_de_campeonato() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;
 +   DROP FUNCTION public.suma_de_campeonato();
       public          postgres    false            �            1255    28367    sumapuntos(integer, integer)    FUNCTION     �   CREATE FUNCTION public.sumapuntos(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin

	update pilotos set puntos = (puntos + $2) where id_piloto = $1;
	
return $1;
end;
$_$;
 3   DROP FUNCTION public.sumapuntos(integer, integer);
       public          postgres    false            �            1259    28372    gran_premio    TABLE     �   CREATE TABLE public.gran_premio (
    id_del_registro integer NOT NULL,
    numero_de_carrera integer,
    nombre_del_gran_premio character varying,
    numero_de_piloto integer,
    lugar_por_gp integer
);
    DROP TABLE public.gran_premio;
       public         heap    postgres    false            �            1259    28371    gran_premio_id_del_registro_seq    SEQUENCE     �   CREATE SEQUENCE public.gran_premio_id_del_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.gran_premio_id_del_registro_seq;
       public          postgres    false    217                       0    0    gran_premio_id_del_registro_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.gran_premio_id_del_registro_seq OWNED BY public.gran_premio.id_del_registro;
          public          postgres    false    216            �            1259    28327    pilotos    TABLE     �   CREATE TABLE public.pilotos (
    id_piloto integer NOT NULL,
    nombre character varying,
    escuderia character varying,
    puntos integer
);
    DROP TABLE public.pilotos;
       public         heap    postgres    false            }           2604    28375    gran_premio id_del_registro    DEFAULT     �   ALTER TABLE ONLY public.gran_premio ALTER COLUMN id_del_registro SET DEFAULT nextval('public.gran_premio_id_del_registro_seq'::regclass);
 J   ALTER TABLE public.gran_premio ALTER COLUMN id_del_registro DROP DEFAULT;
       public          postgres    false    216    217    217                      0    28372    gran_premio 
   TABLE DATA           �   COPY public.gran_premio (id_del_registro, numero_de_carrera, nombre_del_gran_premio, numero_de_piloto, lugar_por_gp) FROM stdin;
    public          postgres    false    217   �                 0    28327    pilotos 
   TABLE DATA           G   COPY public.pilotos (id_piloto, nombre, escuderia, puntos) FROM stdin;
    public          postgres    false    215                     0    0    gran_premio_id_del_registro_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.gran_premio_id_del_registro_seq', 6, true);
          public          postgres    false    216                       2606    28333    pilotos pilotos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.pilotos
    ADD CONSTRAINT pilotos_pkey PRIMARY KEY (id_piloto);
 >   ALTER TABLE ONLY public.pilotos DROP CONSTRAINT pilotos_pkey;
       public            postgres    false    215            �           2620    28379    gran_premio suma_de_campeonato    TRIGGER     �   CREATE TRIGGER suma_de_campeonato AFTER INSERT ON public.gran_premio FOR EACH ROW EXECUTE FUNCTION public.suma_de_campeonato();
 7   DROP TRIGGER suma_de_campeonato ON public.gran_premio;
       public          postgres    false    234    217               &   x�3�4���L���44�4�2�4�vq��b���� n1�         �  x�]��nA��ާ�T��&�J��.AD�(3�a�gڐg�/V/��������S]�햢c����h��c�h�,*���8J�Á=,��uvN��ܪ..����Mb(�ܒ$-MMKQ�e�4��+8��u)x��#w���1��a\dV�X5��'���%�H�Nմo]�@K�0.S��L�
~H�5y|0j;r�U	s��3�I��\4�Ǚ�1k��"�9(aE.%����H>��f�����v��70!����~����g2�缳�(ه��A����O��pG޲Å5�R��
fG�Îq-<Y�,�O�k}�oG�n��_Ц�MC���\ܪ*K��N}S�6��ܝ�EK]��s���W���[Q�$���     