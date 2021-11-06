create database base_datos_constructoras2;
use base_datos_constructoras2;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Tipo_Rol`;
DROP TABLE IF EXISTS `Estado_Rol`;
DROP TABLE IF EXISTS `Usuario`;
DROP TABLE IF EXISTS `Ubicacion`;
DROP TABLE IF EXISTS `Organizacion`;
DROP TABLE IF EXISTS `Party`;
DROP TABLE IF EXISTS `Privilegios`;
DROP TABLE IF EXISTS `Construccion`;
DROP TABLE IF EXISTS `Seguimiento Usuario`;
DROP TABLE IF EXISTS `Rol_Persona`;
DROP TABLE IF EXISTS `Rol_Organizacion`;
DROP TABLE IF EXISTS `Tipo_Construccion`;
DROP TABLE IF EXISTS `Usuario_Construccion`;
DROP TABLE IF EXISTS `Estado_Construccion`;
DROP TABLE IF EXISTS `Party_Rol`;
DROP TABLE IF EXISTS `Persona`;
DROP TABLE IF EXISTS `Rol`;
DROP TABLE IF EXISTS `Llamata_Atencion`;
DROP TABLE IF EXISTS `Tipo_Seg`;
DROP TABLE IF EXISTS `Mecanismo_Contacto`;
DROP TABLE IF EXISTS `Tipo_Llamada`;
DROP TABLE IF EXISTS `Construccion_Publica`;
DROP TABLE IF EXISTS `Construccion_Privada`;
DROP TABLE IF EXISTS `Cargo`;
DROP TABLE IF EXISTS `Estado_Disponibilidad`;
DROP TABLE IF EXISTS `Tipo_Contacto`;
DROP TABLE IF EXISTS `Relacion_Party`;
DROP TABLE IF EXISTS `Reportes`;
DROP TABLE IF EXISTS `Tipo_Reporte`;
DROP TABLE IF EXISTS `Estado_Reporte`;
DROP TABLE IF EXISTS `Actualizaciones`;
DROP TABLE IF EXISTS `Tipo_Actualizacion`;
DROP TABLE IF EXISTS `Estado_Actualizacion`;
DROP TABLE IF EXISTS `Tipo_Usuario`;
DROP TABLE IF EXISTS `Tipo_Registro`;
DROP TABLE IF EXISTS `Medio_Envio`;
DROP TABLE IF EXISTS `Act_Privada`;
DROP TABLE IF EXISTS `Act_Publica`;
DROP TABLE IF EXISTS `Tipo_Edificacion`;
SET FOREIGN_KEY_CHECKS = 1;



CREATE TABLE `Estado_Rol` (
    `ID_ESTADO_ROL` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_ESTADO_ROL`)
);

create table estado_usuario(
	id_estado_usuario varchar(10),
	descripcion varchar(500),
    usuario_creacion varchar(10)
);

CREATE TABLE `Usuario` (
    `ID_USUARIO` VARCHAR(10) NOT NULL,
    `NICKNAME` VARCHAR(100) NOT NULL,
    `PASSWORD` VARCHAR(100) NOT NULL,
    `ID_PRIVILEGIO` VARCHAR(10) NOT NULL,
    `ID_PARTY` VARCHAR(10) NOT NULL,
    `ID_CARGO` VARCHAR(10) NOT NULL,
    `ID_TIPO_USUARIO` VARCHAR(10) NOT NULL,
    `COMENTARIO` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_USUARIO`)
);

CREATE TABLE `Ubicacion` (
    `ID_UBICACION` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_UBICACION`)
);

CREATE TABLE `Organizacion` (
    `ID_PARTY` VARCHAR(10) NOT NULL,
    `RUC` VARCHAR(11) NOT NULL,
    `NOMBRE` VARCHAR (500) NOT NULL,
    `GIRO` VARCHAR (500) NOT NULL,
    `DIRECCION` VARCHAR (500) NOT NULL,
    `FECHA_INICIO_OPERACIONES` DATE NOT NULL,
    PRIMARY KEY (`ID_PARTY`)
);

CREATE TABLE `Party` (
    `ID_PARTY` VARCHAR(10) NOT NULL,
    `TIPO_PARTY` VARCHAR(100) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_PARTY`)
);

CREATE TABLE `Privilegios` (
    `ID_PRIVILEGIO` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `ESCALA` NUMERIC(3,0) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_PRIVILEGIO`)
);

CREATE TABLE `Construccion` (
    `ID_CONSTRUCCION` VARCHAR(10) NOT NULL,
    `ID_TIPO_CONSTRUCCION` VARCHAR(10) NOT NULL,
    `ID_ESTADO_C` VARCHAR(10) NOT NULL,
    `ID_UBICACION` VARCHAR(10) NOT NULL,
    `ID_E_DISP` VARCHAR(10) NOT NULL,
    `ID_TIPO_REG` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (3000) NOT NULL,
    `FECHA_ACTUALIZACION` DATE NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    `Column3` INTEGER NOT NULL,
    PRIMARY KEY (`ID_CONSTRUCCION`)
);

