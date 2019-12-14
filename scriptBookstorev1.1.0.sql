/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     23/11/2019 20:00:30                          */
/*==============================================================*/

USE master;
drop database Bookstore;
GO

create database Bookstore
ON primary
  ( NAME='Bookstore_almacen',
    FILENAME=
       'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Bookstore\primario\Bookstore_almacen.mdf',
    SIZE=20MB,
    MAXSIZE=40MB,
    FILEGROWTH=10MB),
FILEGROUP Bookstore_Data
  ( NAME = 'Bookstore_ventas',
    FILENAME =
       'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Bookstore\secundario\Bookstore_ventas.ndf',
    SIZE = 10MB,
    MAXSIZE=20MB,
    FILEGROWTH=5MB),
  ( NAME = 'Bookstore_reportes',
    FILENAME =
       'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Bookstore\secundario\Bookstore_reportes.ndf',
    SIZE = 10MB,
    MAXSIZE=20MB,
    FILEGROWTH=5MB)
LOG ON
  ( NAME='Bookstore_log',
    FILENAME =
       'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Bookstore\logs\Bookstore_log.ldf',
    SIZE=10MB,
    MAXSIZE=30MB,
    FILEGROWTH=10MB);
go

USE Bookstore
GO
CREATE SCHEMA almacen AUTHORIZATION dbo
GO

USE Bookstore
GO
CREATE SCHEMA ventas AUTHORIZATION dbo
GO

USE Bookstore
GO
CREATE SCHEMA reportes AUTHORIZATION dbo
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DETALLE') and o.name = 'FK_DETALLE_CONTIENE_FACTURA')
alter table DETALLE
   drop constraint FK_DETALLE_CONTIENE_FACTURA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DETALLE') and o.name = 'FK_DETALLE_ESTA_EN_EDICIONL')
alter table DETALLE
   drop constraint FK_DETALLE_ESTA_EN_EDICIONL
go

use Bookstore

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('EDICIONLIBRO') and o.name = 'FK_EDICIONL_ESTA_EDICION')
alter table EDICIONLIBRO
   drop constraint FK_EDICIONL_ESTA_EDICION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('EDICIONLIBRO') and o.name = 'FK_EDICIONL_TIENE_LIBRO')
alter table EDICIONLIBRO
   drop constraint FK_EDICIONL_TIENE_LIBRO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FACTURA') and o.name = 'FK_FACTURA_REALIZA_CLIENTE')
alter table FACTURA
   drop constraint FK_FACTURA_REALIZA_CLIENTE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LIBROAUTOR') and o.name = 'FK_LIBROAUT_ESCRIBE_AUTOR')
alter table LIBROAUTOR
   drop constraint FK_LIBROAUT_ESCRIBE_AUTOR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LIBROAUTOR') and o.name = 'FK_LIBROAUT_ESCRITO_LIBRO')
alter table LIBROAUTOR
   drop constraint FK_LIBROAUT_ESCRITO_LIBRO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTOR')
            and   type = 'U')
   drop table AUTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENTE')
            and   type = 'U')
   drop table CLIENTE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DETALLE')
            and   name  = 'CONTIENE_FK'
            and   indid > 0
            and   indid < 255)
   drop index DETALLE.CONTIENE_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DETALLE')
            and   name  = 'ESTA_EN_FK'
            and   indid > 0
            and   indid < 255)
   drop index DETALLE.ESTA_EN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DETALLE')
            and   type = 'U')
   drop table DETALLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EDICION')
            and   type = 'U')
   drop table EDICION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('EDICIONLIBRO')
            and   name  = 'ESTA_FK'
            and   indid > 0
            and   indid < 255)
   drop index EDICIONLIBRO.ESTA_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('EDICIONLIBRO')
            and   name  = 'TIENE_FK'
            and   indid > 0
            and   indid < 255)
   drop index EDICIONLIBRO.TIENE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EDICIONLIBRO')
            and   type = 'U')
   drop table EDICIONLIBRO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FACTURA')
            and   name  = 'REALIZA_FK'
            and   indid > 0
            and   indid < 255)
   drop index FACTURA.REALIZA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FACTURA')
            and   type = 'U')
   drop table FACTURA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LIBRO')
            and   type = 'U')
   drop table LIBRO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('LIBROAUTOR')
            and   name  = 'ESCRITO_FK'
            and   indid > 0
            and   indid < 255)
   drop index LIBROAUTOR.ESCRITO_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('LIBROAUTOR')
            and   name  = 'ESCRIBE_FK'
            and   indid > 0
            and   indid < 255)
   drop index LIBROAUTOR.ESCRIBE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LIBROAUTOR')
            and   type = 'U')
   drop table LIBROAUTOR
go

use Bookstore

