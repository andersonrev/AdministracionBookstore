use Bookstore
alter table almacen.AUTOR
	add constraint PK_AUTOR primary key (IDAUTOR)
go

alter table almacen.EDICION
	add constraint PK_EDICION primary key (IDEDICION)
go

alter table almacen.EDICIONLIBRO
	add constraint PK_EDICIONLIBRO primary key (IDLIBROEDICION)
go

alter table almacen.LIBRO
	add constraint PK_LIBRO primary key (IDLIBRO)
go

alter table almacen.LIBROAUTOR
	add constraint PK_LIBROAUTOR primary key (IDLIBROAUTOR)
go

alter table ventas.CLIENTE
	add constraint PK_CLIENTE primary key (IDCLIENTE)
go

alter table ventas.DETALLE
	add constraint PK_DETALLE primary key (IDDETALLE)
go

alter table ventas.FACTURA
	add constraint PK_FACTURA primary key (IDFACTURA)
go

alter table ventas.TARJETA
	add constraint PK_TARJETA primary key (IDTARJETA)
go


alter table ventas.TARJETACLIENTE
	add constraint PK_COMPRA primary key (IDCOMPRA)
go




use Bookstore
alter table ventas.DETALLE
   add constraint FK_DETALLE_CONTIENE_FACTURA foreign key (IDFACTURA)
      references ventas.FACTURA (IDFACTURA)
go

alter table ventas.DETALLE
   add constraint FK_DETALLE_ESTA_EN_EDICIONL foreign key (IDLIBROEDICION)
      references almacen.EDICIONLIBRO (IDLIBROEDICION)
go

alter table ventas.CLIENTE
   add constraint FK_GARANTE foreign key (GARANTE)
      references ventas.CLIENTE (IDCLIENTE)
go

alter table almacen.EDICIONLIBRO
   add constraint FK_EDICIONL_ESTA_EDICION foreign key (IDEDICION)
      references almacen.EDICION (IDEDICION)
go

alter table almacen.EDICIONLIBRO
   add constraint FK_EDICIONL_TIENE_LIBRO foreign key (IDLIBRO)
      references alamcen.LIBRO (IDLIBRO)
go

alter table ventas.FACTURA
   add constraint FK_FACTURA_REALIZA_CLIENTE foreign key (IDCLIENTE)
      references ventas.CLIENTE (IDCLIENTE)
go

alter table almacen.LIBROAUTOR
   add constraint FK_LIBROAUT_ESCRIBE_AUTOR foreign key (IDAUTOR)
      references alamcen.AUTOR (IDAUTOR)
go

alter table almacen.LIBROAUTOR
   add constraint FK_LIBROAUT_ESCRITO_LIBRO foreign key (IDLIBRO)
      references almacen.LIBRO (IDLIBRO)
go

alter table ventas.TARJETACLIENTE
   add constraint FK_IDCLIENTE foreign key (IDCLIENTE)
      references ventas.CLIENTE (IDCLIENTE)
go

alter table ventas.TARJETACLIENTE
   add constraint FK_IDTARJETA foreign key (IDTARJETA)
      references ventas.TARJETA (IDTARJETA)
go
