CREATE SCHEMA proyecto_final_v1;
USE proyecto_final_v1; 

CREATE TABLE rubros(
  id_rubros INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descripcion_rubro VARCHAR(30) NOT NULL
  );

CREATE TABLE categorias(
  id_categorias INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descripcion_categoria VARCHAR(30) NOT NULL
  );

CREATE TABLE monedas(
  id_monedas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  simbolo_monedas CHAR(11) NOT NULL, 
  descripcion_monedas VARCHAR(30) NOT NULL
  );

CREATE TABLE paises(
  id_paises INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  simbolo_paises CHAR(11) NOT NULL, 
  descripcion_paises VARCHAR(30) NOT NULL,
  moneda_id INT NOT NULL,
  FOREIGN KEY (moneda_id) REFERENCES monedas(id_monedas)
  );


CREATE TABLE vendedores(
  id_vendedores INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  razonsocial_vendedor VARCHAR(20) NOT NULL,
  cuit_vendedor CHAR(11) NOT NULL,
  rubro_id INT NOT NULL,
  direccion_vendedor VARCHAR(30) NOT NULL, 
  cp_vendedor CHAR(4) NOT NULL,
  telefono_vendedor VARCHAR(30), 
  email_vendedor VARCHAR(30), 
  reputacion VARCHAR(20),
  FOREIGN KEY (rubro_id) REFERENCES rubros(id_rubros))
  ;


  
  CREATE TABLE productos(
  id_productos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descripcion VARCHAR(50) NOT NULL,
  cant INT NOT NULL,
  fecha_ingreso DATE,
  precio_venta DECIMAL(10,2) NOT NULL, 
  tamano_producto CHAR(4) NOT NULL,
  categoria_id INT NOT NULL,
  vendedor_id INT,
  FOREIGN KEY (vendedor_id) REFERENCES vendedores(id_vendedores),
  FOREIGN KEY (categoria_id) REFERENCES categorias(id_categorias)
  );
    
CREATE TABLE clientes(
  id_clientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_cliente VARCHAR(20) NOT NULL,
  apellido_cliente VARCHAR(30) NOT NULL,
  cuil_cliente CHAR(11) NOT NULL,
  direccion_cliente VARCHAR(30) NOT NULL, 
  cp_cliente CHAR(4) NOT NULL,
  telefono_cliente VARCHAR(30), 
  email_cliente VARCHAR(30),
  pais_id INT NOT NULL,  
  membresia boolean
  FOREIGN KEY (pais_id) REFERENCES paises(id_paises)
  );
  
  CREATE TABLE transportes(
  id_transportes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  razonsocial_transporte VARCHAR(20) NOT NULL,
  cap_carga INT NOT NULL,
  direccion_transporte VARCHAR(30) NOT NULL, 
  cp_transporte CHAR(4) NOT NULL,
  telefono_transporte VARCHAR(30), 
  email_transporte VARCHAR(30)
  );
  
  CREATE TABLE zonas_entrega(
  id_zonas CHAR(4) NOT NULL PRIMARY KEY,
  detalle_zona CHAR(4) NOT NULL,
  ciudad_deliver VARCHAR(20) NOT NULL,
  provincia_deliver VARCHAR(20) NOT NULL,
  distancia_cd INT NOT NULL, 
  eta_deliver INT NOT NULL,
  tarifa_deliver DECIMAL(10,2), 
  transporte_id INT,
  FOREIGN KEY (transporte_id) REFERENCES transportes(id_transportes)
  );
  
  CREATE TABLE ordenes_entrega(
  id_ordenes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  direccion_deliver VARCHAR(30) NOT NULL,
  zona_id CHAR(4) NOT NULL,
  observaciones_deliver VARCHAR(50),
  FOREIGN KEY (zona_id) REFERENCES zonas_entrega(id_zonas)
  );
  
  CREATE TABLE exposiciones(
  id_exposiciones INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  categoria_exp VARCHAR(10) NOT NULL,
  comision_exp DECIMAL(10,2) NOT NULL
  );
  
  CREATE TABLE publicaciones(
  id_publicaciones INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  producto_id INT NOT NULL,
  descripcion_pub VARCHAR(50),
  precio_pub DECIMAL(10,2) NOT NULL, 
  exposicion_id INT NOT NULL,
  FOREIGN KEY (exposicion_id) REFERENCES exposiciones(id_exposiciones),
  FOREIGN KEY (producto_id) REFERENCES productos(id_productos)
  );
  
  CREATE TABLE facturas(
  id_factura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  publicacion_id INT NOT NULL,
  cant_venta INT NOT NULL, 
  cliente_id INT NOT NULL,
  orden_id INT NOT NULL,
  FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id_publicaciones),
  FOREIGN KEY (cliente_id) REFERENCES clientes(id_clientes),
  FOREIGN KEY (orden_id) REFERENCES ordenes_entrega(id_ordenes)
  );
  

