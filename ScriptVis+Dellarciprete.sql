use proyecto_final_v1;

/* Muestra capital inmovilizado en deposito por categoria de producto*/

CREATE OR REPLACE VIEW monto_categorias AS
SELECT c.descripcion_categoria as categoria, sum(p.cant*p.precio_venta) as monto_total from productos as p 
JOIN categorias AS c
ON p.categoria_id=c.id_categorias
GROUP BY categoria
ORDER BY monto_total desc
;

/* Muestra top 3 cantidad de publicaciones por tipo de exposición*/

CREATE OR REPLACE VIEW top_exposicion AS
SELECT e.categoria_exp, count(*) as Q FROM publicaciones as P
JOIN exposiciones AS E
ON p.exposicion_id=e.id_exposiciones
group by e.categoria_exp
order by Q desc LIMIT 3
;


/* Muestra el capital inmovizilado en deposito de cada vendedor*/

CREATE OR REPLACE VIEW capital_inmovilizado AS
SELECT v.razonsocial_vendedor as vendedor, SUM(p.precio_venta * p.cant) as capital_inmovilizado from productos as p
JOIN vendedores as v
ON p.vendedor_id=v.id_vendedores
GROUP BY razonsocial_vendedor
order by capital_inmovilizado desc
;

/* Muestra monto de ventas por vendedor */

CREATE OR REPLACE VIEW ventas_totales AS
SELECT v.razonsocial_vendedor as vendedor, SUM(f.cant_venta*pub.precio_pub) as monto_total from facturas as f
JOIN publicaciones as pub
ON f.publicacion_id=pub.id_publicaciones
JOIN productos as prod
ON pub.producto_id=prod.id_productos
JOIN vendedores as v
ON prod.vendedor_id=v.id_vendedores
GROUP BY vendedor
order by monto_total desc
;

/* Muestra el monto de ingresos por comisiones de venta por tipo de publicación */

CREATE OR REPLACE VIEW ingresos_comisiones AS
SELECT e.categoria_exp, sum(e.comision_exp*f.cant_venta) as monto_comisiones from facturas as f
JOIN publicaciones as p
ON f.publicacion_id=p.id_publicaciones
JOIN exposiciones as e
ON p.exposicion_id=e.id_exposiciones
GROUP BY e.categoria_exp
order by monto_comisiones desc
;

/* Muestra monto de gastos por envios por cada empresa de transporte */
SELECT t.razonsocial_transporte as transportes, sum(f.cant_venta*z.tarifa_deliver) as monto_envios from facturas as f
JOIN ordenes_entrega as o
ON f.orden_id=o.id_ordenes
JOIN zonas_entrega as z
ON o.zona_id=z.id_zonas
JOIN transportes as t
ON z.transporte_id=t.id_transportes
group by transportes
order by monto_envios desc
;


