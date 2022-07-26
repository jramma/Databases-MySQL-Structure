create database spotify;
use spotify;

-- MySQL Script generated by MySQL Workbench
-- Sat Jul 23 16:29:55 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tipo_de_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_de_usuario` (
  `id` TINYINT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sexo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_id` TINYINT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `username` VARCHAR(16) NOT NULL,
  `fecha_de_nacimiento` TIMESTAMP NULL,
  `sexo_id` INT NOT NULL,
  `pais_id` INT NOT NULL,
  `codigo_postal` INT NULL,
  `usercol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `tipo_id_idx` (`tipo_id` ASC) VISIBLE,
  INDEX `sexo_id_idx` (`sexo_id` ASC) VISIBLE,
  INDEX `pais_id_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `tipo_id`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `mydb`.`tipo_de_usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sexo_id`
    FOREIGN KEY (`sexo_id`)
    REFERENCES `mydb`.`sexo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pais_id`
    FOREIGN KEY (`pais_id`)
    REFERENCES `mydb`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`registro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `num_total` INT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `mydb`.`tarjeta_de_credito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tarjeta_de_credito` (
  `id` TINYINT NOT NULL AUTO_INCREMENT,
  `num_targeta_de_credito` INT NOT NULL,
  `mes_caducidad` DATE NOT NULL,
  `año` INT NOT NULL,
  `codigo_seguridad` INT NOT NULL,
  `registro_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `registro_id_idx` (`registro_id` ASC) VISIBLE,
  CONSTRAINT `registro_id`
    FOREIGN KEY (`registro_id`)
    REFERENCES `mydb`.`registro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`PayPal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PayPal` (
  `id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `registro_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `registro_id_idx` (`registro_id` ASC) VISIBLE,
  CONSTRAINT `registro_id`
    FOREIGN KEY (`registro_id`)
    REFERENCES `mydb`.`registro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`usuario_Premium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario_Premium` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_renovacion` TIMESTAMP NOT NULL,
  `id_forma_de_pago` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `id_forma_de_pago_idx` (`id_forma_de_pago` ASC) VISIBLE,
  UNIQUE INDEX `id_forma_de_pago_UNIQUE` (`id_forma_de_pago` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_forma_de_pago`
    FOREIGN KEY (`id_forma_de_pago`)
    REFERENCES `mydb`.`tarjeta_de_credito` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_forma_de_pago`
    FOREIGN KEY (`id_forma_de_pago`)
    REFERENCES `mydb`.`PayPal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`eliminada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eliminada` (
  `id` TINYINT NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`tipo_activas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_activas` (
  `id` TINYINT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`tipo_borradas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_borradas` (
  `id` TINYINT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`playList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playList` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_by` INT NOT NULL,
  `num_de_canciones` INT NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eliminada_id` TINYINT NOT NULL,
  `tipo_id` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `created_by_idx` (`created_by` ASC) VISIBLE,
  INDEX `eliminada_id_idx` (`eliminada_id` ASC) VISIBLE,
  INDEX `tipo_id_idx` (`tipo_id` ASC) VISIBLE,
  CONSTRAINT `created_by`
    FOREIGN KEY (`created_by`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `eliminada_id`
    FOREIGN KEY (`eliminada_id`)
    REFERENCES `mydb`.`eliminada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_id`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `mydb`.`tipo_activas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_id`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `mydb`.`tipo_borradas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`eliminar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eliminar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_by` INT NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `playlist_eliminada` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `created_by_idx` (`created_by` ASC) VISIBLE,
  INDEX `playlist_eliminada_idx` (`playlist_eliminada` ASC) VISIBLE,
  CONSTRAINT `created_by`
    FOREIGN KEY (`created_by`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `playlist_eliminada`
    FOREIGN KEY (`playlist_eliminada`)
    REFERENCES `mydb`.`playList` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`añadair_cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`añadair_cancion` (
  `id` INT NOT NULL,
  `created_by` INT NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_activas` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `created_by_idx` (`created_by` ASC) VISIBLE,
  UNIQUE INDEX `tipo_activas_UNIQUE` (`tipo_activas` ASC) VISIBLE,
  CONSTRAINT `created_by`
    FOREIGN KEY (`created_by`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_activas`
    FOREIGN KEY (`tipo_activas`)
    REFERENCES `mydb`.`tipo_activas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artista` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `imagen` BLOB NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `mydb`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `año_de_publicacion` DATETIME NOT NULL,
  `portada` BLOB NOT NULL,
  `id_publicado_por` INT NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `mydb`.`cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cancion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_album` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `duracion` FLOAT NULL,
  `num_de_veces_reproducida` INT NOT NULL,
  `id_artista` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `id_artista_idx` (`id_artista` ASC) VISIBLE,
  INDEX `id_album_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `id_artista`
    FOREIGN KEY (`id_artista`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_album`
    FOREIGN KEY (`id_album`)
    REFERENCES `mydb`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`publicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`publicacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_by_artista` INT NOT NULL,
  `album_created` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `album_created_UNIQUE` (`album_created` ASC) VISIBLE,
  INDEX `created_by_artista_idx` (`created_by_artista` ASC) VISIBLE,
  CONSTRAINT `album_created`
    FOREIGN KEY (`album_created`)
    REFERENCES `mydb`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `created_by_artista`
    FOREIGN KEY (`created_by_artista`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`cancion_pertenecea_al_album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cancion_pertenecea_al_album` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `id_album` INT NOT NULL,
  `id_cancion` INT NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `id_cancion_UNIQUE` (`id_cancion` ASC) VISIBLE,
  INDEX `id_album_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `id_album`
    FOREIGN KEY (`id_album`)
    REFERENCES `mydb`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_cancion`
    FOREIGN KEY (`id_cancion`)
    REFERENCES `mydb`.`cancion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`seguidores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seguidores` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `usuario` INT NOT NULL,
  `artista` INT NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC) VISIBLE,
  INDEX `artista_idx` (`artista` ASC) VISIBLE,
  CONSTRAINT `artista`
    FOREIGN KEY (`artista`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usuario`
    FOREIGN KEY (`usuario`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`artistas_similares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artistas_similares` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `artista_consulta` INT NOT NULL,
  `artistas` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `artista_consulta_UNIQUE` (`artista_consulta` ASC) VISIBLE,
  INDEX `artistas_idx` (`artistas` ASC) VISIBLE,
  CONSTRAINT `artista_consulta`
    FOREIGN KEY (`artista_consulta`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `artistas`
    FOREIGN KEY (`artistas`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`cancion_favorita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cancion_favorita` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `cancion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cancion_id_UNIQUE` (`cancion_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cancion_id`
    FOREIGN KEY (`cancion_id`)
    REFERENCES `mydb`.`cancion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`album_favorito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`album_favorito` (
  `category_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `album_id_UNIQUE` (`album_id` ASC) VISIBLE,
  INDEX `usuario_id_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `usuario_id`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `album_id`
    FOREIGN KEY (`album_id`)
    REFERENCES `mydb`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
