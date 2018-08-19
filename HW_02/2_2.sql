-- MySQL Workbench Synchronization
-- Generated: 2018-08-12 18:03
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: ea


CREATE TABLE IF NOT EXISTS `geodata`.`_area` (
  `area_id` INT(11) NOT NULL AUTO_INCREMENT,
  `country_id` INT(11) NOT NULL,
  `region_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`area_id`),
  INDEX `fk_area__regions_idx` (`region_id` ASC),
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

INSERT INTO `geodata`.`_area` (
  `area_cz`,
  `area_lv`,
  `area_lt`,
  `area_ja`,
  `area_pl`,
  `area_it`,
  `area_fr`,
  `area_de`,
  `area_pt`,
  `area_es`,
  `area_en`,
  `area_be`,
  `area_ua`,
  `area_ru`,
  `region_cz`,
  `region_lv`,
  `region_lt`,
  `region_ja`,
  `region_pl`,sfdgasdgfqwefg
  `region_it`,
  `region_fr`,
  `region_de`,
  `region_pt`,
  `region_es`,
  `region_en`,
  `region_be`,
  `region_ua`,
  `region_ru`) 
SELECT (
  `area_cz`,
  `area_lv`,
  `area_lt`,
  `area_ja`,
  `area_pl`,
  `area_it`,
  `area_fr`,
  `area_de`,
  `area_pt`,
  `area_es`,
  `area_en`,
  `area_be`,
  `area_ua`,
  `area_ru`,
  `region_cz`,
  `region_lv`,
  `region_lt`,
  `region_ja`,
  `region_pl`,
  `region_it`,
  `region_fr`,
  `region_de`,
  `region_pt`,
  `region_es`,
  `region_en`,
  `region_be`,
  `region_ua`,
  `region_ru`) 
FROM `geodata`.`_cities`;


ALTER TABLE `geodata`.`_cities` 
CHANGE COLUMN `city_id` `city_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD COLUMN `area_id` INT(11) NULL DEFAULT NULL AFTER `region_id`,
ADD PRIMARY KEY (`city_id`);

ALTER TABLE `geodata`.`_cities` 
ADD INDEX `fk__cities__countries_idx` (`country_id` ASC),
ADD INDEX `fk__cities__regions_idx` (`region_id` ASC),
ADD INDEX `index_city` (`title_ru` ASC, `title_en` ASC),
ADD INDEX `fk__cities_area_idx` (`area_id` ASC);

ALTER TABLE `geodata`.`_cities` 
ADD INDEX `temp_area_city` (`area_ru` ASC, `area_en` ASC);

ALTER TABLE `geodata`.`_countries` 
CHANGE COLUMN `country_id` `country_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`country_id`),
ADD INDEX `index_country` (`title_ru` ASC, `title_en` ASC);

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `region_id` `region_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`region_id`),
ADD INDEX `fk__regions__countries_idx` (`country_id` ASC),
ADD INDEX `index_regions` (`title_ru` ASC, `title_en` ASC);

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
  REFERENCES `geodata`.`_area` (`area_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `geodata`.`_regions` 
ADD CONSTRAINT `fk__regions__countries`
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`country_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

update `geodata`.`_area` set region_id = (
	select region_id from `geodata`.`_regions` 
		where `geodata`.`_regions`.region_ru = `geodata`.`_area`.region_ru);

ALTER TABLE `geodata`.`_area` 
DROP  `region_cz`,
DROP  `region_lv`,
DROP  `region_lt`,
DROP  `region_ja`,
DROP  `region_pl`,
DROP  `region_it`,
DROP  `region_fr`,
DROP  `region_de`,
DROP  `region_pt`,
DROP  `region_es`,
DROP  `region_en`,
DROP  `region_be`,
DROP  `region_ua`,
DROP  `region_ru`;

ALTER TABLE `geodata`.`_cities` 
DROP  `region_cz`,
DROP  `region_lv`,
DROP  `region_lt`,
DROP  `region_ja`,
DROP  `region_pl`,
DROP  `region_it`,
DROP  `region_fr`,
DROP  `region_de`,
DROP  `region_pt`,
DROP  `region_es`,
DROP  `region_en`,
DROP  `region_be`,
DROP  `region_ua`,
DROP  `region_ru`;

update `geodata`.`_cities` set area_id = (
	select area_id from `geodata`.`_area` 
		where `geodata`.`_area`.area_ru = `geodata`.`_cities`.area_ru);

ALTER TABLE `geodata`.`_cities` 
DROP  `area_cz`,
DROP  `area_lv`,
DROP  `area_lt`,
DROP  `area_ja`,
DROP  `area_pl`,
DROP  `area_it`,
DROP  `area_fr`,
DROP  `area_de`,
DROP  `area_pt`,
DROP  `area_es`,
DROP  `area_en`,
DROP  `area_be`,
DROP  `area_ua`,
DROP  `area_ru`,
DROP INDEX `temp_area_city` ;