-- MySQL Workbench Synchronization
-- Generated: 2018-08-12 18:03
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: ea

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `geodata`.`_cities` 
DROP `region_cz`,
DROP `region_lv`,
DROP `region_lt`,
DROP `region_ja`,
DROP `region_pl`,
DROP `region_it`,
DROP `region_fr`,
DROP `region_de`,
DROP `region_pt`,
DROP `region_es`,
DROP `region_en`,
DROP `region_be`,
DROP `region_ru`;

ALTER TABLE `geodata`.`_cities` 
CHANGE COLUMN `city_id` `city_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD COLUMN `area_id` INT(11) NULL DEFAULT NULL AFTER `region_id`,
ADD PRIMARY KEY (`city_id`),
ADD INDEX `fk__cities__countries_idx` (`country_id` ASC),
ADD INDEX `fk__cities__regions_idx` (`region_id` ASC),
ADD INDEX `index_city` (`title_ru` ASC, `title_ua` ASC, `title_be` ASC, `title_en` ASC, `title_es` ASC, `title_pt` ASC, `title_de` ASC, `title_fr` ASC, `title_it` ASC, `title_pl` ASC, `title_ja` ASC, `title_lt` ASC, `title_lv` ASC, `title_cz` ASC),
ADD INDEX `fk__cities_area_idx` (`area_id` ASC),
ADD INDEX `index_area_nextdel` (`area_ru` ASC, `area_ua` ASC, `area_be` ASC, `area_en` ASC, `area_es` ASC, `area_pt` ASC, `area_de` ASC, `area_fr` ASC, `area_it` ASC, `area_pl` ASC, `area_ja` ASC, `area_lt` ASC, `area_lv` ASC, `area_cz` ASC);

ALTER TABLE `geodata`.`_countries` 
CHANGE COLUMN `country_id` `country_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`country_id`),
ADD INDEX `index_country` (`title_ru` ASC, `title_ua` ASC, `title_be` ASC, `title_en` ASC, `title_es` ASC, `title_pt` ASC, `title_de` ASC, `title_fr` ASC, `title_it` ASC, `title_pl` ASC, `title_ja` ASC, `title_lt` ASC, `title_lv` ASC, `title_cz` ASC);

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `region_id` `region_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`region_id`),
ADD INDEX `fk__regions__countries_idx` (`country_id` ASC),
ADD INDEX `index_regions` (`title_ru` ASC, `title_ua` ASC, `title_be` ASC, `title_en` ASC, `title_es` ASC, `title_pt` ASC, `title_de` ASC, `title_fr` ASC, `title_it` ASC, `title_pl` ASC, `title_ja` ASC, `title_lt` ASC, `title_lv` ASC, `title_cz` ASC);

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
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `geodata`.`_cities` 
ADD CONSTRAINT `fk__cities__countries`
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`country_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk__cities__regions`
  FOREIGN KEY (`region_id`)
  REFERENCES `geodata`.`_regions` (`region_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk__cities__area`
  FOREIGN KEY (`area_id`)
  REFERENCES `geodata`.`area` (`area_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `geodata`.`_regions` 
ADD CONSTRAINT `fk__regions__countries`
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`country_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
