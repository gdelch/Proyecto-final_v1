use proyecto_final_v1;

/*Creación de tabla LOG para realizar auditorias de cambios por la fuerza de ventas en la tabla vendedores*/
 
CREATE TABLE audit_log_vendedores(
  id_auditv INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_vendedores INT NOT NULL,
  razonsocial_vendedor VARCHAR(20) NOT NULL,
  cuit_vendedor CHAR(11) NOT NULL,
  rubro_id INT NOT NULL,
  direccion_vendedor VARCHAR(30) NOT NULL, 
  cp_vendedor CHAR(4) NOT NULL,
  telefono_vendedor VARCHAR(30), 
  email_vendedor VARCHAR(30), 
  reputacion VARCHAR(20),
  accion VARCHAR(255) NOT NULL,
  fecha_modificacion DATE NOT NULL,
  hora_modificacion TIME NOT NULL,
  usuario VARCHAR (200) NOT NULL)
  ;

/*Trigger que permite identificar usuario, fecha y hora de la creación de un nuevo vendedor en la BD, junto con su información*/
  
DELIMITER //
CREATE TRIGGER tr_after_insert_vendedor
  AFTER INSERT ON vendedores 
  FOR EACH ROW BEGIN
  INSERT INTO audit_log_vendedores
              (
                          id_vendedores,
                          razonsocial_vendedor,
                          cuit_vendedor,
                          rubro_id,
                          direccion_vendedor,
                          cp_vendedor,
                          telefono_vendedor,
                          email_vendedor,
                          reputacion,
                          accion,
                          fecha_modificacion,
                          hora_modificacion,
                          usuario
              )
              VALUES
              (
                          new.id_vendedores,
                          new.razonsocial_vendedor,
                          new.cuit_vendedor,
                          new.rubro_id,
                          new.direccion_vendedor,
                          new.cp_vendedor,
                          new.telefono_vendedor,
                          new.email_vendedor,
                          new.reputacion,
                          'creación de registro',
                          CURDATE(),
                          CURTIME(),
                          CURRENT_USER()
              );
END;
//
DELIMITER ;


/*Trigger que permite identificar usuario, fecha y hora de la modificación de un vendedor en la BD, guardando su información original de backup*/

   DELIMITER //
  CREATE TRIGGER tr_before_insert_vendedor
  BEFORE UPDATE ON vendedores 
  FOR EACH ROW
  BEGIN
  INSERT INTO audit_log_vendedores
              (
                          id_vendedores,
                          razonsocial_vendedor,
                          cuit_vendedor,
                          rubro_id,
                          direccion_vendedor,
                          cp_vendedor,
                          telefono_vendedor,
                          email_vendedor,
                          reputacion,
                          accion,
                          fecha_modificacion,
                          hora_modificacion,
                          usuario
              )
              VALUES
              (
                          old.id_vendedores,
                          old.razonsocial_vendedor,
                          old.cuit_vendedor,
                          old.rubro_id,
                          old.direccion_vendedor,
                          old.cp_vendedor,
                          old.telefono_vendedor,
                          old.email_vendedor,
                          old.reputacion,
                          'actualización de registro',
                          curdate(),
                          curtime(),
                          CURRENT_USER()
              );
END;
//
DELIMITER ;

/*Creación de tabla LOG para realizar auditorias de cambios en los niveles de exposición y costos de los mismos por la fuerza marketing en la tabla exposiciones*/

CREATE TABLE audit_log_exposiciones(
  id_auditexp INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_exposiciones INT NOT NULL,
  categoria_exp VARCHAR(20) NOT NULL,
  comision_exp DECIMAL(10,2) NOT NULL,
  accion VARCHAR(255) NOT NULL,
  fecha_modificacion DATE NOT NULL,
  hora_modificacion TIME NOT NULL,
  usuario VARCHAR (200) NOT NULL)
  ;
  
  /*Trigger que permite identificar usuario, fecha y hora de la creación de una nueva categoria de exposicion, junto con su información*/
  
  
DELIMITER //
CREATE TRIGGER tr_after_insert_exposiciones
  AFTER INSERT ON exposiciones 
  FOR EACH ROW 
  BEGIN
  INSERT INTO audit_log_exposiciones
              (
                          id_exposiciones,
                          categoria_exp,
                          comision_exp,
                          accion,
                          fecha_modificacion,
                          hora_modificacion,
                          usuario
              )
              VALUES
              (
                          new.id_exposiciones,
                          new. categoria_exp,
                          new.comision_exp,
                          'creación de registro',
                          CURDATE(),
                          CURTIME(),
                          CURRENT_USER()
              );
END;
//
DELIMITER ;
  
/*Trigger que permite identificar usuario, fecha y hora de modificación de una categoria de exposicion, junto con su información previa al cambio como backup*/ 

DELIMITER //
CREATE TRIGGER tr_before_insert_exposiciones
  BEFORE
  UPDATE
  ON exposiciones FOR EACH row begin
  INSERT INTO audit_log_exposiciones
              (
                          id_exposiciones,
                          categoria_exp,
                          comision_exp,
                          accion,
                          fecha_modificacion,
                          hora_modificacion,
                          usuario
              )
              VALUES
              (
                          old.id_exposiciones,
                          old. categoria_exp,
                          old.comision_exp,
                          'actualización de registro',
                          curdate(),
                          curtime(),
                          CURRENT_USER()
              );
END;
//
DELIMITER ;