CREATE TABLE `Seguimiento Usuario` (
    `ID_SEGUIMIENTO` VARCHAR(10) NOT NULL,
    `ID_USUARIO_V` VARCHAR(10) NOT NULL,
    `ID_USUARIO_C` VARCHAR(10) NOT NULL,
    `ID_TIPO_SEG` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_SEGUIMIENTO`)
);

CREATE TABLE `Rol_Persona` (
    `ID_ROL` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    PRIMARY KEY (`ID_ROL`)
);

CREATE TABLE `Rol_Organizacion` (
    `ID_ROL` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `Column1` INTEGER NOT NULL,
    PRIMARY KEY (`ID_ROL`)
);

CREATE TABLE `Tipo_Construccion` (
    `ID_TIPO_CONSTRUCCION` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_TIPO_CONSTRUCCION`)
);

CREATE TABLE `Usuario_Construccion` (
    `ID_USUARIO` VARCHAR(10) NOT NULL,
    `ID_CONSTRUCCION` VARCHAR(10) NOT NULL,
    `FECHA_INICIO` DATE NOT NULL,
    `ID_PARTY` VARCHAR(10) NOT NULL,
    `FECHA_ACTIVIDAD` DATE NOT NULL,
    `COMENTARIO` VARCHAR (500) NOT NULL,
    PRIMARY KEY (`ID_USUARIO`, `ID_CONSTRUCCION`, `FECHA_INICIO`)
);

CREATE TABLE `Estado_Construccion` (
    `ID_ESTADO_C` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_ESTADO_C`)
);

CREATE TABLE `Party_Rol` (
    `ID_PARTY` VARCHAR(10) NOT NULL,
    `ID_ROL` VARCHAR(10) NOT NULL,
    `ID_ESTADO_ROL` VARCHAR(10) NOT NULL,
    `FECHA_INICIO` DATE NOT NULL,
    `FECHA_FIN` DATE NOT NULL,
    PRIMARY KEY (`ID_PARTY`, `ID_ROL`)
);

CREATE TABLE `Persona` (
    `ID_PARTY` VARCHAR(10) NOT NULL,
    `DNI` VARCHAR(8) NOT NULL,
    `NOMBRE` VARCHAR (500) NOT NULL,
    `APELLIDO` VARCHAR (500) NOT NULL,
    `FECHA_NACIMIENTO` DATE NOT NULL,
    `SEXO` VARCHAR (500) NOT NULL,
    `DIRECCION` VARCHAR (500) NOT NULL,
    PRIMARY KEY (`ID_PARTY`)
);

CREATE TABLE `Rol` (
    `ID_ROL` VARCHAR(10) NOT NULL,
    `TIPO_ROL` VARCHAR(100) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_ROL`)
);

CREATE TABLE `Llamata_Atencion` (
    `ID_LLAMADA` VARCHAR(10) NOT NULL,
    `ID_SEGUIMIENTO` VARCHAR(10) NOT NULL,
    `ID_TIPO_LLAMADA` VARCHAR(10) NOT NULL,
    `RAZON` VARCHAR (500) NOT NULL,
    `FECHA_LLAMADA` DATE NOT NULL,
    PRIMARY KEY (`ID_LLAMADA`)
);

CREATE TABLE `Tipo_Seg` (
    `ID_TIPO_SEG` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_TIPO_SEG`)
);

CREATE TABLE `Mecanismo_Contacto` (
    `ID_PARTY` VARCHAR(10) NOT NULL,
    `ID_M_CONTACTO` VARCHAR(10) NOT NULL,
    `ID_TIPO_CONTACTO` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_INICIO` DATE NOT NULL,
    `FECHA_FIN` DATE NOT NULL,
    PRIMARY KEY (`ID_M_CONTACTO`)
);

CREATE TABLE `Tipo_Llamada` (
    `ID_TIPO_LLAMADA` VARCHAR(10) NOT NULL,
    `SEC` INTEGER NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `Column1` INTEGER NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_TIPO_LLAMADA`)
);

CREATE TABLE `Construccion_Publica` (
    `ID_CONSTRUCCION` VARCHAR(10) NOT NULL,
    `ENTIDAD` VARCHAR (500) NOT NULL,
    `COD_INFO_OBRAS` VARCHAR(300) NOT NULL,
    `DIRECCION` VARCHAR (500) NOT NULL,
    `MODALIDAD` VARCHAR (500) NOT NULL,
    `PRESUPUESTO` VARCHAR(500) NOT NULL,
    `ESTADO_OBRA` VARCHAR (500) NOT NULL,
    PRIMARY KEY (`ID_CONSTRUCCION`)
);

CREATE TABLE `Construccion_Privada` (
    `ID_CONSTRUCCION` VARCHAR(10) NOT NULL,
    `PAGINA` VARCHAR (500) NOT NULL,
    `URL` VARCHAR (500) NOT NULL,
    `ID_TIPO_EDIFICACION` VARCHAR(10) NOT NULL,
    `AREA_TOTAL` VARCHAR(500) NOT NULL,
    `AREA_TECHADA` VARCHAR (500) NOT NULL,
    `CONSTRUCTURA` VARCHAR (500) NOT NULL,
    `FINANCIAMIENTO` VARCHAR (500) NOT NULL,
    `DIRECCION` VARCHAR (500) NOT NULL,
    `Column2` INTEGER NOT NULL,
    `Column3` INTEGER NOT NULL,
    `Column1` INTEGER NOT NULL,
    PRIMARY KEY (`ID_CONSTRUCCION`)
);

CREATE TABLE `Cargo` (
    `ID_CARGO` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_CARGO`)
);

