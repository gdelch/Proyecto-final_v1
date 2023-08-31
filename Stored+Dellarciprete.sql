/* El SP ordena la tabla productos según el parametro ingresado, de manera ascendente o descendente según se requiera */ 

DELIMITER //
CREATE PROCEDURE
  sp_productos_filter(IN p_campo_ord VARCHAR(20),
                      IN p_tipo_ord  VARCHAR(4))
BEGIN
  SET @filtroord='';
IF p_campo_ord <> '' THEN
    IF p_tipo_ord <> '' THEN
      SET @filtroord= concat('ORDER BY ',p_campo_ord,' ',p_tipo_ord);
ELSE
      SET @filtroord= concat('ORDER BY ',p_campo_ord);
END IF;
END IF;
SET @miconsulta=concat('SELECT * FROM productos ', @filtroord);
PREPARE consulta FROM @miconsulta;
EXECUTE consulta;
END
//


/* El SP verifica el id del cliente ingresado, si el mismo ya existe, lo elimina y de no existir crea un nuevo registro con los datos ingresados en la tabla clientes */

DELIMITER //
CREATE PROCEDURE
  sp_add_or_delete_cliente(IN p_id_cliente        INT,
                           IN p_nombre_cliente    VARCHAR(20),
                           IN p_apellido_cliente  VARCHAR(30),
                           IN p_cuil_cliente      CHAR(11),
                           IN p_direccion_cliente VARCHAR(30),
                           IN p_cp_cliente        CHAR(4),
                           IN p_telefono_cliente  VARCHAR(30),
                           IN p_mail_cliente      VARCHAR(30),
                           IN p_membresia         TINYINT(1))
BEGIN
  IF p_id_cliente = '' THEN
    SELECT 'ERROR: el id del cliente no puede ser nulo';
ELSE
    IF p_nombre_cliente = '' THEN
      SELECT 'ERROR: el nombre del cliente no puede ser nulo';
ELSEIF
      p_id_cliente = '' THEN
      SELECT 'ERROR: el apellido del cliente no puede ser nulo';
ELSEIF
      p_cuil_cliente = '' THEN
      SELECT 'ERROR: el cuil del cliente no puede ser nulo';
ELSEIF
      p_direccion_cliente = '' THEN
      SELECT 'ERROR: la dirección del cliente no puede ser nula';
ELSEIF
      p_cp_cliente = '' THEN
      SELECT 'ERROR: el cp del cliente no puede ser nulo';
ELSE
      IF EXISTS
        (
               SELECT id_clientes
               FROM   clientes
               WHERE  id_clientes=p_id_cliente) THEN
        DELETE
        FROM   clientes
        WHERE  id_clientes=p_id_cliente;ELSE
        INSERT INTO clientes
                    (
                                nombre_cliente,
                                apellido_cliente,
                                cuil_cliente ,
                                direccion_cliente,
                                cp_cliente,
                                telefono_cliente,
                                email_cliente,
                                membresia
                    )
                    VALUES
                    (
                                p_nombre_cliente,
                                p_apellido_cliente,
                                p_cuil_cliente,
                                p_direccion_cliente,
                                p_cp_cliente,
                                p_telefono_cliente,
                                p_mail_cliente,
                                p_membresia
                    );
END IF;
END IF;
END IF;
END
//
		
