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
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customerID` INT NOT NULL,
  `fullName` VARCHAR(255) NOT NULL,
  `contactNumber` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`customerID`));


-- -----------------------------------------------------
-- Table `mydb`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categories` (
  `categoryID` INT NOT NULL,
  `category_name` VARCHAR(255) NOT NULL,
  `sub_category` VARCHAR(255) NULL,
  PRIMARY KEY (`categoryID`));


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `productID` INT NOT NULL,
  `productPrice` DECIMAL(10,2) NOT NULL,
  `productName` VARCHAR(255) NOT NULL,
  `quantity` INT NOT NULL,
  `categoryID` INT NOT NULL,
  `amountInStock` INT NOT NULL,
  PRIMARY KEY (`productID`, `categoryID`),
  INDEX `categoryID_idx` (`categoryID` ASC) VISIBLE,
  CONSTRAINT `categoryID`
    FOREIGN KEY (`categoryID`)
    REFERENCES `mydb`.`categories` (`categoryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `mydb`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`deliveries` (
  `deliveryID` INT NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `country` VARCHAR(255) NOT NULL,
  `postCode` VARCHAR(255) NOT NULL,
  `state` VARCHAR(255) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deliveryID`));


-- -----------------------------------------------------
-- Table `mydb`.`shippings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shippings` (
  `shipID` INT NOT NULL,
  `shippingMode` VARCHAR(255) NOT NULL,
  `shippingDate` DATETIME NOT NULL,
  `shippingCost` DECIMAL(10,2) NOT NULL,
  `deliveryID` INT NOT NULL,
  PRIMARY KEY (`shipID`, `deliveryID`),
  INDEX `deliveryID_idx` (`deliveryID` ASC) VISIBLE,
  CONSTRAINT `deliveryID`
    FOREIGN KEY (`deliveryID`)
    REFERENCES `mydb`.`deliveries` (`deliveryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `orderID` INT NOT NULL,
  `orderDate` DATETIME NOT NULL,
  `orderPriority` INT NULL,
  `totalCost` DECIMAL(10,2) NOT NULL,
  `productID` INT NOT NULL,
  `customerID` INT NOT NULL,
  `shippingID` INT NOT NULL,
  PRIMARY KEY (`orderID`, `customerID`, `productID`, `shippingID`),
  INDEX `productID_idx` (`productID` ASC) VISIBLE,
  INDEX `customerID_idx` (`customerID` ASC) VISIBLE,
  INDEX `shippingID_idx` (`shippingID` ASC) VISIBLE,
  CONSTRAINT `productID`
    FOREIGN KEY (`productID`)
    REFERENCES `mydb`.`products` (`productID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `customerID`
    FOREIGN KEY (`customerID`)
    REFERENCES `mydb`.`customers` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `shippingID`
    FOREIGN KEY (`shippingID`)
    REFERENCES `mydb`.`shippings` (`shipID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;