/*==============================================================*/
/* DBMS name:      ORACLE Version 19c                           */
/* Created on:     16/11/2024 13:13:00                          */
/*==============================================================*/

alter session set "_ORACLE_SCRIPT"=true;

alter table ELHOGARERP.COMPRA
   drop constraint FK_COMPRA_FK_COMPRA_PROVEEDO;

alter table ELHOGARERP.COMPRA
   drop constraint FK_COMPRA_FK_COMPRA_SUCURSAL;

alter table ELHOGARERP.COMPRA_DETALLE
   drop constraint FK_COMPRA_D_FK_DETALL_COMPRA;

alter table ELHOGARERP.COMPRA_DETALLE
   drop constraint FK_COMPRA_D_FK_DETALL_PRODUCTO;

alter table ELHOGARERP.COMPRA_DETALLE
   drop constraint FK_COMPRA_D_FK_DETALL_SUCURSAL;

alter table ELHOGARERP.INVENTARIO
   drop constraint FK_INVENTAR_FK_INVENT_PRODUCTO;

alter table ELHOGARERP.PRODUCTO
   drop constraint FK_PRODUCTO_FK_PRODUC_CATEGORI;

alter table ELHOGARERP.PROVEEDOR_PRODUCTO
   drop constraint FK_PROVEEDO_FK_PRODUC_PROVEEDO;

alter table ELHOGARERP.PROVEEDOR_PRODUCTO
   drop constraint FK_PROVEEDO_FK_PROVEE_PRODUCTO;

alter table ELHOGARERP.VENTA
   drop constraint FK_VENTA_FK_VENTA__SUCURSAL;

alter table ELHOGARERP.VENTA_DETALLE
   drop constraint FK_VENTA_DE_FK_DETALL_PRODUCTO;

alter table ELHOGARERP.VENTA_DETALLE
   drop constraint FK_VENTA_DE_FK_DETALL_VENTA;

drop table ELHOGARERP.CATEGORIA cascade constraints;

drop table ELHOGARERP.COMPRA cascade constraints;

drop table ELHOGARERP.COMPRA_DETALLE cascade constraints;

drop table ELHOGARERP.INVENTARIO cascade constraints;

drop table ELHOGARERP.PRODUCTO cascade constraints;

drop table ELHOGARERP.PROVEEDOR cascade constraints;

drop table ELHOGARERP.PROVEEDOR_PRODUCTO cascade constraints;

drop table ELHOGARERP.SUCURSAL cascade constraints;

drop table ELHOGARERP.VENTA cascade constraints;

drop table ELHOGARERP.VENTA_DETALLE cascade constraints;

drop user ELHOGARERP CASCADE;

/*==============================================================*/
/* User: ELHOGARERP                                             */
/*==============================================================*/

CREATE USER ELHOGARERP IDENTIFIED BY "qazwsx.."
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    PROFILE DEFAULT
    ACCOUNT UNLOCK
/
/*==============================================================*/
/* Table: CATEGORIA                                             */
/*==============================================================*/
create table ELHOGARERP.CATEGORIA (
   ID_CATEGORIA         INT                  not null,
   NOMBRE               CHAR(50)              not null,
   DESCRIPCION          CHAR(255)             not null,
   constraint PK_CATEGORIA primary key (ID_CATEGORIA)
);

/*==============================================================*/
/* Table: COMPRA                                                */
/*==============================================================*/
create table ELHOGARERP.COMPRA (
   ID_COMPRA            INT                  not null,
   ID_PROVEEDOR         INT                  not null,
   ID_SUCURSAL          INT                  not null,
   FECHA_SOLICITUD      DATE                  not null,
   FECHA_ENTREGA        DATE,
   FECHA_RECEPCION      DATE,
   TOTAL                NUMBER(16,4)          not null,
   DESCUENTO            NUMBER(16,4)          not null,
   IMPUESTOS            NUMBER(16,4)          not null,
   constraint PK_COMPRA primary key (ID_COMPRA, ID_PROVEEDOR, ID_SUCURSAL)
);

