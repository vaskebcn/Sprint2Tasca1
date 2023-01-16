-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`provincia` (
  `provincia_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia_id`),
  UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`localitat` (
  `localitat_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `provincia_provincia_id` INT NOT NULL,
  `provincia_provincia_id1` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`localitat_id`, `provincia_provincia_id`),
  UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) VISIBLE,
  INDEX `fk_localitat_provincia1_idx` (`provincia_provincia_id1` ASC) VISIBLE,
  CONSTRAINT `fk_localitat_provincia1`
    FOREIGN KEY (`provincia_provincia_id1`)
    REFERENCES `Pizzeria`.`provincia` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`clients` (
  `clients_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NOT NULL,
  `codi_postal` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `localitat_localitat_id` INT UNSIGNED NOT NULL,
  `localitat_provincia_provincia_id` INT NOT NULL,
  PRIMARY KEY (`clients_id`),
  INDEX `fk_clients_localitat1_idx` (`localitat_localitat_id` ASC, `localitat_provincia_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_clients_localitat1`
    FOREIGN KEY (`localitat_localitat_id` , `localitat_provincia_provincia_id`)
    REFERENCES `Pizzeria`.`localitat` (`localitat_id` , `provincia_provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoria_empleo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria_empleo` (
  `categoria_id` INT NOT NULL AUTO_INCREMENT,
  `nom_categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoria_id`),
  UNIQUE INDEX `nom_categoria_UNIQUE` (`nom_categoria` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`botiga` (
  `botiga_id` INT NOT NULL,
  `adreça` VARCHAR(45) NOT NULL,
  `codi_postal` INT NOT NULL,
  `localitat_localitat_id` INT UNSIGNED NOT NULL,
  `localitat_provincia_provincia_id` INT NOT NULL,
  PRIMARY KEY (`botiga_id`),
  INDEX `fk_botiga_localitat1_idx` (`localitat_localitat_id` ASC, `localitat_provincia_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_botiga_localitat1`
    FOREIGN KEY (`localitat_localitat_id` , `localitat_provincia_provincia_id`)
    REFERENCES `Pizzeria`.`localitat` (`localitat_id` , `provincia_provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleats` (
  `empleats_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `categoria_categoria_id` INT NOT NULL,
  `botiga_botiga_id` INT NOT NULL,
  PRIMARY KEY (`empleats_id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  UNIQUE INDEX `telefon_UNIQUE` (`telefon` ASC) VISIBLE,
  INDEX `fk_empleats_categoria1_idx` (`categoria_categoria_id` ASC) VISIBLE,
  INDEX `fk_empleats_botiga1_idx` (`botiga_botiga_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleats_categoria1`
    FOREIGN KEY (`categoria_categoria_id`)
    REFERENCES `Pizzeria`.`categoria_empleo` (`categoria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleats_botiga1`
    FOREIGN KEY (`botiga_botiga_id`)
    REFERENCES `Pizzeria`.`botiga` (`botiga_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comanda` (
  `comanda_id` INT NOT NULL AUTO_INCREMENT,
  `data/hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `a_domicili` ENUM('si', 'no') NOT NULL,
  `cantitat` INT NOT NULL,
  `preu_total` DOUBLE NOT NULL,
  `clients_clients_id` INT UNSIGNED NOT NULL,
  `empleats_empleats_id` INT NOT NULL,
  `botiga_botiga_id` INT NOT NULL,
  PRIMARY KEY (`comanda_id`),
  INDEX `fk_comanda_clients1_idx` (`clients_clients_id` ASC) VISIBLE,
  INDEX `fk_comanda_empleats1_idx` (`empleats_empleats_id` ASC) VISIBLE,
  INDEX `fk_comanda_botiga1_idx` (`botiga_botiga_id` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_clients1`
    FOREIGN KEY (`clients_clients_id`)
    REFERENCES `Pizzeria`.`clients` (`clients_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_empleats1`
    FOREIGN KEY (`empleats_empleats_id`)
    REFERENCES `Pizzeria`.`empleats` (`empleats_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_botiga1`
    FOREIGN KEY (`botiga_botiga_id`)
    REFERENCES `Pizzeria`.`botiga` (`botiga_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoria_productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria_productes` (
  `categoria_productes_id` INT NOT NULL AUTO_INCREMENT,
  `categoria_nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoria_productes_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`productes` (
  `productes_id` INT NOT NULL AUTO_INCREMENT,
  `nom_producte` VARCHAR(45) NOT NULL,
  `descripcio` MEDIUMTEXT NULL,
  `imatge` BLOB NULL,
  `categoria_productes_categoria_productes_id` INT NOT NULL,
  `preu` DOUBLE NOT NULL,
  PRIMARY KEY (`productes_id`),
  INDEX `fk_productes_categoria_productes1_idx` (`categoria_productes_categoria_productes_id` ASC) VISIBLE,
  CONSTRAINT `fk_productes_categoria_productes1`
    FOREIGN KEY (`categoria_productes_categoria_productes_id`)
    REFERENCES `Pizzeria`.`categoria_productes` (`categoria_productes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comanda_has_productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comanda_has_productes` (
  `comanda_comanda_id` INT NOT NULL,
  `productes_productes_id` INT NOT NULL,
  PRIMARY KEY (`comanda_comanda_id`, `productes_productes_id`),
  INDEX `fk_comanda_has_productes_productes1_idx` (`productes_productes_id` ASC) VISIBLE,
  INDEX `fk_comanda_has_productes_comanda1_idx` (`comanda_comanda_id` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_has_productes_comanda1`
    FOREIGN KEY (`comanda_comanda_id`)
    REFERENCES `Pizzeria`.`comanda` (`comanda_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_has_productes_productes1`
    FOREIGN KEY (`productes_productes_id`)
    REFERENCES `Pizzeria`.`productes` (`productes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
