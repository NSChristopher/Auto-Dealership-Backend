-- MySQL Script generated by MySQL Workbench
-- Tue Mar  5 21:15:43 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DealershipDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `DealershipDB` ;

-- -----------------------------------------------------
-- Schema DealershipDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DealershipDB` DEFAULT CHARACTER SET utf8 ;
USE `DealershipDB` ;

-- -----------------------------------------------------
-- Table `DealershipDB`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`customer` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`customer` (
  `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(32) NOT NULL,
  `last_name` VARCHAR(32) NULL,
  `email` VARCHAR(254) NULL,
  `password` VARCHAR(72) NOT NULL,
  `ssn` VARCHAR(11) NULL,
  `birth_date` DATE NULL,
  `drivers_license` VARCHAR(16) NULL,
  `address_id` INT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `DealershipDB`.`credit_report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`credit_report` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`credit_report` (
  `credit_report_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `score` INT NOT NULL,
  PRIMARY KEY (`credit_report_id`),
  INDEX `fk_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_credit_report_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `DealershipDB`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`customer_vehical`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`customer_vehical` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`customer_vehical` (
  `customer_vehical_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `vin` VARCHAR(45) NULL,
  `year` VARCHAR(4) NULL,
  `make` VARCHAR(254) NULL,
  `model` VARCHAR(254) NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`customer_vehical_id`),
  UNIQUE INDEX `customer_vehical_id_UNIQUE` (`customer_vehical_id` ASC) VISIBLE,
  INDEX `fk_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_vehical_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `DealershipDB`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`vehical`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`vehical` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`vehical` (
  `vehical_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `vin` VARCHAR(17) NOT NULL,
  `price` INT NULL,
  `year` VARCHAR(4) NULL,
  `make` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `miles` INT NULL,
  `mpg` INT NULL,
  `color` VARCHAR(45) NULL,
  `fuel_type` VARCHAR(45) NULL,
  `transmission` VARCHAR(45) NULL,
  `vehical_status` INT NULL,
  PRIMARY KEY (`vehical_id`),
  UNIQUE INDEX `vehical_id_UNIQUE` (`vehical_id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `DealershipDB`.`negotiation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`negotiation` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`negotiation` (
  `negotiation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `vehical_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `negotiation_status` VARCHAR(45) NOT NULL DEFAULT 'Active',
  `start_date` DATETIME NULL DEFAULT NOW(),
  `end_date` DATETIME NULL,
  PRIMARY KEY (`negotiation_id`),
  UNIQUE INDEX `negotiation_id_UNIQUE` (`negotiation_id` ASC) VISIBLE,
  INDEX `fk_customer_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_vehical_idx` (`vehical_id` ASC) VISIBLE,
  CONSTRAINT `fk_negotiation_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `DealershipDB`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_negotiation_vehical`
    FOREIGN KEY (`vehical_id`)
    REFERENCES `DealershipDB`.`vehical` (`vehical_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`offer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`offer` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`offer` (
  `offer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `negotiation_id` INT UNSIGNED NOT NULL,
  `offer_price` INT NOT NULL,
  `offer_date` DATETIME NULL DEFAULT NOW(),
  `offer_status` VARCHAR(45) NULL,
  PRIMARY KEY (`offer_id`),
  UNIQUE INDEX `offer_counter_id_UNIQUE` (`offer_id` ASC) VISIBLE,
  INDEX `fk_negotiation_idx` (`negotiation_id` ASC) VISIBLE,
  CONSTRAINT `fk_offer_negotiation`
    FOREIGN KEY (`negotiation_id`)
    REFERENCES `DealershipDB`.`negotiation` (`negotiation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`counter_offer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`counter_offer` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`counter_offer` (
  `counter_offer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `offer_id` INT UNSIGNED NOT NULL,
  `counter_price` INT NOT NULL,
  `counter_date` DATETIME NULL DEFAULT NOW(),
  `counter_status` VARCHAR(45) NULL,
  PRIMARY KEY (`counter_offer_id`),
  UNIQUE INDEX `offer_counter_id_UNIQUE` (`offer_id` ASC) VISIBLE,
  UNIQUE INDEX `counter_offer_id_UNIQUE` (`counter_offer_id` ASC) VISIBLE,
  CONSTRAINT `fk_counter_offer_offer`
    FOREIGN KEY (`offer_id`)
    REFERENCES `DealershipDB`.`offer` (`offer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`purchase`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`purchase` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`purchase` (
  `purchase_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` INT UNSIGNED NOT NULL,
  `purchase_date` DATETIME NULL,
  `purchase_type` VARCHAR(45) NULL,
  `payment_method` VARCHAR(45) NULL,
  `sub_total` INT NULL,
  `tax` FLOAT NULL,
  `total` INT NULL,
  PRIMARY KEY (`purchase_id`),
  UNIQUE INDEX `purchase_id_UNIQUE` (`purchase_id` ASC) VISIBLE,
  INDEX `fk_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_purchase_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `DealershipDB`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`finance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`finance` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`finance` (
  `finance_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_id` INT UNSIGNED NOT NULL,
  `apy` FLOAT NULL,
  `term` INT NULL,
  `paid` INT NULL,
  `finance_status` INT NULL,
  PRIMARY KEY (`finance_id`),
  UNIQUE INDEX `finance_id_UNIQUE` (`finance_id` ASC) VISIBLE,
  UNIQUE INDEX `financecol_UNIQUE` (`purchase_id` ASC) VISIBLE,
  CONSTRAINT `fk_finance_purchase`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `DealershipDB`.`purchase` (`purchase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`role` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`role` (
  `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `role_id_UNIQUE` (`role_id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `DealershipDB`.`time_slot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`time_slot` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`time_slot` (
  `time_slot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `role_id` INT UNSIGNED NOT NULL,
  `is_available` TINYINT UNSIGNED NULL,
  PRIMARY KEY (`time_slot_id`),
  UNIQUE INDEX `time_slot_id_UNIQUE` (`time_slot_id` ASC) VISIBLE,
  INDEX `fk_role_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_time_slot_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `DealershipDB`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`user` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`user` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` INT UNSIGNED NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(72) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_role_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `DealershipDB`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`appointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`appointment` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`appointment` (
  `appointment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `time_slot_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NULL,
  `appointment_type` INT UNSIGNED NOT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`appointment_id`),
  UNIQUE INDEX `appointment_id_UNIQUE` (`appointment_id` ASC) VISIBLE,
  INDEX `fk_customer_appointment_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_time_slot_idx` (`time_slot_id` ASC) VISIBLE,
  INDEX `fk_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `DealershipDB`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_time_slot`
    FOREIGN KEY (`time_slot_id`)
    REFERENCES `DealershipDB`.`time_slot` (`time_slot_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `DealershipDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`appointment_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`appointment_details` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`appointment_details` (
  `appointment_details_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `appointment_id` INT UNSIGNED NOT NULL,
  `customer_vehical_id` INT UNSIGNED NOT NULL,
  `customer_message` VARCHAR(512) NULL,
  `notes` VARCHAR(512) NULL,
  PRIMARY KEY (`appointment_details_id`),
  UNIQUE INDEX `appointment_details_id_UNIQUE` (`appointment_details_id` ASC) VISIBLE,
  INDEX `fk_appointment_details_customer_vehical_idx` (`customer_vehical_id` ASC) VISIBLE,
  INDEX `fk_appointment_details_appointment_idx` (`appointment_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_details_appointment`
    FOREIGN KEY (`appointment_id`)
    REFERENCES `DealershipDB`.`appointment` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_details_customer_vehical`
    FOREIGN KEY (`customer_vehical_id`)
    REFERENCES `DealershipDB`.`customer_vehical` (`customer_vehical_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`retail_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`retail_item` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`retail_item` (
  `retail_item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `price` INT NULL,
  `description` VARCHAR(254) NULL,
  PRIMARY KEY (`retail_item_id`),
  UNIQUE INDEX `retail_item_id_UNIQUE` (`retail_item_id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `DealershipDB`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`payment` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`payment` (
  `payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_id` INT UNSIGNED NOT NULL,
  `ccv` VARCHAR(45) NULL,
  `expiration` VARCHAR(45) NULL,
  `card_number` VARCHAR(45) NULL,
  `routing_number` VARCHAR(45) NULL,
  `account_number` VARCHAR(45) NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE INDEX `payment_id_UNIQUE` (`payment_id` ASC) VISIBLE,
  INDEX `fk_purchase_idx` (`purchase_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_purchase`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `DealershipDB`.`purchase` (`purchase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`Log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`Log` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`Log` (
  `log_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `message` VARCHAR(512) NULL,
  `date` DATETIME NULL DEFAULT NOW(),
  `customer_id` INT UNSIGNED NULL,
  `user_id` INT UNSIGNED NULL,
  PRIMARY KEY (`log_id`),
  UNIQUE INDEX `retail_item_id_UNIQUE` (`log_id` ASC) VISIBLE,
  INDEX `fk_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `DealershipDB`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `DealershipDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `DealershipDB`.`purchase_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DealershipDB`.`purchase_item` ;

CREATE TABLE IF NOT EXISTS `DealershipDB`.`purchase_item` (
  `purchase_item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_id` INT UNSIGNED NOT NULL,
  `item_id` INT UNSIGNED NOT NULL,
  `price` INT NULL,
  PRIMARY KEY (`purchase_item_id`),
  UNIQUE INDEX `finance_id_UNIQUE` (`purchase_item_id` ASC) VISIBLE,
  UNIQUE INDEX `financecol_UNIQUE` (`purchase_id` ASC) VISIBLE,
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_purchase_item_purchase`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `DealershipDB`.`purchase` (`purchase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