/*==============================================================*/
/* Table: COMPRA_DETALLE                                        */
/*==============================================================*/
create table ELHOGARERP.COMPRA_DETALLE (
   ID_DETALLE           INT                  not null,
   ID_COMPRA            INT                  not null,
   ID_PROVEEDOR         INT                  not null,
   ID_SUCURSAL          INT                  not null,
   ID_PRODUCTO          INT                  not null,
   CANTIDAD             NUMBER(16,4)          not null,
   PRECIO_UNITARIO      NUMBER(16,4)          not null,
   constraint PK_COMPRA_DETALLE primary key (ID_DETALLE, ID_COMPRA, ID_PRODUCTO)
);

/*==============================================================*/
/* Table: INVENTARIO                                            */
/*==============================================================*/
create table ELHOGARERP.INVENTARIO (
   ID_INVENTARIO        INT                  not null,
   ID_PRODUCTO          INT                  not null,
   ID_SUCURSAL          INT                  not null,
   CODIGO               CHAR(30)              not null,
   CANTIDAD             NUMBER(16,4)          not null,
   PRECIO_PROMEDIO      NUMBER(16,4),
   constraint PK_INVENTARIO primary key (ID_INVENTARIO)
);

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table ELHOGARERP.PRODUCTO (
   ID_PRODUCTO          INT                  not null,
   NOMBRE               CHAR(50)              not null,
   DESCRIPCION          CHAR(255)             not null,
   PRECIO               NUMBER(16,4)          not null,
   CANTIDAD_DISPONIBLE  NUMBER(16,4)          not null,
   ID_CATEGORIA         INT                  not null,
   constraint PK_PRODUCTO primary key (ID_PRODUCTO)
);

/*==============================================================*/
/* Table: PROVEEDOR                                             */
/*==============================================================*/
create table ELHOGARERP.PROVEEDOR (
   ID_PROVEEDOR         INT                  not null,
   NOMBRE               CHAR(50)              not null,
   CONTACTO             CHAR(50)              not null,
   TELEFONO             NUMBER(12)            not null,
   DIRECCION            CHAR(255)             not null,
   EMAIL                CHAR(255)             not null,
   constraint PK_PROVEEDOR primary key (ID_PROVEEDOR)
);

/*==============================================================*/
/* Table: PROVEEDOR_PRODUCTO                                    */
/*==============================================================*/
create table ELHOGARERP.PROVEEDOR_PRODUCTO (
   ID_PRODUCTO          INT                  not null,
   ID_PROVEEDOR         INT                  not null,
   PRECIO_PROMEDIO      NUMBER(16,4),
   CANTIDAD_PROMEDIO    NUMBER(16,4),
   constraint PK_PROVEEDOR_PRODUCTO primary key (ID_PRODUCTO, ID_PROVEEDOR)
);

/*==============================================================*/
/* Table: SUCURSAL                                              */
/*==============================================================*/
create table ELHOGARERP.SUCURSAL (
   ID_SUCURSAL          INT                  not null,
   NOMBRE               CHAR(50)              not null,
   DIRECCION            CHAR(255)             not null,
   CUIDAD               CHAR(30)              not null,
   TELEFONO             NUMBER(12)            not null,
   constraint PK_SUCURSAL primary key (ID_SUCURSAL)
);

/*==============================================================*/
/* Table: VENTA                                                 */
/*==============================================================*/
create table ELHOGARERP.VENTA (
   ID_VENTA             INT                  not null,
   ID_SUCURSAL          INT                  not null,
   FECHA                DATE                  not null,
   TOTAL                NUMBER(16,4),
   DESCUENTO_TOTAL      NUMBER(16,4),
   IMPUESTO_TOTAL       NUMBER(16,4),
   constraint PK_VENTA primary key (ID_VENTA, ID_SUCURSAL)
);

