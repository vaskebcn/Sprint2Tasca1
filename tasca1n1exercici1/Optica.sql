-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`proveidor` (
  `proveidor_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `telefon` INT NULL,
  `fax` INT NULL,
  `nif` INT NULL,
  `adreça_adreça_id` INT NOT NULL,
  PRIMARY KEY (`proveidor_id`),
  INDEX `fk_proveidor_adreça1_idx` (`adreça_adreça_id` ASC) VISIBLE,
  CONSTRAINT `fk_proveidor_adreça1`
    FOREIGN KEY (`adreça_adreça_id`)
    REFERENCES `Optica`.`adreça` (`adreça_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`adreça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`adreça` (
  `adreça_id` INT NOT NULL AUTO_INCREMENT,
  `carrer` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `pis` VARCHAR(15) NOT NULL,
  `porta` VARCHAR(15) NOT NULL,
  `codi_postal` INT NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adreça_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`proveidor` (
  `proveidor_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `telefon` INT NULL,
  `fax` INT NULL,
  `nif` INT NULL,
  `adreça_adreça_id` INT NOT NULL,
  PRIMARY KEY (`proveidor_id`),
  INDEX `fk_proveidor_adreça1_idx` (`adreça_adreça_id` ASC) VISIBLE,
  CONSTRAINT `fk_proveidor_adreça1`
    FOREIGN KEY (`adreça_adreça_id`)
    REFERENCES `Optica`.`adreça` (`adreça_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`empleat` (
  `empleat_id` INT NOT NULL AUTO_INCREMENT,
  `empleat_nom` VARCHAR(45) NOT NULL,
  `empleat_cognom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`empleat_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`clients` (
  `clients_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `data` DATETIME NOT NULL,
  `recomana_id_client` VARCHAR(45) NULL,
  `codi_postal` INT NULL,
  `adreça_adreça_id` INT NOT NULL,
  PRIMARY KEY (`clients_id`),
  INDEX `fk_clients_adreça1_idx` (`adreça_adreça_id` ASC) VISIBLE,
  CONSTRAINT `fk_clients_adreça1`
    FOREIGN KEY (`adreça_adreça_id`)
    REFERENCES `Optica`.`adreça` (`adreça_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`ulleres` (
  `ulleres_id` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `graduacio_esq` DOUBLE NOT NULL,
  `graduacio_dre` DOUBLE NOT NULL,
  `tipo_muntura` ENUM('flotant', 'pasta', 'metalica') NOT NULL,
  `color_muntura` VARCHAR(45) NOT NULL,
  `color_vidre` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  `proveidor_proveidor_id` INT NOT NULL,
  PRIMARY KEY (`ulleres_id`),
  INDEX `fk_ulleres_proveidor1_idx` (`proveidor_proveidor_id` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_proveidor1`
    FOREIGN KEY (`proveidor_proveidor_id`)
    REFERENCES `Optica`.`proveidor` (`proveidor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`ventas` (
  `ventas_id` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `empleat_empleat_id` INT NOT NULL,
  `clients_clients_id` INT NOT NULL,
  `ulleres_ulleres_id` INT NOT NULL,
  PRIMARY KEY (`ventas_id`),
  INDEX `fk_ventas_empleat_idx` (`empleat_empleat_id` ASC) VISIBLE,
  INDEX `fk_ventas_clients1_idx` (`clients_clients_id` ASC) VISIBLE,
  INDEX `fk_ventas_ulleres1_idx` (`ulleres_ulleres_id` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_empleat`
    FOREIGN KEY (`empleat_empleat_id`)
    REFERENCES `Optica`.`empleat` (`empleat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_clients1`
    FOREIGN KEY (`clients_clients_id`)
    REFERENCES `Optica`.`clients` (`clients_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_ulleres1`
    FOREIGN KEY (`ulleres_ulleres_id`)
    REFERENCES `Optica`.`ulleres` (`ulleres_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
