-- MySQL Workbench Synchronization
-- Generated: 2018-08-12 18:03
-- Model: New Model
-- Version: 1.0
-- Project: GB DB HW02
-- Author: ea.mezin


-- ШАГ#1. Создаём схему и базовые таблицы.
DROP SCHEMA `geodata`;
CREATE SCHEMA `geodata`;
USE `geodata`;

CREATE TABLE `_cities` (
  `city_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `important` BOOL NOT NULL,
  `region_id` INT NULL,
  `title_ru` VARCHAR(150) NULL,
  `area_ru` VARCHAR(150) NULL,
  `region_ru` VARCHAR(150) NULL,
  `title_ua` VARCHAR(150) NULL,
  `area_ua` VARCHAR(150) NULL,
  `region_ua` VARCHAR(150) NULL,
  `title_be` VARCHAR(150) NULL,
  `area_be` VARCHAR(150) NULL,
  `region_be` VARCHAR(150) NULL,
  `title_en` VARCHAR(150) NULL,
  `area_en` VARCHAR(150) NULL,
  `region_en` VARCHAR(150) NULL,
  `title_es` VARCHAR(150) NULL,
  `area_es` VARCHAR(150) NULL,
  `region_es` VARCHAR(150) NULL,
  `title_pt` VARCHAR(150) NULL,
  `area_pt` VARCHAR(150) NULL,
  `region_pt` VARCHAR(150) NULL,
  `title_de` VARCHAR(150) NULL,
  `area_de` VARCHAR(150) NULL,
  `region_de` VARCHAR(150) NULL,
  `title_fr` VARCHAR(150) NULL,
  `area_fr` VARCHAR(150) NULL,
  `region_fr` VARCHAR(150) NULL,
  `title_it` VARCHAR(150) NULL,
  `area_it` VARCHAR(150) NULL,
  `region_it` VARCHAR(150) NULL,
  `title_pl` VARCHAR(150) NULL,
  `area_pl` VARCHAR(150) NULL,
  `region_pl` VARCHAR(150) NULL,
  `title_ja` VARCHAR(150) NULL,
  `area_ja` VARCHAR(150) NULL,
  `region_ja` VARCHAR(150) NULL,
  `title_lt` VARCHAR(150) NULL,
  `area_lt` VARCHAR(150) NULL,
  `region_lt` VARCHAR(150) NULL,
  `title_lv` VARCHAR(150) NULL,
  `area_lv` VARCHAR(150) NULL,
  `region_lv` VARCHAR(150) NULL,
  `title_cz` VARCHAR(150) NULL,
  `area_cz` VARCHAR(150) NULL,
  `region_cz` VARCHAR(150) NULL);

CREATE TABLE `_regions` (
  `region_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `title_ru` VARCHAR(150) NULL,
  `title_ua` VARCHAR(150) NULL,
  `title_be` VARCHAR(150) NULL,
  `title_en` VARCHAR(150) NULL,
  `title_es` VARCHAR(150) NULL,
  `title_pt` VARCHAR(150) NULL,
  `title_de` VARCHAR(150) NULL,
  `title_fr` VARCHAR(150) NULL,
  `title_it` VARCHAR(150) NULL,
  `title_pl` VARCHAR(150) NULL,
  `title_ja` VARCHAR(150) NULL,
  `title_lt` VARCHAR(150) NULL,
  `title_lv` VARCHAR(150) NULL,
  `title_cz` VARCHAR(150) NULL);
  
CREATE TABLE `_countries` (
  `country_id` INT NOT NULL,
  `title_ru` VARCHAR(60) NULL,
  `title_ua` VARCHAR(60) NULL,
  `title_be` VARCHAR(60) NULL,
  `title_en` VARCHAR(60) NULL,
  `title_es` VARCHAR(60) NULL,
  `title_pt` VARCHAR(60) NULL,
  `title_de` VARCHAR(60) NULL,
  `title_fr` VARCHAR(60) NULL,
  `title_it` VARCHAR(60) NULL,
  `title_pl` VARCHAR(60) NULL,
  `title_ja` VARCHAR(60) NULL,
  `title_lt` VARCHAR(60) NULL,
  `title_lv` VARCHAR(60) NULL,
  `title_cz` VARCHAR(60) NULL);


-- ШАГ#2. ЗАПОЛНЯЕМ ЧЕРЕЗ КОМАНДНУЮ СТРОКУ ТАБЛИЦЫ ДАННЫМИ
-- source /home/user/GeekBrains/БД/HW_BaseOfDate/HW_02/_countries.sql
-- source /home/user/GeekBrains/БД/HW_BaseOfDate/HW_02/_regions.sql
-- source /home/user/GeekBrains/БД/HW_BaseOfDate/HW_02/_cities.sql


-- ШАГ#3. Изменяем таблицу городов, регионов и стран, приводя их в заданный вид. Небольшие таблицы индексируем