CREATE TABLE `Estado_Disponibilidad` (
    `ID_E_DISP` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_E_DISP`)
);

CREATE TABLE `Tipo_Contacto` (
    `ID_TIPO_CONTACTO` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_TIPO_CONTACTO`)
);

CREATE TABLE `Relacion_Party` (
    `ID_PARTY_M` VARCHAR(10) NOT NULL,
    `ID_ROL_M` VARCHAR(10) NOT NULL,
    `ID_PARTY_E` VARCHAR(10) NOT NULL,
    `ID_ROL_E` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_INICIO` DATE NOT NULL,
    `FECHA_FIN` DATE NOT NULL,
    PRIMARY KEY (`ID_PARTY_M`, `ID_ROL_M`, `ID_PARTY_E`, `ID_ROL_E`)
);

CREATE TABLE `Reportes` (
    `ID_REPORTE` VARCHAR(10) NOT NULL,
    `FILE` BLOB NOT NULL,
    `ID_TIPO_REPORTE` VARCHAR(10) NOT NULL,
    `ID_E_REPORTE` VARCHAR(10) NOT NULL,
    `ID_M_ENVIO` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `ID_USUARIO` VARCHAR(10) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    PRIMARY KEY (`ID_REPORTE`)
);

CREATE TABLE `Tipo_Reporte` (
    `ID_TIPO_REPORTE` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR(500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_TIPO_REPORTE`)
);

CREATE TABLE `Estado_Reporte` (
    `ID_E_REPORTE` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_E_REPORTE`)
);

CREATE TABLE `Actualizaciones` (
    `ID_ACTUALIZACION` VARCHAR(10) NOT NULL,
    `ID_USUARIO` VARCHAR(10) NOT NULL,
    `ID_TIPO_ACT` VARCHAR(10) NOT NULL,
    `ID_ESTADO_ACT` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    `FILE` BLOB NOT NULL,
    PRIMARY KEY (`ID_ACTUALIZACION`)
);

CREATE TABLE `Tipo_Actualizacion` (
    `ID_TIPO_ACT` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_TIPO_ACT`)
);

CREATE TABLE `Estado_Actualizacion` (
    `ID_ESTADO_ACT` VARCHAR(10) NOT NULL,
    `DESCRIPCION` INTEGER NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_ESTADO_ACT`)
);

CREATE TABLE `Tipo_Usuario` (
    `ID_TIPO_USUARIO` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_TIPO_USUARIO`)
);

CREATE TABLE `Tipo_Registro` (
    `ID_TIPO_REG` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_TIPO_REG`)
);

CREATE TABLE `Medio_Envio` (
    `ID_M_ENVIO` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR (500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID_M_ENVIO`)
);

CREATE TABLE `Act_Privada` (
    `ID_ACTUALIZACION` VARCHAR(10) NOT NULL,
    `URL` VARCHAR(500) NOT NULL,
    `PAGINA` VARCHAR(500) NOT NULL,
    PRIMARY KEY (`ID_ACTUALIZACION`)
);

CREATE TABLE `Act_Publica` (
    `ID_ACTUALIZACION` VARCHAR(10) NOT NULL,
    `COD_INFOBRAS` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`ID_ACTUALIZACION`)
);

CREATE TABLE `Tipo_Edificacion` (
    `ID_TIPO_EDIFICACION` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR(500) NOT NULL,
    `FECHA_CREACION` DATE NOT NULL,
    `USUARIO_CREACION` VARCHAR(10) NOT NULL,
     PRIMARY KEY (`ID_TIPO_EDIFICACION`)
);