INSERT INTO rubros
(descripcion_rubro)
VALUES 
('deportes'),
('bebidas'),
('belleza'),
('electronica'),
('automoviles');

INSERT INTO categorias
(descripcion_categoria)
VALUES 
('whiskeys'),
('vinos blancos'),
('vinos tintos'),
('vinos rosados'),
('Almacenamiento data'),
('detailing vehiculos'),
('mascarillas faciales'),
('jabones organicos'),
('camisetas futbol')
;

INSERT INTO monedas
(simbolo_monedas, descripcion_monedas)
VALUES 
('ARS','peso argentino'),
('BRL','real brasileno'),
('CLP','peso chileno'),
('PYG','guarani paraguayo'),
('PEN','sol'),
('BOB','boliviano'),
('UYU','peso uruguayo');

INSERT INTO paises
(simbolo_pais, descripcion_paises, moneda_id)
VALUES 
('ARG','Argentina',1),
('BRA','Brasil',2),
('CHL','Chile',3),
('PRY','Paraguay',4),
('PER','Peru',5),
('BOL','Bolivia',6),
('URY','Uruguay',7);


INSERT INTO vendedores
(razonsocial_vendedor, cuit_vendedor, rubro_id, direccion_vendedor, cp_vendedor, telefono_vendedor, email_vendedor, reputacion)
VALUES 
('todosport',20422491812,1,'estado de israel 4769',1185,1154324211,'todosport@gmail.com','oro'),
('la campinia',27235561512,2,'mansilla 3514',1425,1153675780,'lacampinia@gmail.com','platino'),
('electrostar',27089097893,4,'gascon 826',1181,1155679909,'electrostar@gmail.com','platino'),
('todo organico',20123950019,3,'darwin 1154',1414,1153218181,'todoorganico@gmail.com','bronce'),
('beauty store',27304395009,3,'27 de febrero 601',1203,1153567905,'beautystore@gmail.com','bronce'),
('detailing caba',27355550017,5,'warnes 390',1614,1153211805,'detailingcaba@gmail.com','plata'),
('la vinoteca del nono',27105650519,2,'newton 23',1045,1153211911,'ladelnono@gmail.com','oro'),
('dexter',20234569879,1,'serrano 879',1312,1153211456,'dexter@gmail.com','oro'),
('de primera',20342495107,1,'san jose 456',1056,1153211305,'de1era@gmail.com','bronce'),
('pasion y algo mas',20123955767,1,'directorio 2154',1069,1153211367,'pasionyalgomas@gmail.com','bronce');


INSERT INTO productos
(descripcion, cant, fecha_ingreso, precio_venta, tamano_producto, categoria_id, vendedor_id)
VALUES 
('Whiskey Old Parr x 750 ml',6,20230314,10145.45,0.04,1,2),
('Whiskey Buchanans x 750 ml',2,20230314,11545.00,0.04,1,2),
('Vino La Clelia cabernet franc x 750 ml',12,20230314,3545.00,0.03,3,7),
('pendrive 16 GB',120,20230430,999.00,0.01,5,3),
('pendrive 32 GB',120,20230430,1799.00,0.01,5,3),
('pendrive 64 GB',120,20230430,2999.00,0.01,5,3),
('Camiseta Rosario Central Talle S',50,20230601,16999.00,0.02,9,8),
('Camiseta Rosario Central Talle M',50,20230601,16999.00,0.02,9,8),
('Camiseta Rosario Central Talle L',50,20230601,16999.00,0.02,9,8),
('Camiseta Rosario Central Talle XL',20,20230601,16999.00,0.02,9,8),
('Jabon 100% organico de tocador fragancia citrica',25,20230701,899.00,0.01,7,4),
('Jabon 100% organico de tocador fragancia floral',25,20230701,899.00,0.01,7,4),
('Mascarilla facial rejuvenecedora',100,20230701,1099.00,0.01,8,5),
('Mascarillas facial hidratante',100,20230701,1099.00,0.01,8,5),
('Camiseta futbol generica Talle S',50,20230601,3999.00,0.02,9,10),
('Camiseta futbol generica Talle M',50,20230601,3999.00,0.02,9,10),
('Camiseta futbol generica Talle L',50,20230601,3999.00,0.02,9,10),
('Camiseta futbol generica Talle XL',20,20230601,3999.00,0.02,9,10),
('Camiseta futbol generica cool tech Talle S',100,20230601,5999.00,0.02,9,9),
('Camiseta futbol generica cool tech Talle M',100,20230601,5999.00,0.02,9,9),
('Camiseta futbol generica cool tech Talle L',100,20230601,5999.00,0.02,9,9),
('Camiseta futbol generica cool tech Talle XL',50,20230601,5999.00,0.02,9,9)
;


