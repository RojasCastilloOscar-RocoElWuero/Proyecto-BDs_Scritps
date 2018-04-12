
CREATE TABLE CLIENTE ( 
  IDCLIENTE     NUMBER(10,0) NOT NULL, --cantidad de digitos, decimales primary key
  NOMBRE        VARCHAR2 (20) NOT NULL,       
  APPPATERNO    VARCHAR2(20) NOT NULL,
  APPMATERNO    VARCHAR2(20),
  EMAIL         VARCHAR2(50) NOT NULL,
  RFC           VARCHAR2(13) NOT NULL,
  DIRECCION     VARCHAR2(50) NOT NULL,
  TELEFONO      NUMBER(10,0),NOT NULL,
  CONSTRAINT PKCLIENTE  PRIMARY KEY(IDCLIENTE)
);

CREATE TABLE COTIZACION(
  IDCOTIZACION NUMBER(10,0), --primary key
  FECHACOTIZACION DATE NOT NULL;
  CONSTRAINT FKMARCA FOREIGN KEY (IDMARCA) REFERENCES MARCA(IDMARCA),
  CONSTRAINT FKMODELO FOREIGN KEY (IDMODELO) REFERENCES MODELO(IDMODELO),
  CONSTRAINT FKESTADO FOREIGN KEY (IDESTADO) REFERENCES ESTADO(IDESTADO),
  CONSTRAINT FKTIPOSEGURO FOREIGN KEY (IDTIPOSEGURO) REFERENCES TIPOSEGURO(IDTIPOSEGURO),
  ANIOAUTO NUMBER(4,0),
  CODIGOPOSTAL NUMBER(5,0),
  EDADCONDUCTOR NUMBER(2,0),
  FECHANACIMIENTO DATE NOT NULL,
  CONSTRAINT PKCOT PRIMARY KEY(IDCOTIZACION)
);

CREATE TABLE TABULADOR(
IDTABULADOR NUMBER(10,0),
CONSTRAINT FKMARCA FOREIGN KEY (IDMARCA) REFERENCES MARCA(IDMARCA),
CONSTRAINT FKMODELO FOREIGN KEY (IDMODELO)REFERENCES MODELO(IDMODELO),
CONSTRAINT FKESTADO FOREIGN KEY (IDESTADO)REFERENCES ESTADO(IDESTADO),
CONSTRAINT FKTIPOSEGURO FOREIGN KEY (IDTIPOSEGURO)REFERENCES TIPOSEGURO(IDTIPOSEGURO),
CONSTRAINT FKCOTIZACION FOREIGN KEY (IDCOTIZACION)REFERENCES COTIZACION(IDCOTIZACION),
COSTOANUAL NUMBER(7,3), -- ?
CONSTRAINT PKTABULADOR PRIMARY KEY(IDTABULADOR) KEY NOT NULL
);

CREATE TABLE POLIZA(
FOLIO NUMBER(10,0) NOT NULL,
CONSTRAINT PKPOLIZA PRIMARY KEY (FOLIO),
CONSTRAINT FKCLIENTE FOREIGN KEY(IDCLIENTE) REFERENCES CLIENTE(IDCLIENTE),
FECHAINICIO DATE NOT NULL,
HORAINICIO NUMBER(2,0),-- VERIFICAR
FECHAFIN DATE NOT NULL,
PLACA VARCHAR(10) NOT NULL,
NUMEROSERIEAUTO NUMBER(20) NOT NULL,
CONSTRAINT FKPOLIZAANTERIOR FOREIGN KEY (FOLIO), --REFERENCES POLIZA (FOLIO)
CONSTRAINT FKSINIESTRO FOREIGN KEY(IDSINIESTRO) REFERENCES SINIESTRO(IDSINIESTRO),
CONSTRAINT FKCOTIZACION FOREIGN KEY (IDCOTIZACION) REFERENCES COTIZACION (IDCOTIZACION)
);

CREATE TABLE PAGOSEGURO(
IDPAGOSEGURO NUMBER(10,0) NOT NULL,
CONSTRAINT PKPAGOSEGURO PRIMARY KEY(IDPAGOSEGURO),
NUMEROTARJETA NUMBER(10,0) NOT NULL,
TIPOTARJETA VARCHAR2(20) NOT NULL,
MES VARCHAR(10),
ANIOEXPIRACION  NUMBER(4,0),
NUMEROSEGURIDAD NUMBER(10,0)
);

CREATE TABLE CATALOGO(
IDCATALOGO NUMBER(10,0),
CONSTRAINT PKCATALOGO PRIMARY KEY(IDCATALOGO),
TIPOCATALOGO VARCHAR2(10)
CONSTRAINT FKASEGURADORA FOREIGN KEY (IDASEGURADORA) REFERENCES(ASEGURADORA),
CONSTRAINT FKMARCA FOREIGN KEY (IDMARCA) REFERENCES MARCA(IDMARCA),
CONSTRAINT FKTIPOSEGURO FOREIGNKEY(IDTIPOSEGURO) REFERENCES TIPOSEGURO(IDTIPOSEGURO),
CONSTRAINT FKMODELO FOREIGN KEY (IDMODELO)REFERENCES MODELO(IDMODELO),
CONSTRAINT FKESTADO FOREIGN KEY (IDESTADO)REFERENCES ESTADO(IDESTADO),
);