ALTER TABLE `Usuario` ADD FOREIGN KEY (`ID_PRIVILEGIO`) REFERENCES `Privilegios`(`ID_PRIVILEGIO`);
ALTER TABLE `Usuario` ADD FOREIGN KEY (`ID_PARTY`) REFERENCES `Persona`(`ID_PARTY`);
ALTER TABLE `Usuario` ADD FOREIGN KEY (`ID_CARGO`) REFERENCES `Cargo`(`ID_CARGO`);
ALTER TABLE `Usuario` ADD FOREIGN KEY (`ID_TIPO_USUARIO`) REFERENCES `Tipo_Usuario`(`ID_TIPO_USUARIO`);
ALTER TABLE `Construccion` ADD FOREIGN KEY (`ID_UBICACION`) REFERENCES `Ubicacion`(`ID_UBICACION`);
ALTER TABLE `Construccion` ADD FOREIGN KEY (`ID_TIPO_CONSTRUCCION`) REFERENCES `Tipo_Construccion`(`ID_TIPO_CONSTRUCCION`);
ALTER TABLE `Construccion` ADD FOREIGN KEY (`ID_ESTADO_C`) REFERENCES `Estado_Construccion`(`ID_ESTADO_C`);
ALTER TABLE `Construccion` ADD FOREIGN KEY (`ID_E_DISP`) REFERENCES `Estado_Disponibilidad`(`ID_E_DISP`);
ALTER TABLE `Construccion` ADD FOREIGN KEY (`ID_TIPO_REG`) REFERENCES `Tipo_Registro`(`ID_TIPO_REG`);
ALTER TABLE `Seguimiento Usuario` ADD FOREIGN KEY (`ID_USUARIO_V`) REFERENCES `Usuario`(`ID_USUARIO`);
ALTER TABLE `Seguimiento Usuario` ADD FOREIGN KEY (`ID_USUARIO_C`) REFERENCES `Usuario`(`ID_USUARIO`);
ALTER TABLE `Seguimiento Usuario` ADD FOREIGN KEY (`ID_TIPO_SEG`) REFERENCES `Tipo_Seg`(`ID_TIPO_SEG`);
ALTER TABLE `Usuario_Construccion` ADD FOREIGN KEY (`ID_USUARIO`) REFERENCES `Usuario`(`ID_USUARIO`);
ALTER TABLE `Usuario_Construccion` ADD FOREIGN KEY (`ID_PARTY`) REFERENCES `Party`(`ID_PARTY`);
ALTER TABLE `Usuario_Construccion` ADD FOREIGN KEY (`ID_CONSTRUCCION`) REFERENCES `Construccion`(`ID_CONSTRUCCION`);
ALTER TABLE `Party_Rol` ADD FOREIGN KEY (`ID_ESTADO_ROL`) REFERENCES `Estado_Rol`(`ID_ESTADO_ROL`);
ALTER TABLE `Party_Rol` ADD FOREIGN KEY (`ID_PARTY`) REFERENCES `Party`(`ID_PARTY`);
ALTER TABLE `Party_Rol` ADD FOREIGN KEY (`ID_ROL`) REFERENCES `Rol`(`ID_ROL`);
ALTER TABLE `Llamata_Atencion` ADD FOREIGN KEY (`ID_SEGUIMIENTO`) REFERENCES `Seguimiento Usuario`(`ID_SEGUIMIENTO`);
ALTER TABLE `Llamata_Atencion` ADD FOREIGN KEY (`ID_TIPO_LLAMADA`) REFERENCES `Tipo_Llamada`(`ID_TIPO_LLAMADA`);
ALTER TABLE `Mecanismo_Contacto` ADD FOREIGN KEY (`ID_PARTY`) REFERENCES `Party`(`ID_PARTY`);
ALTER TABLE `Mecanismo_Contacto` ADD FOREIGN KEY (`ID_TIPO_CONTACTO`) REFERENCES `Tipo_Contacto`(`ID_TIPO_CONTACTO`);
ALTER TABLE `Construccion_Privada` ADD FOREIGN KEY (`ID_TIPO_EDIFICACION`) REFERENCES `Tipo_Edificacion`(`ID_TIPO_EDIFICACION`);
ALTER TABLE `Relacion_Party` ADD FOREIGN KEY (`ID_PARTY_M`, `ID_ROL_M`) REFERENCES `Party_Rol`(`ID_PARTY`,`ID_ROL`);
ALTER TABLE `Relacion_Party` ADD FOREIGN KEY (`ID_PARTY_E`, `ID_ROL_E`) REFERENCES `Party_Rol`(`ID_PARTY`,`ID_ROL`);
ALTER TABLE `Reportes` ADD FOREIGN KEY (`ID_USUARIO`) REFERENCES `Usuario`(`ID_USUARIO`);
ALTER TABLE `Reportes` ADD FOREIGN KEY (`ID_TIPO_REPORTE`) REFERENCES `Tipo_Reporte`(`ID_TIPO_REPORTE`);
ALTER TABLE `Reportes` ADD FOREIGN KEY (`ID_E_REPORTE`) REFERENCES `Estado_Reporte`(`ID_E_REPORTE`);

