-- MySQL Script generated by MySQL Workbench
-- Вс 12 авг 2018 17:59:01
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema geodata
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema geodata
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `geodata` DEFAULT CHARACTER SET utf8 ;
USE `geodata` ;

-- -----------------------------------------------------
-- Table `geodata`.`_countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `geodata`.`_countries` (
  `country_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title_ru` VARCHAR(60) NULL DEFAULT NULL,
  `title_ua` VARCHAR(60) NULL DEFAULT NULL,
  `title_be` VARCHAR(60) NULL DEFAULT NULL,
  `title_en` VARCHAR(60) NULL DEFAULT NULL,
  `title_es` VARCHAR(60) NULL DEFAULT NULL,
  `title_pt` VARCHAR(60) NULL DEFAULT NULL,
  `title_de` VARCHAR(60) NULL DEFAULT NULL,
  `title_fr` VARCHAR(60) NULL DEFAULT NULL,
  `title_it` VARCHAR(60) NULL DEFAULT NULL,
  `title_pl` VARCHAR(60) NULL DEFAULT NULL,
  `title_ja` VARCHAR(60) NULL DEFAULT NULL,
  `title_lt` VARCHAR(60) NULL DEFAULT NULL,
  `title_lv` VARCHAR(60) NULL DEFAULT NULL,
  `title_cz` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`country_id`),
  INDEX `index_country` (`title_ru` ASC, `title_ua` ASC, `title_be` ASC, `title_en` ASC, `title_es` ASC, `title_pt` ASC, `title_de` ASC, `title_fr` ASC, `title_it` ASC, `title_pl` ASC, `title_ja` ASC, `title_lt` ASC, `title_lv` ASC, `title_cz` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `geodata`.`_regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `geodata`.`_regions` (
  `region_id` INT(11) NOT NULL AUTO_INCREMENT,
  `country_id` INT(11) NOT NULL,
  `title_ru` VARCHAR(150) NULL DEFAULT NULL,
  `title_ua` VARCHAR(150) NULL DEFAULT NULL,
  `title_be` VARCHAR(150) NULL DEFAULT NULL,
  `title_en` VARCHAR(150) NULL DEFAULT NULL,
  `title_es` VARCHAR(150) NULL DEFAULT NULL,
  `title_pt` VARCHAR(150) NULL DEFAULT NULL,
  `title_de` VARCHAR(150) NULL DEFAULT NULL,
  `title_fr` VARCHAR(150) NULL DEFAULT NULL,
  `title_it` VARCHAR(150) NULL DEFAULT NULL,
  `title_pl` VARCHAR(150) NULL DEFAULT NULL,
  `title_ja` VARCHAR(150) NULL DEFAULT NULL,
  `title_lt` VARCHAR(150) NULL DEFAULT NULL,
  `title_lv` VARCHAR(150) NULL DEFAULT NULL,
  `title_cz` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`region_id`),
  INDEX `fk__regions__countries_idx` (`country_id` ASC),
  INDEX `index_regions` (`title_ru` ASC, `title_ua` ASC, `title_be` ASC, `title_en` ASC, `title_es` ASC, `title_pt` ASC, `title_de` ASC, `title_fr` ASC, `title_it` ASC, `title_pl` ASC, `title_ja` ASC, `title_lt` ASC, `title_lv` ASC, `title_cz` ASC),
  CONSTRAINT `fk__regions__countries`
    FOREIGN KEY (`country_id`)
    REFERENCES `geodata`.`_countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `geodata`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `geodata`.`area` (
  `area_id` INT(11) NOT NULL AUTO_INCREMENT,
  `country_id` INT(11) NOT NULL,
  `region_id` INT(11) NULL DEFAULT NULL,
  `area_ru` VARCHAR(150) NULL DEFAULT NULL,
  `area_ua` VARCHAR(150) NULL DEFAULT NULL,
  `area_be` VARCHAR(150) NULL DEFAULT NULL,
  `area_en` VARCHAR(150) NULL DEFAULT NULL,
  `area_es` VARCHAR(150) NULL DEFAULT NULL,
  `area_pt` VARCHAR(150) NULL DEFAULT NULL,
  `area_de` VARCHAR(150) NULL DEFAULT NULL,
  `area_fr` VARCHAR(150) NULL DEFAULT NULL,
  `area_it` VARCHAR(150) NULL DEFAULT NULL,
  `area_pl` VARCHAR(150) NULL DEFAULT NULL,
  `area_ja` VARCHAR(150) NULL DEFAULT NULL,
  `area_lt` VARCHAR(150) NULL DEFAULT NULL,
  `area_lv` VARCHAR(150) NULL DEFAULT NULL,
  `area_cz` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`area_id`),
  INDEX `fk_area__regions_idx` (`region_id` ASC),
  INDEX `index_area` (`area_ru` ASC, `area_ua` ASC, `area_be` ASC, `area_es` ASC, `area_en` ASC, `area_pt` ASC, `area_de` ASC, `area_fr` ASC, `area_it` ASC, `area_pl` ASC, `area_ja` ASC, `area_lt` ASC, `area_lv` ASC, `area_cz` ASC),
  INDEX `fk_area__country_idx` (`country_id` ASC),
  CONSTRAINT `fk_area__regions`
    FOREIGN KEY (`region_id`)
    REFERENCES `geodata`.`_regions` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_area__country`
    FOREIGN KEY (`country_id`)
    REFERENCES `geodata`.`_countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `geodata`.`_cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `geodata`.`_cities` (
  `city_id` INT(11) NOT NULL AUTO_INCREMENT,
  `country_id` INT(11) NOT NULL,
  `important` TINYINT(1) NOT NULL,
  `region_id` INT(11) NULL DEFAULT NULL,
  `area_id` INT(11) NULL DEFAULT NULL,
  `title_ru` VARCHAR(150) NULL DEFAULT NULL,
  `area_ru` VARCHAR(150) NULL DEFAULT NULL,
  `title_ua` VARCHAR(150) NULL DEFAULT NULL,
  `area_ua` VARCHAR(150) NULL DEFAULT NULL,
  `title_be` VARCHAR(150) NULL DEFAULT NULL,
  `area_be` VARCHAR(150) NULL DEFAULT NULL,
  `title_en` VARCHAR(150) NULL DEFAULT NULL,
  `area_en` VARCHAR(150) NULL DEFAULT NULL,
  `title_es` VARCHAR(150) NULL DEFAULT NULL,
  `area_es` VARCHAR(150) NULL DEFAULT NULL,
  `title_pt` VARCHAR(150) NULL DEFAULT NULL,
  `area_pt` VARCHAR(150) NULL DEFAULT NULL,
  `title_de` VARCHAR(150) NULL DEFAULT NULL,
  `area_de` VARCHAR(150) NULL DEFAULT NULL,
  `title_fr` VARCHAR(150) NULL DEFAULT NULL,
  `area_fr` VARCHAR(150) NULL DEFAULT NULL,
  `title_it` VARCHAR(150) NULL DEFAULT NULL,
  `area_it` VARCHAR(150) NULL DEFAULT NULL,
  `title_pl` VARCHAR(150) NULL DEFAULT NULL,
  `area_pl` VARCHAR(150) NULL DEFAULT NULL,
  `title_ja` VARCHAR(150) NULL DEFAULT NULL,
  `area_ja` VARCHAR(150) NULL DEFAULT NULL,
  `title_lt` VARCHAR(150) NULL DEFAULT NULL,
  `area_lt` VARCHAR(150) NULL DEFAULT NULL,
  `title_lv` VARCHAR(150) NULL DEFAULT NULL,
  `area_lv` VARCHAR(150) NULL DEFAULT NULL,
  `title_cz` VARCHAR(150) NULL DEFAULT NULL,
  `area_cz` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk__cities__countries_idx` (`country_id` ASC),
  INDEX `fk__cities__regions_idx` (`region_id` ASC),
  INDEX `index_city` (`title_ru` ASC, `title_ua` ASC, `title_be` ASC, `title_en` ASC, `title_es` ASC, `title_pt` ASC, `title_de` ASC, `title_fr` ASC, `title_it` ASC, `title_pl` ASC, `title_ja` ASC, `title_lt` ASC, `title_lv` ASC, `title_cz` ASC),
  INDEX `fk__cities_area_idx` (`area_id` ASC),
  INDEX `index_area_nextdel` (`area_ru` ASC, `area_ua` ASC, `area_be` ASC, `area_en` ASC, `area_es` ASC, `area_pt` ASC, `area_de` ASC, `area_fr` ASC, `area_it` ASC, `area_pl` ASC, `area_ja` ASC, `area_lt` ASC, `area_lv` ASC, `area_cz` ASC),
  CONSTRAINT `fk__cities__countries`
    FOREIGN KEY (`country_id`)
    REFERENCES `geodata`.`_countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk__cities__regions`
    FOREIGN KEY (`region_id`)
    REFERENCES `geodata`.`_regions` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk__cities__area`
    FOREIGN KEY (`area_id`)
    REFERENCES `geodata`.`area` (`area_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