/*==============================================================*/
/* Table: AUTOR                                                 */
/*==============================================================*/
create table almacen.AUTOR (
   IDAUTOR              int                  not null,
   NOMBRE               char(256)            not null,
   APELLIDO             char(256)            not null,
   FECHANACIMIENTO      datetime             null,
   --constraint PK_AUTOR primary key (IDAUTOR)
)
go

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table ventas.CLIENTE (
   IDCLIENTE            int                  not null,
   CEDULA               char(256)            not null,
   NOMBRE               char(256)            not null,
   APELLIDO             char(256)            not null,
   LIMITECREDITO		numeric(8,2)		 null,
   GARANTE				int					 null,
   --constraint PK_CLIENTE primary key (IDCLIENTE)
)
on Bookstore_Data
go

/*==============================================================*/
/* Table: DETALLE                                               */
/*==============================================================*/
create table ventas.DETALLE (
   IDDETALLE            int                  not null,
   IDLIBROEDICION       int                  null,
   IDFACTURA            int                  null,
   CANTIDAD              int                  not null,
   PRECIO               float                null,
   --constraint PK_DETALLE primary key (IDDETALLE)
)
on Bookstore_Data
go

/*==============================================================*/
/* Index: ESTA_EN_FK                                            */
/*==============================================================*/




/*create nonclustered index ESTA_EN_FK on DETALLE (IDLIBROEDICION ASC)
go*/

/*==============================================================*/
/* Index: CONTIENE_FK                                           */
/*==============================================================*/




/*create nonclustered index CONTIENE_FK on DETALLE (IDFACTURA ASC)
go*/

/*==============================================================*/
/* Table: EDICION                                               */
/*==============================================================*/
create table almacen.EDICION (
   IDEDICION            int                  not null,
   NOMBRE               char(256)            not null,
   ANIO                  int                  not null,
   --constraint PK_EDICION primary key (IDEDICION)
)
go

/*==============================================================*/
/* Table: EDICIONLIBRO                                          */
/*==============================================================*/
create table almacen.EDICIONLIBRO (
   IDLIBROEDICION       int                  not null,
   IDLIBRO              int                  null,
   IDEDICION            int                  null,
   PRECIO               float                not null,
   --constraint PK_EDICIONLIBRO primary key (IDLIBROEDICION)
)
go

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/




/*create nonclustered index TIENE_FK on EDICIONLIBRO (IDLIBRO ASC)
go*/

/*==============================================================*/
/* Index: ESTA_FK                                               */
/*==============================================================*/




/*create nonclustered index ESTA_FK on EDICIONLIBRO (IDEDICION ASC)
go*/

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table ventas.FACTURA (
   IDFACTURA            int                  not null,
   IDCLIENTE            int                  null,
   FECHA                datetime             not null,
   TIPOFAC				varchar(10)			 not null,
   MONTOTOTAL           numeric(8,2)         null,
   --constraint PK_FACTURA primary key (IDFACTURA)
)
on Bookstore_Data
go

/*==============================================================*/
/* Index: REALIZA_FK                                            */
/*==============================================================*/




/*create nonclustered index REALIZA_FK on FACTURA (IDCLIENTE ASC)
go*/

/*==============================================================*/
/* Table: LIBRO                                                 */
/*==============================================================*/
create table almacen.LIBRO (
   IDLIBRO              int                  not null,
   TITULO				char(256)			not null,
   ISBN                 char(256)            not null,
   IDIOMA               char(256)            not null,
   TIPO                 char(256)            not null,
   --constraint PK_LIBRO primary key (IDLIBRO)
)
go

/*==============================================================*/
/* Table: LIBROAUTOR                                            */
/*==============================================================*/
create table almacen.LIBROAUTOR (
   IDLIBROAUTOR         int                  not null,
   IDAUTOR              int                  null,
   IDLIBRO              int                  null,
   --constraint PK_LIBROAUTOR primary key (IDLIBROAUTOR)
)
go

create table ventas.DEUDOR (
   CODCLIENTE         int                  null,
   CODGARANTE         int                  null,
   LIMITECREDITO      numeric(8,2)         null,
   SALDODEUDOR		  numeric(8,2)		   null,
   --constraint PK_DEUDOR primary key (CODCLIENTE)
)
go

create table ventas.PAGOS (
   CODCLIENTE         int                  null,
   FECHAPAGO          datetime             null,
   VALORPAGO		  numeric(8,2)		   null,
   --constraint PK_DEUDOR primary key (CODCLIENTE)
)
go

create table almacen.LIBRO (
   IDLIBRO              int                  not null,
   TITULO				char(256)			not null,
   ISBN                 char(256)            not null,
   IDIOMA               char(256)            not null,
   TIPO                 char(256)            not null,
   --constraint PK_LIBRO primary key (IDLIBRO)
)
go

create table reportes.info_libros(
[CODLE] int,
[IDLIBRO] int,
[TITULO] char(256),
[ISBN] char(256),
[IDIOMA] char(256),
[TIPO] char(256),
[IDLIBROEDICION] int,
[IDEDICION] int,
[PRECIO] float
)
go