-- Insercion de registros --
INSERT INTO party VALUES ('PT-1000000','',curdate(),'USU-100000'),('PT-1000001','',curdate(),'USU-100000'),('PT-1000002','',curdate(),'USU-100000'),('PT-1000003','',curdate(),'USU-100000'),('PT-1000004','',curdate(),'USU-100000'),('PT-1000005','',curdate(),'USU-100000'),('PT-1000006','',curdate(),'USU-100000'),('PT-1000007','',curdate(),'USU-100000'),('PT-1000008','',curdate(),'USU-100000'),('PT-1000009','',curdate(),'USU-100000'),('PT-1000010','',curdate(),'USU-100000'),('PT-1000011','',curdate(),'USU-100000'),('PT-1000012','',curdate(),'USU-100000'),('PT-1000013','',curdate(),'USU-100000'),('PT-1000014','',curdate(),'USU-100000'),('PT-1000015','',curdate(),'USU-100000');
INSERT INTO privilegios VALUES ('PRI-100000','Gestionar ventas y entrevistas de contructoras',0,curdate(),'USU-100000');
INSERT cargo VALUES('CRG-100000',"Administrador",curdate(),''),('CRG-100001',"Secretaria",curdate(),''),('CRG-100002',"Analista de ventas",curdate(),''),('CRG-100003',"Vendedor",curdate(),'');
INSERT INTO tipo_usuario VALUES('TUSU-10000','',curdate(),''),('TUSU-10001','',curdate(),''),('TUSU-10002','',curdate(),'');
INSERT INTO persona VALUES ('PT-1000000','Anderson','Nilupu Ramirez','M','72387619','1998-05-02',''),('PT-1000001','Oscar','Lobaton','M','72387632','1998-05-01',''),('PT-1000002','Kevin','Aguilar','M','72387612','1998-05-03',''),('PT-1000003','Juan','Garibay','M','72387623','1998-05-12',''),('PT-1000004','Moises','Mamani','M','72387345','1998-05-21',''),('PT-1000005','Patrick','Huillca','M','72334361','1998-05-23',''),('PT-1000006','Fernando','Carrion','M','72323414','1998-05-12',''),('PT-1000007','Javier','Acunia','M','72382432','1998-05-23',1),('PT-1000008','Adrian','Carhuavilca','M','72387623','1998-05-12',''),('PT-1000009','Sebastian','Egoavil','M','73242123','1998-05-14',''),('PT-1000010','Kevin','Chirihuana','M','72342149','1998-05-04',''),('PT-1000011','Sthefanny','Calderon','F','74521564','2000-05-30',''),('PT-1000012','Vielka','Salas','F','74215354','1998-05-04',''),('PT-1000013','Margarita','Valencia','F','74215241','1999-07-01',''),('PT-1000014','Maura','Lovon','F','73654158','2000-05-01',''),('PT-1000015','Jhon','Gonzales','M','74521657','2000-04-01','');
INSERT INTO usuario VALUES ('USU-100000','anderson.anr.15@gmail.com','123456','PRI-100000','PT-1000000','CRG-100003','TUSU-10002','',curdate(),'');
INSERT INTO ubicacion VALUES (1,'Lima',curdate(),''),(2,'Amazonas',curdate(),''),(3,'Ancash',curdate(),''),(4,'Apurimac',curdate(),''),(5,'Arequipa',curdate(),''),(6,'Ayacucho',curdate(),''),(7,'Cajamarca',curdate(),''),(8,'Cusco',curdate(),''),(9,'Huancavelica',curdate(),''),(10,'Huanuco',curdate(),''),(11,'Ica',curdate(),''),(12,'Junín',curdate(),''),(13,'La Libertad',curdate(),''),(14,'Lambayeque',curdate(),''),(15,'Loreto',curdate(),''),(16,'Madre de Dios',curdate(),''),(17,'Moquegua',curdate(),''),(18,'Pasco',curdate(),''),(19,'Piura',curdate(),''),(20,'Puno',curdate(),''),(21,'San Martin',curdate(),''),(22,'Tacna',curdate(),''),(23,'Tumbes',curdate(),''),(24,'Ucayali',curdate(),''),(25,'No encontrado',curdate(),'');
INSERT INTO estado_construccion VALUES (1,'Activa',curdate(),''),(2,'Inactiva',curdate(),''),(3,'Vencida',curdate(),''),(4,'Duda',curdate(),''),(5,'NA',curdate(),'');
INSERT INTO estado_disponibilidad VALUES (1,'No visitado',curdate(),'USU-100000'),(2,'Marcado',curdate(),'USU-100000'),(3,'Visitado',curdate(),'USU-100000');
INSERT INTO tipo_construccion VALUES('1','Privada',curdate(),''),('2','Publica',curdate(),'');
INSERT INTO tipo_edificacion VALUES('1','Casa',curdate(),''),('2','Departamento',curdate(),''),('3','DUDA',curdate(),''),('4','Oficina',curdate(),''),('5','',curdate(),'');
INSERT INTO tipo_registro VALUES('1','Webscraping',curdate(),''),('2','Manual',curdate(),'');

INSERT INTO tipo_reporte VALUES ('REP-000001', 'PDF', '2021-05-04', 'USU-100000');
INSERT INTO tipo_reporte VALUES ('REP-000002', 'WhastAPP', '2021-05-04', 'USU-100000');
INSERT INTO tipo_reporte VALUES ('REP-000003', 'ZIP', '2021-05-04', 'USU-100000');

INSERT INTO tipo_llamada VALUES ('LLM-000001', '1', 'POSITIVA', '2021-07-05', 'USU-100000');
INSERT INTO tipo_llamada VALUES ('LLM-000002', '2', 'NEGATIVA', '2021-07-05', 'USU-100000');

INSERT INTO tipo_contacto VALUES ('CTC-000001', 'TELEFONO', '2021-07-11', 'USU-100000');
INSERT INTO tipo_contacto VALUES ('CTC-000002', 'CORREO', '2021-07-11', 'USU-100000');
INSERT INTO tipo_contacto VALUES ('CTC-000003', 'CELULAR', '2021-07-11', 'USU-100000');

INSERT INTO tipo_actualizacion VALUES ('ACT-000001', 'PUBLICAS', '2021-07-11', 'USU-100000');
INSERT INTO tipo_actualizacion VALUES ('ACT-000002', 'NEXO', '2021-07-11', 'USU-100000');
INSERT INTO tipo_actualizacion VALUES ('ACT-000003', 'PROPERATI', '2021-07-11', 'USU-100000');

INSERT INTO rol VALUES ('ROL-000001', 'PERSONA', '2021-07-11', 'USU-100000');
INSERT INTO rol VALUES ('ROL-000002', 'PERSONA', '2021-07-11', 'USU-100000');
INSERT INTO rol VALUES ('ROL-000003', 'PERSORNA', '2021-07-11', 'USU-100000');
INSERT INTO rol VALUES ('ROL-000004', 'ORGANIZACION', '2021-07-11', 'USU-100000');

INSERT INTO rol_persona VALUES ('ROL-000001', 'GENERENTE');
INSERT INTO rol_persona VALUES ('ROL-000002', 'VENDEDOR');
INSERT INTO rol_persona VALUES ('ROL-000003', 'ASISTENTE_VENTAS');