/*==============================================================*/
/* Table: VENTA_DETALLE                                         */
/*==============================================================*/
create table ELHOGARERP.VENTA_DETALLE (
   ID_DETALLE           INT                  not null,
   ID_VENTA             INT                  not null,
   ID_SUCURSAL          INT                  not null,
   ID_PRODUCTO          INT                  not null,
   CANTIDAD             NUMBER(16,4)          not null,
   PRECIO_UNITARIO      NUMBER(16,4)          not null,
   DESCUENTO_UNITARIO   NUMBER(16,4)          not null,
   IMPUESTO_UNITARIO    NUMBER(16,4)          not null,
   constraint PK_VENTA_DETALLE primary key (ID_DETALLE, ID_VENTA, ID_PRODUCTO)
);

alter table ELHOGARERP.COMPRA
   add constraint FK_COMPRA_FK_COMPRA_PROVEEDO foreign key (ID_PROVEEDOR)
      references ELHOGARERP.PROVEEDOR (ID_PROVEEDOR);

alter table ELHOGARERP.COMPRA
   add constraint FK_COMPRA_FK_COMPRA_SUCURSAL foreign key (ID_SUCURSAL)
      references ELHOGARERP.SUCURSAL (ID_SUCURSAL);

alter table ELHOGARERP.COMPRA_DETALLE
   add constraint FK_COMPRA_D_FK_DETALL_COMPRA foreign key (ID_COMPRA, ID_PROVEEDOR, ID_SUCURSAL)
      references ELHOGARERP.COMPRA (ID_COMPRA, ID_PROVEEDOR, ID_SUCURSAL);

alter table ELHOGARERP.COMPRA_DETALLE
   add constraint FK_COMPRA_D_FK_DETALL_PRODUCTO foreign key (ID_PRODUCTO)
      references ELHOGARERP.PRODUCTO (ID_PRODUCTO);

alter table ELHOGARERP.COMPRA_DETALLE
   add constraint FK_COMPRA_D_FK_DETALL_SUCURSAL foreign key (ID_SUCURSAL)
      references ELHOGARERP.SUCURSAL (ID_SUCURSAL);

alter table ELHOGARERP.INVENTARIO
   add constraint FK_INVENTAR_FK_INVENT_PRODUCTO foreign key (ID_PRODUCTO)
      references ELHOGARERP.PRODUCTO (ID_PRODUCTO);

alter table ELHOGARERP.PRODUCTO
   add constraint FK_PRODUCTO_FK_PRODUC_CATEGORI foreign key (ID_CATEGORIA)
      references ELHOGARERP.CATEGORIA (ID_CATEGORIA);

alter table ELHOGARERP.PROVEEDOR_PRODUCTO
   add constraint FK_PROVEEDO_FK_PRODUC_PROVEEDO foreign key (ID_PROVEEDOR)
      references ELHOGARERP.PROVEEDOR (ID_PROVEEDOR);

alter table ELHOGARERP.PROVEEDOR_PRODUCTO
   add constraint FK_PROVEEDO_FK_PROVEE_PRODUCTO foreign key (ID_PRODUCTO)
      references ELHOGARERP.PRODUCTO (ID_PRODUCTO);

alter table ELHOGARERP.VENTA
   add constraint FK_VENTA_FK_VENTA__SUCURSAL foreign key (ID_SUCURSAL)
      references ELHOGARERP.SUCURSAL (ID_SUCURSAL);

alter table ELHOGARERP.VENTA_DETALLE
   add constraint FK_VENTA_DE_FK_DETALL_PRODUCTO foreign key (ID_PRODUCTO)
      references ELHOGARERP.PRODUCTO (ID_PRODUCTO);

alter table ELHOGARERP.VENTA_DETALLE
   add constraint FK_VENTA_DE_FK_DETALL_VENTA foreign key (ID_VENTA, ID_SUCURSAL)
      references ELHOGARERP.VENTA (ID_VENTA, ID_SUCURSAL);

