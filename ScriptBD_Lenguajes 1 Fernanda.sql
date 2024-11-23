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

drop user ELHOGARERP;

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
   ID_SUCURSAL          CHAR(10)              not null,
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
   ID_PROVEEDOR         INT,
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
   add constraint FK_COMPRA_D_FK_DETALL_COMPRA foreign key (ID_COMPRA, ID_PROVEEDOR, )
      references ELHOGARERP.COMPRA (ID_COMPRA, ID_PROVEEDOR, ID_SUCURSAL);

alter table ELHOGARERP.COMPRA_DETALLE
   add constraint FK_COMPRA_D_FK_DETALL_PRODUCTO foreign key (ID_PRODUCTO)
      references ELHOGARERP.PRODUCTO (ID_PRODUCTO);

alter table ELHOGARERP.COMPRA_DETALLE
   add constraint FK_COMPRA_D_FK_DETALL_SUCURSAL foreign key ()
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
   add constraint FK_VENTA_DE_FK_DETALL_VENTA foreign key (ID_VENTA, )
      references ELHOGARERP.VENTA (ID_VENTA, ID_SUCURSAL);

/*==============================================================*/
/*  Funciones                                     */
/*==============================================================*/


/*==============================================================*/
/* Function: Calcular Total de Compra */
/*==============================================================*/
create or replace function ELHOGARERP.fn_calcular_total_compra (
    p_subtotal IN NUMBER,
    p_descuento IN NUMBER,
    p_iva IN NUMBER
) RETURN NUMBER AS
    v_total NUMBER;
BEGIN
    v_total := (p_subtotal - p_descuento) * (1 + p_iva / 100);
    RETURN v_total;
END;
/

/*==============================================================*/
/* Function: Verificar Stock Producto */
/*==============================================================*/
create or replace function ELHOGARERP.fn_verificar_stock_producto (
    p_id_producto IN INT
) RETURN BOOLEAN AS
    v_stock NUMBER;
BEGIN
    SELECT CANTIDAD
    INTO v_stock
    FROM ELHOGARERP.INVENTARIO
    WHERE ID_PRODUCTO = p_id_producto;
    
    IF v_stock > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/

/*==============================================================*/
/* Function: Calcular Descuento Producto */
/*==============================================================*/
create or replace function ELHOGARERP.fn_calcular_descuento_producto (
    p_precio_unitario IN NUMBER,
    p_descuento_porcentaje IN NUMBER
) RETURN NUMBER AS
    v_descuento NUMBER;
BEGIN
    v_descuento := p_precio_unitario * (p_descuento_porcentaje / 100);
    RETURN v_descuento;
END;
/

/*==============================================================*/
/* Function: Obtener Nombre Proveedor */
/*==============================================================*/
create or replace function ELHOGARERP.fn_obtener_nombre_proveedor (
    p_id_proveedor IN INT
) RETURN VARCHAR2 AS
    v_nombre_proveedor VARCHAR2(255);
BEGIN
    SELECT NOMBRE
    INTO v_nombre_proveedor
    FROM ELHOGARERP.PROVEEDOR
    WHERE ID_PROVEEDOR = p_id_proveedor;
    
    RETURN v_nombre_proveedor;
END;
/

/*==============================================================*/
/* Function: Formatear Fecha */
/*==============================================================*/
create or replace function ELHOGARERP.fn_formatear_fecha (
    p_fecha IN DATE
) RETURN VARCHAR2 AS
    v_fecha_formateada VARCHAR2(20);
BEGIN
    SELECT TO_CHAR(p_fecha, 'DD-MM-YYYY') 
    INTO v_fecha_formateada
    FROM DUAL;
    
    RETURN v_fecha_formateada;
END;
/


/*==============================================================*/
/* Triggers                                                     */
/*==============================================================*/


/*==============================================================*/
/* Trigger: Actualizar inventario cuando se realiza una venta */
/*==============================================================*/

create or replace trigger ELHOGARERP.TRG_ACTUALIZAR_INVENTARIO
AFTER INSERT ON ELHOGARERP.VENTA_DETALLE
FOR EACH ROW
BEGIN
    UPDATE ELHOGARERP.INVENTARIO
    SET CANTIDAD = CANTIDAD - :NEW.CANTIDAD
    WHERE ID_PRODUCTO = :NEW.ID_PRODUCTO;
END;
/

/*==============================================================*/
/* Trigger: Verificar stock antes de insertar venta */
/*==============================================================*/

create or replace trigger ELHOGARERP.TRG_VERIFICAR_STOCK
BEFORE INSERT ON ELHOGARERP.VENTA_DETALLE
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    SELECT CANTIDAD
    INTO v_stock
    FROM ELHOGARERP.INVENTARIO
    WHERE ID_PRODUCTO = :NEW.ID_PRODUCTO;
    
    IF v_stock < :NEW.CANTIDAD THEN
        RAISE_APPLICATION_ERROR(-20001, 'No hay suficiente stock para el producto');
    END IF;
END;
/

    
 /*==============================================================*/
/* Procedimientos almacenados para Ventas                               */
/*==============================================================*/


/*==============================================================*/
/* SP1: Consultar por id */
/*==============================================================*/