ALTER TABLE `geodata`.`_cities` 
CHANGE COLUMN `city_id` `city_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD COLUMN `area_id` INT(11) NULL DEFAULT NULL AFTER `region_id`,
ADD PRIMARY KEY (`city_id`);

ALTER TABLE `geodata`.`_countries` 
CHANGE COLUMN `country_id` `country_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`country_id`),
ADD INDEX `index_country` (`title_ru` ASC, `title_en` ASC);

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `region_id` `region_id` INT(11) NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`region_id`),
ADD INDEX `fk__regions__countries_idx` (`country_id` ASC),
ADD INDEX `index_regions` (`title_ru` ASC, `title_en` ASC);



-- ШАГ#4. Индексируем жирную табличку городов, что бы не потерять комп на долго - несколько запросов.
-- Индексирую только по ru & en т.к. UTF = 3 БАЙТА НА СИМВОЛ. 150 символов - 450 байт на столбец. У меня ограничение на 3000 байт.

ALTER TABLE `geodata`.`_cities` 
ADD INDEX `fk__cities__countries_idx` (`country_id` ASC),
ADD INDEX `fk__cities__regions_idx` (`region_id` ASC),
ADD INDEX `index_city` (`title_ru` ASC, `title_en` ASC),
ADD INDEX `fk__cities_area_idx` (`area_id` ASC);

ALTER TABLE `geodata`.`_cities` 
ADD INDEX `temp_area_city` (`area_ru` ASC); -- индексирую для последующей обработки. 



-- ШАГ#5. Создаём дополнительную таблицу AREA, дабы исключить дублирование в таблице CITIES. 
-- Расставляем её связи с другими таблицами.
-- Готовим её под перенос данных.

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
    ON UPDATE NO ACTION);

-- Забыл кодировку
ALTER TABLE `geodata`.`_area` 
	CHARACTER SET = utf8;

--  получилось без изменнеия строк - так на память оставил.
-- 	CHANGE COLUMN `area_cz` `area_cz` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_lv` `area_lv` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_lt` `area_lt` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_ja` `area_ja` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_pl` `area_pl` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_it` `area_it` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_fr` `area_fr` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_pt` `area_pt` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_es` `area_es` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_en` `area_en` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_be` `area_be` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_ua` `area_ua` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ,
-- 	CHANGE COLUMN `area_ru` `area_ru` VARCHAR(150) CHARACTER SET 'utf8' NULL DEFAULT NULL ;



ALTER TABLE `geodata`.`_area` 
	ADD COLUMN `area_ru` VARCHAR(150) NULL DEFAULT NULL AFTER `region_id`,
	ADD COLUMN `area_ua` VARCHAR(150) NULL DEFAULT NULL AFTER `area_ru`,
	ADD COLUMN `area_be` VARCHAR(150) NULL DEFAULT NULL AFTER `area_ua`,
	ADD COLUMN `area_en` VARCHAR(150) NULL DEFAULT NULL AFTER `area_be`,
	ADD COLUMN `area_es` VARCHAR(150) NULL DEFAULT NULL AFTER `area_en`,
	ADD COLUMN `area_pt` VARCHAR(150) NULL DEFAULT NULL AFTER `area_es`,
	ADD COLUMN `area_de` VARCHAR(150) NULL DEFAULT NULL AFTER `area_pt`,
	ADD COLUMN `area_fr` VARCHAR(150) NULL DEFAULT NULL AFTER `area_de`,
	ADD COLUMN `area_it` VARCHAR(150) NULL DEFAULT NULL AFTER `area_fr`,
	ADD COLUMN `area_pl` VARCHAR(150) NULL DEFAULT NULL AFTER `area_it`,
	ADD COLUMN `area_ja` VARCHAR(150) NULL DEFAULT NULL AFTER `area_pl`,
	ADD COLUMN `area_lt` VARCHAR(150) NULL DEFAULT NULL AFTER `area_ja`,
	ADD COLUMN `area_lv` VARCHAR(150) NULL DEFAULT NULL AFTER `area_lt`,
	ADD COLUMN `area_cz` VARCHAR(150) NULL DEFAULT NULL AFTER `area_lv`;



-- ШАГ#6. Расставляем остальные связи между таблицами.

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


-- ШАГ#6.1 (надо было пораньше, конечно). Затираем region  в cities, дабы снизить нагрузку при обработке таблицы

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


-- ШАГ#7. Заполняем aria таблицу данными для работы с ней и сразу затираем region  в cities, дабы снизить нагрузку при обработке таблицы
-- самый жестокий запрос - обрабатывался 1 час 20 минут, завершился отказом БД. Дальше не верифицировал скрипт.

INSERT INTO `geodata`.`_area` 
  (country_id,
  region_id,
  `area_ru`)
SELECT 
  round(sum(country_id)/count(country_id)), 
  round(sum(region_id)/count(region_id)),
  `area_ru`
FROM geodata._cities 
group by 
  `area_ru`;


-- ШАГ#8. Проставляем в cities таблицу вместо названия area - соответствующий индекс в area_id
-- Затираем столбец с текстовым представлением area.

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