INSERT INTO rol_organizacion VALUES ('ROL-000004', 'CLIENTE');

INSERT INTO estado_reporte VALUES ('ERE-000001', 'REMITIDO', '2021-07-11', 'USU-100000');
INSERT INTO estado_reporte VALUES ('ERE-000002', 'COMPLETADO', '2021-07-11', 'USU-100000');
INSERT INTO estado_reporte VALUES ('ERE-000003', 'CANCELADO', '2021-07-11', 'USU-100000');
INSERT INTO estado_reporte VALUES ('ERE-000004', 'CREANDO', '2021-07-11', 'USU-100000');

INSERT INTO estado_rol VALUES ('ERO-000001', 'ACTIVO', '2021-07-11', 'USU-100000');
INSERT INTO estado_rol VALUES ('ERO-000002', 'CULMINADO', '2021-07-11', 'USU-100000');

INSERT INTO estado_actualizacion VALUES ('EAC-000001', 'COMPLETADO', '2021-07-11', 'USU-100000');
INSERT INTO estado_actualizacion VALUES ('EAC-000002', 'EN CURSO', '2021-07-11', 'USU-100000');
INSERT INTO estado_actualizacion VALUES ('EAC-000003', 'CANCELADA', '2021-07-11', 'USU-100000');



-- Procedimientos almacenados --
delimiter $$
create procedure sp_autogenerar_id_const()
begin
    declare contador int;
	set contador = (select max(substring_index(id_construccion,'-',-1))+1 from construccion);
    if contador > 0 then
		select concat('CT-',contador) as id_const;
    else
		select 'CT-1000000' as id_const; 
    end if;
end$$

delimiter $$;

delimiter $$
create procedure sp_listar_const_priv()
begin
	select c.id_construccion,c.nombre,cp.ubicacion,cp.direccion,te.descripcion as tipo_edificacion,
    cp.etapa,c.fecha_fin,cp.constructora,ec.descripcion as estado
    from construccion c join construccion_privada cp on c.id_construccion=cp.id_construccion
    join estado_construccion ec on c.id_estado_c=ec.id_estado_c
    join tipo_edificacion te on cp.id_tipo_edificacion=te.id_tipo_edificacion;
end$$
delimiter $$;

delimiter $$
create procedure sp_registrar_const_priv(
id_const varchar(10),
p_estado varchar(10),
tipo_reg varchar(10),
p_nombre varchar(500),
p_descr varchar(3000),
p_fecha_cul date,
p_id_usuario varchar(10),
p_pagina varchar(500),
p_url varchar(500),
p_tipo_edif varchar(10),
p_area_total varchar(500),
p_area_techada varchar(500),
p_constructora varchar(500),
p_financ varchar(500),
p_ubicacion varchar(100),
p_direccion varchar(500),
p_etapa varchar(500))
begin
	declare cod_const varchar(10);
    declare tipo_edif varchar(10);
	if exists(select url from construccion_privada where url=p_url) then
		set cod_const = (select id_construccion from construccion_privada where url=p_url);
        update construccion set id_estado_c=p_estado,fecha_actualizacion=curdate(),fecha_fin=p_fecha_cul
        where id_construccion=cod_const;
		update construccion_privada set etapa=p_etapa
        where id_construccion=cod_const;
    else
        set tipo_edif =(select id_tipo_edificacion from tipo_edificacion where id_tipo_edificacion=p_tipo_edif);
		insert into construccion values(id_const,'1',p_estado,'25','1',tipo_reg,p_nombre,p_descr,null,curdate(),p_fecha_cul,p_id_usuario);
		insert into construccion_privada values(id_const,p_pagina,p_url,tipo_edif,p_area_total,p_area_techada,p_constructora,p_financ,p_ubicacion,p_direccion,p_etapa);
	end if;
end$$
delimiter $$;

delimiter $$
create procedure sp_buscar_const_priv(
id_const varchar(10))
begin
	select c.id_construccion,c.nombre,cp.ubicacion,cp.direccion,te.descripcion as tipo_edificacion,
    cp.etapa,c.fecha_fin,cp.constructora,ec.descripcion as estado,c.descripcion,cp.financiamiento
    from construccion c join construccion_privada cp on c.id_construccion=cp.id_construccion
    join estado_construccion ec on c.id_estado_c=ec.id_estado_c
    join tipo_edificacion te on cp.id_tipo_edificacion=te.id_tipo_edificacion
    where c.id_construccion=id_const;
end$$
delimiter $$;

delimiter $$
create procedure sp_listar_const_pub()
begin
	select c.id_construccion,cp.cod_info_obras,cp.entidad,u.descripcion as ubicacion,cp.presupuesto,cp.modalidad,ec.descripcion as estado
    from construccion c join construccion_publica cp on c.id_construccion=cp.id_construccion
    join estado_construccion ec on c.id_estado_c=ec.id_estado_c
    join ubicacion u on c.id_ubicacion=u.id_ubicacion;
end$$
delimiter $$;

