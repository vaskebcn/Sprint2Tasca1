-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Youtube` DEFAULT CHARACTER SET utf8 ;
USE `Youtube` ;

-- -----------------------------------------------------
-- Table `Youtube`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `bod` DATE NOT NULL,
  `gender` ENUM("M", "F") NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zipcode` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`canal` (
  `canal_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `time_created` DATETIME NOT NULL,
  PRIMARY KEY (`canal_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`video` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `size` FLOAT NOT NULL,
  `video_name` VARCHAR(45) NOT NULL,
  `duration` VARCHAR(45) NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `times_viewed` INT NOT NULL,
  `likes` INT NOT NULL,
  `dislikes` VARCHAR(45) NOT NULL,
  `user_id_p` VARCHAR(45) NOT NULL,
  `published` DATETIME NOT NULL,
  `user_user_id` INT NOT NULL,
  `canal_canal_id` INT NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `fk_video_user1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `fk_video_canal1_idx` (`canal_canal_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `Youtube`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_canal1`
    FOREIGN KEY (`canal_canal_id`)
    REFERENCES `Youtube`.`canal` (`canal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`label` (
  `label_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `video_video_id` INT NOT NULL,
  PRIMARY KEY (`label_id`),
  INDEX `fk_label_video_idx` (`video_video_id` ASC) VISIBLE,
  CONSTRAINT `fk_label_video`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `Youtube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`comments` (
  `comments_id` INT NOT NULL AUTO_INCREMENT,
  `text` MEDIUMTEXT NOT NULL,
  `date/time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `video_video_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`comments_id`),
  INDEX `fk_comments_video1_idx` (`video_video_id` ASC) VISIBLE,
  INDEX `fk_comments_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `Youtube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `Youtube`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`likes` (
  `likes_id` INT NOT NULL,
  `type` ENUM("L", "D") NOT NULL,
  `time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `likes_col` VARCHAR(45) NULL,
  `video_video_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  `comments_comments_id` INT NOT NULL,
  PRIMARY KEY (`likes_id`),
  INDEX `fk_likes_video1_idx` (`video_video_id` ASC) VISIBLE,
  INDEX `fk_likes_user1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `fk_likes_comments1_idx` (`comments_comments_id` ASC) VISIBLE,
  CONSTRAINT `fk_likes_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `Youtube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `Youtube`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_comments1`
    FOREIGN KEY (`comments_comments_id`)
    REFERENCES `Youtube`.`comments` (`comments_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM("public", "private") NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlist_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `Youtube`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`canal_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`canal_has_user` (
  `canal_canal_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`canal_canal_id`, `user_user_id`),
  INDEX `fk_canal_has_user_user1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `fk_canal_has_user_canal1_idx` (`canal_canal_id` ASC) VISIBLE,
  CONSTRAINT `fk_canal_has_user_canal1`
    FOREIGN KEY (`canal_canal_id`)
    REFERENCES `Youtube`.`canal` (`canal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canal_has_user_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `Youtube`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Youtube`.`video_has_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Youtube`.`video_has_playlist` (
  `video_video_id` INT NOT NULL,
  `playlist_playlist_id` INT NOT NULL,
  PRIMARY KEY (`video_video_id`, `playlist_playlist_id`),
  INDEX `fk_video_has_playlist_playlist1_idx` (`playlist_playlist_id` ASC) VISIBLE,
  INDEX `fk_video_has_playlist_video1_idx` (`video_video_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_has_playlist_video1`
    FOREIGN KEY (`video_video_id`)
    REFERENCES `Youtube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_has_playlist_playlist1`
    FOREIGN KEY (`playlist_playlist_id`)
    REFERENCES `Youtube`.`playlist` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