create table ventas.TARJETA (
   IDTARJETA         int                  not null,
   CODTARJETA        varchar(18)          not null,
   EMISOR			 varchar(80)          not null,
   FECHAVENCIMIENTO  date		          not null,
   CODSEGURIDAD		 varchar(3)		      not null,
   --constraint PK_TARJETA primary key (IDTARJETA)
)
go

create table ventas.TARJETACLIENTE (
   IDCOMPRA          int                  not null,
   IDTARJETA         int			      not null,
   TOTAL			 numeric(8,2)         not null,
   IDCLIENTE         int		          not null,
   --constraint PK_COMPRA primary key (IDCOMPRA)
)
go


--trigers


create trigger afterInsertLibro
on almacen.libro
AFTER INSERT, UPDATE
AS
IF (NOT EXISTS ( SELECT idlibro from reportes.info_libros where idlibro = 
	(select top 1 inserted.idlibro from inserted ) ))
BEGIN
insert into reportes.info_libros values( 
0,
(select top 1 inserted.idlibro from inserted),
(select top 1 inserted.titulo from inserted),
(select top 1 inserted.isbn from inserted),
(select top 1 inserted.idioma from inserted),
(select top 1 inserted.tipo from inserted),
(NULL),
(NULL),
(NULL))
END
go


create trigger afterInsertEdicionLibros
on almacen.edicionlibro
AFTER INSERT, UPDATE
AS
UPDATE reportes.info_libros
set
info_libros.idlibroedicion = (SELECT TOP 1 inserted.idlibroedicion FROM inserted),
info_libros.idedicion = (SELECT TOP 1 inserted.idedicion FROM inserted),
info_libros.precio = (SELECT TOP 1 inserted.precio FROM inserted)
WHERE
info_libros.idlibro = (SELECT TOP 1 inserted.idlibro FROM inserted)

GO


-- VICEVERSA

create trigger afterInsertReporteLibro
on reportes.info_libros
AFTER INSERT, UPDATE
as
IF (NOT EXISTS (select idlibro from almacen.libro where idlibro = 
	(select top 1 inserted.idlibro from inserted) ))
BEGIN
		insert into almacen.libro values(
		(select top 1 inserted.idlibro from inserted),
		(select top 1 inserted.titulo from inserted),
		(select top 1 inserted.isbn from inserted),
		(select top 1 inserted.idioma from inserted),
		(select top 1 inserted.tipo from inserted)
		)

		insert into almacen.edicionlibro values(
		(select top 1 inserted.idlibroedicion from inserted),
		(select top 1 inserted.idlibro from inserted),
		(select top 1 inserted.idedicion from inserted),
		(select top 1 inserted.precio from inserted)
		)
		end


GO


/*==============================================================*/
/* Index: ESCRIBE_FK                                            */
/*==============================================================*/




/*create nonclustered index ESCRIBE_FK on LIBROAUTOR (IDAUTOR ASC)
go*/

/*==============================================================*/
/* Index: ESCRITO_FK                                            */
/*==============================================================*/




/*create nonclustered index ESCRITO_FK on LIBROAUTOR (IDLIBRO ASC)
go

alter table DETALLE
   add constraint FK_DETALLE_CONTIENE_FACTURA foreign key (IDFACTURA)
      references FACTURA (IDFACTURA)
go

alter table DETALLE
   add constraint FK_DETALLE_ESTA_EN_EDICIONL foreign key (IDLIBROEDICION)
      references EDICIONLIBRO (IDLIBROEDICION)
go

alter table CLIENTE
   add constraint FK_GARANTE foreign key (GARANTE)
      references ventas.CLIENTE (IDCLIENTE)
go

alter table EDICIONLIBRO
   add constraint FK_EDICIONL_ESTA_EDICION foreign key (IDEDICION)
      references EDICION (IDEDICION)
go

alter table EDICIONLIBRO
   add constraint FK_EDICIONL_TIENE_LIBRO foreign key (IDLIBRO)
      references LIBRO (IDLIBRO)
go

alter table FACTURA
   add constraint FK_FACTURA_REALIZA_CLIENTE foreign key (IDCLIENTE)
      references CLIENTE (IDCLIENTE)
go

alter table LIBROAUTOR
   add constraint FK_LIBROAUT_ESCRIBE_AUTOR foreign key (IDAUTOR)
      references AUTOR (IDAUTOR)
go

alter table LIBROAUTOR
   add constraint FK_LIBROAUT_ESCRITO_LIBRO foreign key (IDLIBRO)
      references LIBRO (IDLIBRO)
go

alter table TARJETACLIENTE
   add constraint FK_IDCLIENTE foreign key (IDCLIENTE)
      references ventas.TARJETACLIENTE (IDCLIENTE)
go

alter table TARJETACLIENTE
   add constraint FK_IDTARJETA foreign key (IDTARJETA)
      references ventas.TARJETACLIENTE (IDTARJETA)
go
*/