delimiter $$
create procedure sp_registrar_const_pub(
id_const varchar(10),
p_estado varchar(10),
p_ubicacion varchar(50),
tipo_reg varchar(10),
p_descrip varchar(3000),
id_usuario varchar(10),
p_codigo varchar(300),
p_entidad varchar(500),
p_modalidad varchar(500),
p_presupuesto varchar(300),
p_estado_o varchar(500))
begin
	declare cod_const varchar(10);
    declare ubic varchar(500);
	if exists(select cod_info_obras from construccion_publica where cod_info_obras=p_codigo) then
		set cod_const = (select id_construccion from construccion_publica where cod_info_obras=p_codigo);
		update construccion set id_estado_c=p_estado,fecha_actualizacion=curdate() 
        where id_construccion=cod_const;
        update construccion_publica set estado_obra=p_estado_o 
        where id_construccion=cod_const and cod_info_obras=p_codigo;
    else
		set ubic = (select id_ubicacion from ubicacion where descripcion=p_ubicacion);
        if ubic is null then
			set ubic = '25';
		end if;
		insert into construccion values(id_const,'2',p_estado,ubic,'1',tipo_reg,'',p_descrip,null,curdate(),null,id_usuario);
		insert into construccion_publica values(id_const,p_entidad,p_codigo,'',p_modalidad,p_presupuesto,p_estado_o);
	end if;
end$$
delimiter $$;

delimiter $$
create procedure sp_buscar_const_pub(
id_const varchar(10))
begin
	select c.id_construccion,cp.entidad,cp.cod_info_obras,c.id_ubicacion,c.descripcion,cp.presupuesto,
    cp.modalidad,cp.estado_obra,ec.descripcion as estado
    from construccion c join construccion_publica cp on c.id_construccion=cp.id_construccion
    join estado_construccion ec on c.id_estado_c=ec.id_estado_c
    where c.id_construccion=id_const;
end$$
delimiter $$;

delimiter $$
create procedure sp_listar_empleados()
begin
	select p.id_party,p.nombre,p.apellido,p.dni,p.fecha_nacimiento,mc.descripcion as email,
    mc.descripcion as telefono,er.descripcion as estado 
    from persona p join party pa on p.id_party=pa.id_party
    join party_rol pr on pa.id_party=pr.id_party
    join estado_rol er on pr.id_estado_rol=er.id_estado_rol
    join mecanismo_contacto mc on pa.id_party=mc.id_party;
end$$
delimiter $$;
call sp_listar_empleados;

insert into party_rol values('PT-1000000','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000001','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000002','ROL-000001','ERO-000002',curdate(),null);
insert into party_rol values('PT-1000003','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000004','ROL-000001','ERO-000002',curdate(),null);
insert into party_rol values('PT-1000005','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000006','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000007','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000008','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000009','ROL-000001','ERO-000002',curdate(),null);
insert into party_rol values('PT-1000010','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000011','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000012','ROL-000001','ERO-000002',curdate(),null);
insert into party_rol values('PT-1000013','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000014','ROL-000001','ERO-000001',curdate(),null);
insert into party_rol values('PT-1000015','ROL-000001','ERO-000001',curdate(),null);

insert into mecanismo_contacto values('PT-1000000','MC-1000000','CTC-000002','anderson.nilupu.r@uni.pe',curdate(),null);
insert into mecanismo_contacto values('PT-1000000','MC-1000001','CTC-000003','972604932',curdate(),null);

delimiter $$
CREATE PROCEDURE SP_AU_AUTOGENERAR_ID_M_CONTACTO(P_PARAMETER VARCHAR(10))
BEGIN
	DECLARE CONTADOR INT;
	SET CONTADOR = (SELECT COALESCE(MAX(SUBSTRING_INDEX(ID_M_CONTACTO,'-',-1))+1,0)  FROM MECANISMO_CONTACTO);
    IF CONTADOR > 0 THEN
		SELECT CONCAT(P_PARAMETER,CONTADOR) AS ID_CONST;
    ELSE
		SELECT CONCAT(P_PARAMETER,'1000000') AS ID_CONST;
    END IF;
END$$
delimiter $$;

delimiter $$
CREATE PROCEDURE SP_AU_AUTOGENERAR_ID_PARTY(P_PARAMETER VARCHAR(10))
BEGIN
	DECLARE CONTADOR INT;
	SET CONTADOR = (SELECT COALESCE(MAX(SUBSTRING_INDEX(ID_PARTY,'-',-1))+1,0) FROM PARTY);
    IF CONTADOR > 0 THEN
		SELECT CONCAT(P_PARAMETER,CONTADOR) AS ID_CONST;
    ELSE	
		SELECT CONCAT(P_PARAMETER,'1000000') AS ID_CONST;
    END IF;
END$$
delimiter $$;

