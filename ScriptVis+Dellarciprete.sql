USE proyecto_final_v1;

/* Muestra top 3 de productos más vendidos*/

CREATE OR REPLACE VIEW vw_ranking_prodvendidos
AS
  SELECT pro.descripcion   AS Producto,
         Sum(f.cant_venta) AS Q
  FROM   facturas AS f
         JOIN publicaciones AS pub
           ON f.publicacion_id = pub.id_publicaciones
         JOIN productos AS pro
           ON pub.producto_id = pro.id_productos
  GROUP  BY producto
  ORDER  BY q DESC
  LIMIT  3; 

/* Muestra capital inmovilizado en deposito por categoria de producto*/

CREATE OR REPLACE VIEW vw_monto_categorias
AS
  SELECT c.descripcion_categoria      AS categoria,
         Sum(p.cant * p.precio_venta) AS monto_total
  FROM   productos AS p
         JOIN categorias AS c
           ON p.categoria_id = c.id_categorias
  GROUP  BY categoria
  ORDER  BY monto_total DESC; 

/* Muestra top 3 cantidad de publicaciones por tipo de exposición*/

CREATE OR REPLACE VIEW vw_top_exposicion
AS
  SELECT e.categoria_exp,
         Count(*) AS Q
  FROM   publicaciones AS P
         JOIN exposiciones AS E
           ON p.exposicion_id = e.id_exposiciones
  GROUP  BY e.categoria_exp
  ORDER  BY q DESC
  LIMIT  3; 


/* Muestra el capital inmovizilado en deposito de cada vendedor*/

CREATE OR REPLACE VIEW vw_capital_inmovilizado
AS
  SELECT v.razonsocial_vendedor       AS vendedor,
         Sum(p.precio_venta * p.cant) AS capital_inmovilizado
  FROM   productos AS p
         JOIN vendedores AS v
           ON p.vendedor_id = v.id_vendedores
  GROUP  BY razonsocial_vendedor
  ORDER  BY capital_inmovilizado DESC; 

/* Muestra monto de ventas por vendedor */

CREATE OR REPLACE VIEW vw_ventas_totales
AS
  SELECT v.razonsocial_vendedor             AS vendedor,
         Sum(f.cant_venta * pub.precio_pub) AS monto_total
  FROM   facturas AS f
         JOIN publicaciones AS pub
           ON f.publicacion_id = pub.id_publicaciones
         JOIN productos AS prod
           ON pub.producto_id = prod.id_productos
         JOIN vendedores AS v
           ON prod.vendedor_id = v.id_vendedores
  GROUP  BY vendedor
  ORDER  BY monto_total DESC;

/* Muestra el monto de ingresos por comisiones de venta por tipo de publicación */

CREATE OR REPLACE VIEW vw_ingresos_comisiones
AS
  SELECT e.categoria_exp,
         Sum(e.comision_exp * f.cant_venta) AS monto_comisiones
  FROM   facturas AS f
         JOIN publicaciones AS p
           ON f.publicacion_id = p.id_publicaciones
         JOIN exposiciones AS e
           ON p.exposicion_id = e.id_exposiciones
  GROUP  BY e.categoria_exp
  ORDER  BY monto_comisiones DESC; 