INSERT INTO clientes
(nombre_cliente, apellido_cliente, cuil_cliente , direccion_cliente, cp_cliente, telefono_cliente, email_cliente, pais_id, membresia)
VALUES 
('Lionel','Messi',20305561512,'avenida belgrano 1240',2000,3516367578,'leo_campeon@gmail.com',1,1),
('Azul','Perez',27401161247,'san martin 456',3500,'','azul_perez1@gmail.com',1,0),
('Milena','Katz',27423069017,'guemes 2304',5700,'','mile_k99@gmail.com',1,1),
('Francisca','Garcia',27422411247,'soler 1245',1001,'','franga91@gmail.com',1,0),
('Franco','Martinez',27301239017,'medrano 654',1022,'','fmartinez.1987@gmail.com',1,1),
('Juan','Garcia',27248961137,'malabia 1240',1015,'','juanitogarcia77@gmail.com',1,0),
('Martin','Gonzalez',27113069217,'aguero 435',1012,'','marting1992@gmail.com',1,1),
('Nahuel','Gomez',27101161907,'directorio 1240',1010,'','nahuegomez@gmail.com',1,0),
('Tomas','Juarez',27183060807,'sarmiento 4114',1013,'','tommyj1@gmail.com',1,1),
('Agustina','Rodriguez',27251164447,'lavalle 1240',1010,'','aguus1240@gmail.com',1,0),
('Angel','Paz',27543061097,'belgrano 1241',1025,'','apaz12@gmail.com',1,1)
;

INSERT INTO transportes
(razonsocial_transporte, cap_carga, direccion_transporte, cp_transporte, telefono_transporte, email_transporte)
VALUES 
('rapido del norte',30,'ruta 11 km 10,5',3500,3624459489,'rapidodelnorte@gmail.com'),
('expreso de la sierra',28,'fuerza aerea y rn 147',5700,2264425678,'expresodelasierras@gmail.com'),
('elporteno',56,'warnes 1340',1218,1155635963,'elporteno@hotmail.com'),
('el rosarino',120,'orono 6245',2000,3414657890,'elrosarino@gmail.com')
;


INSERT INTO zonas_entrega
(id_zonas, detalle_zona, ciudad_deliver, provincia_deliver, distancia_cd, eta_deliver, tarifa_deliver, transporte_id)
VALUES 
(1001,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1002,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1003,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1004,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1005,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1006,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1007,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1008,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1009,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1010,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1011,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1012,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1013,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1014,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1015,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1016,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1017,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1018,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1019,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1020,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1021,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1022,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1023,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1024,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1025,'SCF1','capital federal','capital federal',15,0,800.00,3),
(1026,'SCF1','capital federal','capital federal',15,0,800.00,3),
(5700,'SLU1','san luis','san luis',780,2,3900.00,2),
(2000,'SRO1','rosario','santa fe',300,1,1600.00,4),
(3500,'SRE1','resistencia','chaco',600,2,2500.00,1);

INSERT INTO ordenes_entrega
(direccion_deliver, zona_id,observaciones_deliver)
VALUES 

('avenida belgrano 1240',2000,'no funciona el timbre'),
('almirante brown 240',5700,'entregar a gladys'),
('soler 1245',1001,''),
('medrano 654',1022,''),
('malabia 1240',1015,''),
('aguero 435',1012,''),
('directorio 1240',1010,''),
('sarmiento 4114',1013,''),
('lavalle 1240',1010,'1 B'),
('belgrano 1241',1025,''),
('soler 1245',1001,'')
;

INSERT INTO exposiciones
(categoria_exp, comision_exp)
VALUES 
('vip',4500.00),
('exclusive',3000.00),
('premium',1999.00),
('classic',999.00),
('standard',500.00),
('economic',5.00);


INSERT INTO publicaciones
(producto_id, descripcion_pub, precio_pub, exposicion_id)
VALUES 
(1,'Excelente whiskey escoses single envios',12800.45,3),
(2,'Excelente whiskey irlandes blend envios',12099.00,3),
(3,'Exquisito vino tinto valle de uco envios gratis',4999.00,5),
(11,' Riquisimo Jabon 100% organico fragancia citrica',899.00,6),
(12,'Riquisimo Jabon 100% organicofragancia floral',899.00,6),
(13,'Mascarilla facial rejuvenecedora',1099.00,6),
(14,'Mascarillas facial hidratante',1099.00,6),
(15,'Camiseta de futbol editable S',3999.00,5),
(16,'Camiseta de futbol editable M',3999.00,5),
(17,'Camiseta de futbol editable L',3999.00,5),
(18,'Camiseta de futbol editable XL',3999.00,5),
(7,'Camiseta Rosario Central original S',16999.00,3),
(8,'Camiseta Rosario Central original M',16999.00,2),
(9,'Camiseta Rosario Central original L',16999.00,3),
(10,'Camiseta Rosario Central original XL',16999.00,3)
;	

INSERT INTO facturas
(publicacion_id, cant_venta, cliente_id, orden_id)
VALUES 

(3,3,1,3),
(2,1,3,2),
(9,3,4,3),
(4,2,5,4),
(7,5,6,5),
(15,1,7,6),
(14,1,8,7),
(4,2,9,8),
(1,1,10,9),
(13,1,11,10),
(10,3,4,11)
;	
