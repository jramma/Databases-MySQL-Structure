
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------


CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(16) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` INT NOT NULL,
  `mail` VARCHAR(255) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `clienteRecomendador` VARCHAR(45) NULL,
  `empleadoQueAtiende` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC) VISIBLE);

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `direccion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(255) NOT NULL,
  `numero` INT NULL,
  `piso` INT NULL,
  `puerta` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `codigo_postal` INT NOT NULL,
  `pais` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `direccion_id` INT NOT NULL,
  `telefono` INT NOT NULL,
  `fax` INT NULL,
  `nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `direccion_id_idx` (`direccion_id` ASC) VISIBLE,
  CONSTRAINT `direccion_id`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `mydb`.`direccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marca` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `proveedor_id_idx` (`proveedor_id` ASC) VISIBLE,
  CONSTRAINT `proveedor_id`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `mydb`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `gafa` (
  `id` INT NOT NULL,
  `marca_id` INT NOT NULL,
  `graduacion` INT NOT NULL,
  `montura` VARCHAR(45) NOT NULL,
  `colorCristal` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `marca_id_idx` (`marca_id` ASC) VISIBLE,
  CONSTRAINT `marca_id`
    FOREIGN KEY (`marca_id`)
    REFERENCES `mydb`.`marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



