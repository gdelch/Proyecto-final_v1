USE PROYECTO_FINAL_V1;


/*Esta función devuelve el monto total de ventas de un vendedor, ingresando su id_vendedor*/

DELIMITER //
CREATE FUNCTION total_ventas (p_id_vendedores INT) 
RETURNS FLOAT
NO SQL
BEGIN
DECLARE resultado FLOAT;
SET resultado = (SELECT SUM(f.cant_venta*p.precio_pub) total FROM facturas f
JOIN publicaciones p
ON f.publicacion_id=p.id_publicaciones
JOIN productos pro
ON p.producto_id=pro.id_productos
JOIN vendedores v
ON pro.vendedor_id=v.id_vendedores
WHERE v.id_vendedores = p_id_vendedores);
RETURN resultado;
END
//

/*Esta función devuelve el promedio del precio de las publicaciones, ingresando su categoria (vip,exclusive, premium, classic, economic,standard, )*/

DELIMITER //
CREATE FUNCTION promedio_categoria (p_categoria_exposicion VARCHAR(20)) 
RETURNS FLOAT
NO SQL
BEGIN
DECLARE resultado FLOAT;
SET resultado = (SELECT AVG(p.precio_pub) total FROM publicaciones p
JOIN exposiciones e
ON p.exposicion_id=e.id_exposiciones
WHERE e.categoria_exp = p_categoria_exposicion);
RETURN resultado;
END
//