CREATE TABLE ASEGURADORA(
IDASEGURADORA NUMBER(10,0),
DESCRIPCION VARCHAR2(100),
CONSTRAINT PKASEGURADORA PRIMARY KEY(IDASEGURADORA) 
CONSTRAINT FKAUTOIVOLUCRADO (IDAUTOINVOLUCRADO) REFERENCES AUTOINVOLUCRADO(IDAUTOINVOLUCRADO)
);

CREATE TABLE MARCAAUTO(
IDASEGURADORA NUMBER(10,0),
DESCRIPCION VARCHAR2(100),
CONSTRAINT PKASEGURADORA PRIMARY KEY(IDASEGURADORA) 
);

CREATE TABLE MODELOAUTO(
IDMODELOAUTO NUMBER(10,0),
DESCRIPCION VARCHAR2(100),
CONSTRAINT PKMODELO PRIMARY KEY(IDMODELOAUTO) 
);

CREATE TABLE ESTADO(
IDESTADO NUMBER(10,0),
NOMBRE VARCHAR2(100) NOT NULL,
CONSTRAINT PKESTADO PRIMARY KEY(IDESTADO) 
);

CREATE TABLE TIPOSEGURO(
IDTIPOSEGURO NUMBER(10,0),
DESCRIPCION VARCHAR2(100),
CONSTRAINT PKTIPOSEGURO PRIMARY KEY(IDTIPOSEGURO) 
);


CREATE TABLE SINIESTRO(
IDSINIESTRO NUMBER(10,0) NOT NULL,
CONSTRAINT PKSINIESTRO PRIMARY KEY(IDSINIESTRO),
FECHA DATE  NOT NULL,
HORA NUMBER(2,0),
DIRECCION VARCHAR(50) NOT NULL,
FOTO BLOB
CONSTRAINT FKCOLISION FOREIGN KEY (IDCOLISION) REFERENCES COLISION(IDCOLISION), --SE HACE UNA COLUMNA PARA CADA TIPO DE SINIESTRO, HAY ACCIDENTES QUE CABEN EN LAS 3 TABLAS
CONSTRAINT FKMATERIAL FOREIGN KEY (IDMATERIAL) REFERENCES MATERIAL(IDMATERIAL),
CONSTRAINT FKSOCIAL FOREIGN KEY (IDSOCIAL) REFERENCES SOCIAL(IDSOCIAL),
);

CREATE TABLE COLISION(
IDCOLISION NUMBER(10,0) NOT NULL,
CONSTRAINT PKCOLISION PRIMARY KEY (IDCOLISION),
NUMEROREPORTEVIAL NUMBER(20,0),
REQUIEREGRUA CHAR(1), --FLAG , NO HAY BOOLEAN , SE IMPLEMENTA CON Y / N, REVISAR
CONSTRAINT FKAUTOINVOLUCRADO FOREIGN KEY (IDAUTOINVOLUCRADO) REFERENCES AUTOINVOLUCRADO(IDAUTOINCOLUCRADO)
);

CREATE TABLE AUTOINVOLUCRADO(
IDAUTOINVOLUCRADO NUMBER(10,0),
CONSTRAINT PKAUTOINVOLUCRADO PRIMARY KEY(IDAUTOINVOLUCRADO),
MARCAINV VARCHAR2(20) NOT NULL, --INV DE INVOLUCRADO
MODELOINV VARCHAR(20) NOT NULL,
NUMEROSERIEINV NUMBER(20) NOT NULL,
NUMEROPOLIZAINV(20),
CONSTRAINT FKASEGURADORA FOREIGN KEY (IDASEGURADORA) REFERENCES ASEGURADORA(IDASEGURADORA)
);

CREATE TABLE MATERIAL(
IDMATERIAL NUMBER(10,0)  NOT NULL,
CONSTRAINT PKMATERIAL PRIMARY KEY (IDMATERIAL),
--CONSTRAINT FKAUTOINVOLUCRADO FOREIGN KEY(IDAUTOINVOLUCRADO) REFERENCES AUTOINVOLUCRADO (IDAUTOINVOLUCRADO),
--CONSTRAINT FKPERSONAINVOLUCRADA FOREIGN KEY(IDPERSONAINVOLUCRADA) REFERENCES PERSONAINVOLUCRADA(IDPERSONAINVOLUCRADA),
FOTO BLOB,
DESCRIPCION VARCHAR(200),
);

CREATE TABLE SOCIAL(
IDSOCIAL  NUMBER(10,0) NOT NULL,
REQUIEREAMBULANCIA CHAR(1), --FLAG BOOLEAN
NOMBREHOSPITAL VARCHAR2(30),
DIRECCIONHOSPITAL VARCHAR2(30),
CONSTRAINT FKPERSONAAFECTADA FOREIGN KEY (IDPERSONAAFECTADA) REFERENCES PERSONAAFECTADA (IDPERSONAAFECTADA)
);

CREATE TABLE PERSONAAFECTADA(
IDPERSONAAFECTADA NUMBER(10,1),
CONSTRAINT PKPERSONAAFECTADA PRIMARY KEY(IDPERSONAAFECTADA),
NOMBRECOMPLETO VARCHAR2(45) NOT NULL,
CURP VARCHAR2(20) NOT NULL,
DESCRIPCION VARCHAR2 (200),
);