create database NuevaEra;
use NuevaEra;
create table construccion(
	id_const varchar(10) primary key,
    pagina_rec varchar(50),
    url_pagina varchar(100),
    nomb_const varchar(50),
    etapa_const varchar(30),
    ubicacion varchar(40),
    direccion varchar(50),
    tipo_const varchar(20),
    tamaño varchar(20),
    fecha_culm_esp date,
    financiamiento varchar(20),
    constructora varchar(50),
    comentario varchar(50),
    descripcion varchar(100),
    estado varchar(20)
);

create table construc_pub(
	id_const varchar(10) primary key,
    cod_infobras varchar(10),
    entidad varchar(100),
    etapa varchar(30),
    modalidad varchar(30),
    ubicacion varchar(50),
    descripcion varchar(400),
    tipo varchar(30),
    estado_o varchar(30),
    presupuesto varchar(20),
    fecha_rec date,
    estado varchar(30),
    coment varchar(100)
);

create table usuario(
	id_usuario varchar(10) primary key,
    nom_usuario varchar(30),
    ape_usuario varchar(40),
    dni varchar(8),
    fecha_nac date,
    sexo char(1),
    mail varchar(50),
    telefono varchar(10),
    distrito varchar(40),
    estado char(1)
);

insert into construccion values('CT-1000000','NEXOINMOBILIARIO','https://nexoinmobiliario.pe/proyecto/venta-de-departamento-99','Condominio los defensores','Entrega inmediata','Chorrillos','Av. Defensores del Morro 1475','Privada','','2020-01-01','BBVA','La Venturosa','','','VENCIDA');
select*from construccion;
select*from usuario;

delimiter 
create procedure sp_regis_empleado(
id_emple varchar(10),
nom_emple varchar(30),
ape_emple varchar(40),
dni_emple varchar(8),
fech_nac date,
mail varchar(50),
telef varchar(10),
distr varchar(40),
estado_emple char(1))
begin
	if exists(select id_usuario from usuario where id_usuario=id_emple) then
		update usuario set nom_usuario=nom_emple, ape_usuario=ape_emple, dni=dni_emple,
        telefono=telef, distrito=distr, estado=estado_emple where id_usuario=id_emple;
    else
		insert into usuario values(id_emple,nom_emple,ape_emple,dni_emple,fech_nac,'',mail,telef,distr,estado_emple);
    end if;
end;

delimiter 
create procedure sp_regis_construccion(
pagina_rec varchar(50),
url_pag varchar(100),
nombre varchar(50),
etapa varchar(30),
ubicacion varchar(40),
direccion varchar(50),
tipo varchar(20),
tamaño varchar(20),
fecha_culm date,
financ varchar(20),
constructora varchar(50),
estado varchar(20))
begin
	declare id_const varchar(10);
    set id_const = (select max(substring_index(id_const,'-',-1))+1 from construccion);
	insert into construccion values(id_const,pagina_rec,url_pag,nombre,etapa,ubicacion,direccion,tipo,tamaño,fecha_culm,financ,constructora,'','',estado);
end;

delimiter 
create procedure sp_autogenerar_id_construc()
begin
    declare contador int;
	set contador = (select max(substring_index(id_const,'-',-1))+1 from construccion);
    if contador > 0 then
		select concat('CT-',contador) as id_const;
    else
		select 'CT-1000000' as id_const; 
    end if;
end;

delimiter 
create procedure sp_autogenerar_id_const()
begin
    declare contador int;
	set contador = (select max(substring_index(id_const,'-',-1))+1 from construc_pub);
    if contador > 0 then
		select concat('CT-',contador) as id_const;
    else
		select 'CT-1000000' as id_const; 
    end if;
end;
call sp_autogenerar_id_const;

delimiter 
create procedure sp_regis_construc_priv(
id_const varchar(10),
pagina varchar(50),
url varchar(100),
nombre varchar(50),
etapa varchar(30),
ubicacion varchar(40),
direccion varchar(100),
tipo varchar(20),
tamaño varchar(40),
fecha_cul date,
financ varchar(200),
construc varchar(50),
coment varchar(100),
descrip varchar(3000),
estado varchar(20))
begin
	insert into construccion values(id_const,pagina,url,nombre,etapa,ubicacion,direccion,tipo,tamaño,fecha_cul,financ,construc,coment,descrip,estado);
end;

delimiter 
create procedure sp_regis_construc_pub(
id_const varchar(10),
codigo varchar(10),
entidad varchar(100),
etapa varchar(30),
modalidad varchar(50),
ubicacion varchar(50),
descrip varchar(500),
tipo varchar(30),
estado_o varchar(30),
presup varchar(20),
fecha_rec date,
estado varchar(30),
coment varchar(20))
begin
	insert into construc_pub values(id_const,codigo,entidad,etapa,modalidad,ubicacion,descrip,tipo,estado_o,presup,fecha_rec,estado,coment);
end;
drop procedure sp_regis_construc_priv;
delete from construc_pub where id_const!='';
delete from construccion where id_const!='';
select*from construc_pub;
select*from construccion;
drop procedure sp_regis_construc_pub;
call sp_regis_construc_pub('502','Casas','','Callao','Una construccion innovadora','Publica','Iniciada','S/. 650,220.00',curdate(),'Activo','')
