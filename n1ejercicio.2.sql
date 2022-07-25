SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `provincia_id` INT NOT NULL,
  `localidadNom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `localidadNom_UNIQUE` (`localidadNom` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `provincia_id`
    FOREIGN KEY (`id`)
    REFERENCES `pizzeria`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(16) NOT NULL,
  `apellido` VARCHAR(255) NULL,
  `direccion` VARCHAR(255) NULL,
  `codigo postal` INT NOT NULL,
  `localidad_id` INT NOT NULL,
  `provincia_id1` INT NOT NULL,
  `numTelefono` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `numTelefono_UNIQUE` (`numTelefono` ASC) VISIBLE,
  INDEX `provincia_id_idx` (`provincia_id1` ASC) VISIBLE,
  INDEX `localidad_id_idx` (`localidad_id` ASC) VISIBLE,
  CONSTRAINT `localidad_id`
    FOREIGN KEY (`localidad_id`)
    REFERENCES `pizzeria`.`localidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `provincia_id1`
    FOREIGN KEY (`provincia_id1`)
    REFERENCES `pizzeria`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `codigo postal` VARCHAR(45) NULL,
  `localidad_id1` INT NOT NULL,
  `provincia_id2` INT NOT NULL,
  `num_comandas` INT NULL,
  `num_empleados` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `localidad_idx` (`localidad_id1` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `provincia_id_idx` (`provincia_id2` ASC) VISIBLE,
  CONSTRAINT `localidad_id1`
    FOREIGN KEY (`localidad_id1`)
    REFERENCES `pizzeria`.`localidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `provincia_id2`
    FOREIGN KEY (`provincia_id2`)
    REFERENCES `pizzeria`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comanda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `domicilioS/N` TINYINT NOT NULL,
  `cantidadPorProducto` INT NOT NULL,
  `precioTotal` FLOAT NOT NULL,
  `user_id` INT NOT NULL,
  `num_productos` INT NOT NULL,
  `tienda_id` INT NULL COMMENT 'Para indicar la tienda que realiza el pedido',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `tienda_id_idx` (`tienda_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `pizzeria`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tienda_id`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`empleado_has_comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado_has_comanda` (
  `comanda_id` INT NOT NULL AUTO_INCREMENT,
  `repartidor_encargadoID` INT NOT NULL,
  PRIMARY KEY (`comanda_id`),
  INDEX `fk_empleado_has_comanda_comanda1_idx` (`comanda_id` ASC) VISIBLE,
  INDEX `repartidor_encargadoID_idx` (`repartidor_encargadoID` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_has_comanda_comanda1`
    FOREIGN KEY (`comanda_id`)
    REFERENCES `pizzeria`.`comanda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `repartidor_encargadoID`
    FOREIGN KEY (`repartidor_encargadoID`)
    REFERENCES `pizzeria`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `apellido` VARCHAR(45) NULL,
  `nif` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `repartidor_id` INT NULL,
  `id_tienda` INT NOT NULL COMMENT 'Para indicar la tienda en la que trabaja',
  PRIMARY KEY (`id`),
  INDEX `tienda_idx` (`id_tienda` ASC) VISIBLE,
  INDEX `repartidor_id_idx` (`repartidor_id` ASC) VISIBLE,
  CONSTRAINT `id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `repartidor_id`
    FOREIGN KEY (`repartidor_id`)
    REFERENCES `pizzeria`.`empleado_has_comanda` (`comanda_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`tipo_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tipo_producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `pizzeria`.`categoriaPizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoriaPizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `id_tipo_pizza` INT NULL,
  `categoriaPizzacol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `id_tipo_pizza_idx` (`id_tipo_pizza` ASC) VISIBLE,
  CONSTRAINT `id_tipo_pizza`
    FOREIGN KEY (`id_tipo_pizza`)
    REFERENCES `pizzeria`.`tipo_producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `imagen` BLOB NULL,
  `precio` FLOAT NOT NULL,
  `created_by` INT NOT NULL,
  `categoria_Pizza` INT NULL,
  `id_tienda_que_gestiona` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `created_by_idx` (`created_by` ASC) VISIBLE,
  INDEX `tipo_id_idx` (`tipo_id` ASC) VISIBLE,
  INDEX `categoria_Pizza_idx` (`categoria_Pizza` ASC) VISIBLE,
  INDEX `id_tienda_que_gestiona_idx` (`id_tienda_que_gestiona` ASC) VISIBLE,
  CONSTRAINT `created_by`
    FOREIGN KEY (`created_by`)
    REFERENCES `pizzeria`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_id`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `pizzeria`.`tipo_producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `categoria_Pizza`
    FOREIGN KEY (`categoria_Pizza`)
    REFERENCES `pizzeria`.`categoriaPizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_tienda_que_gestiona`
    FOREIGN KEY (`id_tienda_que_gestiona`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pizzeria`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comanda_id` INT NOT NULL,
  `producto_category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `comanda_id`, `producto_category_id`),
  INDEX `fk_comanda_has_producto_producto1_idx` (`producto_category_id` ASC) VISIBLE,
  INDEX `fk_comanda_has_producto_comanda1_idx` (`comanda_id` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_has_producto_comanda1`
    FOREIGN KEY (`comanda_id`)
    REFERENCES `pizzeria`.`comanda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_has_producto_producto1`
    FOREIGN KEY (`producto_category_id`)
    REFERENCES `pizzeria`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------------------------------------------------------------------------------
-- PRUEBAS PARA COMPROBAR QUE FUNCIONA>

INSERT INTO provincia (name) values 
('Albacete'),
('Cuenca'),
('Lazio'),
('Lleida');

INSERT INTO localidad (provincia_id, localidadNom) values 
(1,'Pego'),
(2,'Alcala'),
(3,'Casalbertone'),
(4,'Osona');

INSERT INTO tipo_producto (name) values ('PIAZZAS'),('HAMBURGUESAS'),('BEBIDAS');

INSERT INTO tienda (nombre, direccion, `codigo postal`, localidad_id1, provincia_id2) 
values 
('pizas pizzas','c/anares 23',' 09092',1,1),
('gioconda','c/palatros 222',' 04442',2,2),
('antonio pizzas','c/mateo 43',' 0456562',3,3),
('aha','c/pizzas 3',' 09595',4,4);

INSERT INTO	 categoriaPizza (name, id_tipo_pizza, categoriaPizzacol) 
values
('Pizza con piña',1,'vegana'),
('bbq',1,'spicy');

INSERT INTO cliente (nombre, apellido, direccion, `codigo postal`,localidad_id,provincia_id1,numTelefono) values
('Luis','Rodriguez','c/rodriguez',09990,2,2,7876763),
('Marc','perez','c/marc',33399,3,3,72222263),
('Helena','castro','c/helena',09990,1,1,7000063);

INSERT INTO producto (tipo_id,nombre,descripcion,precio,created_by,categoria_Pizza,id_tienda_que_gestiona) values
(3,'pi;a','esto es una descripcion',3.44,1,1,1);

INSERT INTO comanda (`domicilioS/N`,cantidadPorProducto,precioTotal,user_id,num_productos,tienda_id)
values
(0,1,7.99,1,1,1);
INSERT INTO order_detail  (comanda_id, producto_category_id)values(1,1);

INSERT INTO empleado (name, nif, telefono, id_tienda) values
('manolo', '222222222r',666888222,1),
('luis','111111e',66622655,2);

INSERT INTO empleado (name, nif, telefono, id_tienda) values
('Felipe', '000000000w',666000000,1),
('MArta','5555555555r',666000000,2);