delimiter $$
CREATE PROCEDURE SP_AU_ELIM_USER(ID_USUARIO VARCHAR(10))
BEGIN
	DECLARE ID_PARTY VARCHAR(10);
    DECLARE ID_ESTADO_USUARIO VARCHAR(10);
    DECLARE ESTADO VARCHAR(10);
    set id_party = (SELECT U.ID_PARTY FROM USUARIO U WHERE U.ID_USUARIO = ID_USUARIO);
    set id_estado_usuario= (SELECT EU.ID_ESTADO_USUARIO 
    FROM ESTADO_USUARIO EU INNER JOIN USUARIO U2 
		WHERE U2.ID_USUARIO = ID_USUARIO AND EU.ID_ESTADO_USUARIO = U2.ID_ESTADO_USUARIO);
    SET ESTADO = STRCMP(ID_ESTADO_USUARIO,'EUS-000001');
    CASE ESTADO
	WHEN 0 THEN
		UPDATE USUARIO U3 SET U3.ID_ESTADO_USUARIO = 'EUS-000002',U3.DESCRIPCION = 'ELIMINADO',U3.FECHA_CREACION = CURDATE();
       	ELSE
		DELETE FROM USUARIO_CONSTRUCCION UC
		WHERE UC.ID_USUARIO = ID_USUARIO;
		DELETE APRIV.* FROM ACT_PRIVADA APRIV INNER JOIN ACTUALIZACIONES ACT ON APRIV.ID_ACTUALIZACION = ACT.ID_ACTUALIZACION
        WHERE ACT.ID_USUARIO = ID_USUARIO;
        DELETE APUB.* FROM ACT_PUBLICA APUB INNER JOIN ACTUALIZACIONES ACT2 ON    
        APUB.ID_ACTUALIZACION = ACT2.ID_ACTUALIZACION
        WHERE ACT2.ID_USUARIO = ID_USUARIO;
		DELETE FROM ACTUALIZACIONES ACT3
        WHERE ACT3.ID_USUARIO = ID_USUARIO;
        DELETE FROM REPORTES RP
        WHERE RP.ID_USUARIO = ID_USUARIO;
        DELETE FROM SEGUIMIENTO_USUARIO SU
        WHERE SU.ID_USUARIO_V = ID_USUARIO;
        DELETE FROM USUARIO U4
        WHERE U4.ID_USUARIO = ID_USUARIO;
      END CASE;
END$$
delimiter $$

delimiter $$
CREATE PROCEDURE SP_AU_MOD_USER(
	ID_PARTY VARCHAR(10),TIPO_ROL VARCHAR(100),ID_ESTADO_ROL VARCHAR(10),DESCRIPCION_TIPO_CONTACTO VARCHAR(500),DESCRIPCION_M_CONTACTO VARCHAR(500),  DNI VARCHAR(8), NOMBRE VARCHAR(500), APELLIDO VARCHAR(500), FECHA_NACIMIENTO DATE,  SEXO VARCHAR(500),    DIRECCION VARCHAR(500), ID_USUARIO VARCHAR(10),    NICKNAME VARCHAR(100), TIPO_ROL VARCHAR(1), CONTRASENIA VARCHAR(100),    ID_PRIVILEGIO VARCHAR(10), TIPO_USUARIO VARCHAR(500),    CARGO VARCHAR(500), COMENTARIO_USUARIO VARCHAR(500),    USUARIO_CREACION VARCHAR(10) )
BEGIN
    DECLARE ID_ROL VARCHAR(10);
    DECLARE ID_TIPO_CONTACTO VARCHAR(10);
    DECLARE ID_M_CONTACTO VARCHAR(10) DEFAULT 
(SELECT ID_M_CONTACTO FROM MECANISMO_CONTACTO MC1 
WHERE MC1.DESCRIPCION = DESCRIPCION_M_CONTACTO);
    DECLARE ID_TIPO_USUARIO VARCHAR(10);
    DECLARE ID_CARGO VARCHAR(10);
    
    SET ID_ROL = F_AU_BUSCAR_ROL(TIPO_ROL);
    SET ID_TIPO_CONTACTO = execute F_AU_BUSCAR_TIPO_CONTACTO(TIPO_CONTACTO);
    SET ID_TIPO_USUARIO = execute F_AU_BUSCAR_TIPO_USUARIO(TIPO_USUARIO);
    SET ID_CARGO = F_AU_BUSCAR_CARGO(CARGO);

delimiter $$
create procedure sp_suma(
n1 int,
n2 int)
begin
	select (n1+n2) as resultado;
end$$;
delimiter $$

delimiter $$
UPDATE PARTY_ROL PR SET PR.ID_ROL = ID_ROL, PR.ID_ESTADO_ROL = ID_ESTADO_
ROL,PR.FECHA_INICIO = CURDATE()
	WHERE PR.ID_PARTY = ID_PARTY;
	UPDATE MECANISMO_CONTACTO MC SET MC.ID_M_CONTACTO = ID_M_CONTACTO,
  	  MC_ID_ESTADO_ROL = ID_ESTADO_ROL,MC_FECHA_INICO = CURDATE()
	WHERE MC.ID_PARTY = ID_PARTY;
    
    UPDATE PERSONA PER SET PER.DNI = DNI, PER.NOMBRE = NOMBRE,PER.APELLIDO = APELLIDO,
    PER.FECHA_NACIMIENTO = FECHA_NACIMIENTO, PER.SEXO = SEXO, PER.DIRECCION = DIRECCION
    WHERE PER.ID_PARTY = ID_PARTY;
    
    UPDATE USUARIO US SET US.NICKNAME = NICKNAME,US.CONTRASENIA = CONTRASENIA,
US.ID_PRIVILEGIO = ID_PRIVILEGIO, US.ID_CARGO = ID_CARGO, US.ID_TIPO_USUARIO =   ID_TIPO_USUARIO, US.COMENTARIO = COMENTARIO_USUARIO, US.FECHA_CREACION = CURDATE(),
    US.USUARIO_CREACION = USUARIO_CREACION
    WHERE US.ID_USUARIO = ID_USUARIO AND US.ID_PARTY = ID_PARTY
END
delimiter $$