create or replace procedure ELHOGARERP.SP_Consultar_Venta_By_Id (
    p_id_venta IN INT,
    p_id_sucursal IN INT,
    p_fecha OUT DATE,
    p_total OUT NUMBER,
    p_descuento_total OUT NUMBER,
    p_impuesto_total OUT NUMBER
) AS
BEGIN
    SELECT FECHA, TOTAL, DESCUENTO_TOTAL, IMPUESTO_TOTAL
    INTO p_fecha, p_total, p_descuento_total, p_impuesto_total
    FROM ELHOGARERP.VENTA
    WHERE ID_VENTA = p_id_venta AND ID_SUCURSAL = p_id_sucursal;
END;
/
/*==============================================================*/
/* SP2: Agregar Venta */
/*==============================================================*/

create or replace procedure ELHOGARERP.SP_Agregar_Venta (
    p_id_venta IN INT,
    p_id_sucursal IN INT,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_descuento_total IN NUMBER,
    p_impuesto_total IN NUMBER
) AS
BEGIN
    INSERT INTO ELHOGARERP.VENTA (ID_VENTA, ID_SUCURSAL, FECHA, TOTAL, DESCUENTO_TOTAL, IMPUESTO_TOTAL)
    VALUES (p_id_venta, p_id_sucursal, p_fecha, p_total, p_descuento_total, p_impuesto_total);
END;
/

/*==============================================================*/
/* SP3: Eliminar Venta */
/*==============================================================*/

create or replace procedure ELHOGARERP.SP_Eliminar_Venta (
    p_id_venta IN INT,
    p_id_sucursal IN INT
) AS
BEGIN
    DELETE FROM ELHOGARERP.VENTA
    WHERE ID_VENTA = p_id_venta AND ID_SUCURSAL = p_id_sucursal;
END;
/
/*==============================================================*/
/* SP4: Actualizar Venta */
/*==============================================================*/

create or replace procedure ELHOGARERP.SP_Actualizar_Venta (
    p_id_venta IN INT,
    p_id_sucursal IN INT,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_descuento_total IN NUMBER,
    p_impuesto_total IN NUMBER
) AS
BEGIN
    UPDATE ELHOGARERP.VENTA
    SET FECHA = p_fecha,
        TOTAL = p_total,
        DESCUENTO_TOTAL = p_descuento_total,
        IMPUESTO_TOTAL = p_impuesto_total
    WHERE ID_VENTA = p_id_venta AND ID_SUCURSAL = p_id_sucursal;
END;
/
/*==============================================================*/
/* SP5: Consultar todas las Ventas */
/*==============================================================*/

create or replace procedure ELHOGARERP.SP_Consultar_Todas_Las_Ventas (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
    SELECT ID_VENTA, ID_SUCURSAL, FECHA, TOTAL, DESCUENTO_TOTAL, IMPUESTO_TOTAL
    FROM ELHOGARERP.VENTA;
END;
/

/*==============================================================*/
/* Vistas para reportes y consultas                             */
/*==============================================================*/

/*==============================================================*/
/* Vista: VENTAS_POR_SUCURSAL_FECHA                              */
/*==============================================================*/

create or replace view ELHOGARERP.VENTAS_POR_SUCURSAL_FECHA AS
SELECT 
    V.ID_VENTA,
    V.ID_SUCURSAL,
    S.NOMBRE AS SUCURSAL,
    V.FECHA,
    V.TOTAL,
    V.DESCUENTO_TOTAL,
    V.IMPUESTO_TOTAL
FROM 
    ELHOGARERP.VENTA V
JOIN 
    ELHOGARERP.SUCURSAL S ON V.ID_SUCURSAL = S.ID_SUCURSAL
WHERE
    V.FECHA BETWEEN :fecha_inicio AND :fecha_fin;


/*==============================================================*/
/* Vista: INVENTARIOS_POR_PRODUCTO                              */
/*==============================================================*/
create or replace view ELHOGARERP.INVENTARIOS_POR_PRODUCTO AS
SELECT 
    P.ID_PRODUCTO,
    P.NOMBRE AS NOMBRE_PRODUCTO,
    I.CANTIDAD,
    I.PRECIO_PROMEDIO,
    C.NOMBRE AS CATEGORIA
FROM 
    ELHOGARERP.INVENTARIO I
JOIN 
    ELHOGARERP.PRODUCTO P ON I.ID_PRODUCTO = P.ID_PRODUCTO
JOIN
    ELHOGARERP.CATEGORIA C ON P.ID_CATEGORIA = C.ID_CATEGORIA
ORDER BY 
    P.NOMBRE;

/*==============================================================*/
/* Vista: COMPRAS_POR_PROVEEDOR                                 */
/*==============================================================*/

create or replace view ELHOGARERP.COMPRAS_POR_PROVEEDOR AS
SELECT 
    C.ID_COMPRA,
    C.ID_PROVEEDOR,
    P.NOMBRE AS NOMBRE_PROVEEDOR,
    C.FECHA_SOLICITUD,
    C.FECHA_ENTREGA,
    C.TOTAL,
    C.DESCUENTO,
    C.IMPUESTOS
FROM 
    ELHOGARERP.COMPRA C
JOIN 
    ELHOGARERP.PROVEEDOR P ON C.ID_PROVEEDOR = P.ID_PROVEEDOR
ORDER BY 
    C.FECHA_SOLICITUD;
