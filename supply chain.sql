SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema supply_chain_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema supply_chain_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `supply_chain_system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `supply_chain_system` ;

-- -----------------------------------------------------
-- Table `supply_chain_system`.`datacosupplychaindataset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supply_chain_system`.`datacosupplychaindataset` ;

CREATE TABLE IF NOT EXISTS `supply_chain_system`.`datacosupplychaindataset` (
  `Item_Type` TEXT NULL DEFAULT NULL,
  `Days_for_shipping` INT NULL DEFAULT NULL,
  `Days_for_shipment_scheduled` INT NULL DEFAULT NULL,
  `Benefit_per_order` DOUBLE NULL DEFAULT NULL,
  `Sales_per_customer` DOUBLE NULL DEFAULT NULL,
  `Delivery_Status` TEXT NULL DEFAULT NULL,
  `Late_delivery_risk` INT NULL DEFAULT NULL,
  `Category_Id` INT NULL DEFAULT NULL,
  `Categor_Name` TEXT NULL DEFAULT NULL,
  `Customer_City` TEXT NULL DEFAULT NULL,
  `Customer_Country` TEXT NULL DEFAULT NULL,
  `Customer_Email` TEXT NULL DEFAULT NULL,
  `Customer_Fname` TEXT NULL DEFAULT NULL,
  `Customer_Id` INT NULL DEFAULT NULL,
  `Customer_Lname` TEXT NULL DEFAULT NULL,
  `Customer_Password` TEXT NULL DEFAULT NULL,
  `Customer_Segment` TEXT NULL DEFAULT NULL,
  `Customer_State` TEXT NULL DEFAULT NULL,
  `Customer_Street` TEXT NULL DEFAULT NULL,
  `Customer_Zipcode` INT NULL DEFAULT NULL,
  `Department_Id` INT NULL DEFAULT NULL,
  `Department_Name` TEXT NULL DEFAULT NULL,
  `Latitude` DOUBLE NULL DEFAULT NULL,
  `Longitude` DOUBLE NULL DEFAULT NULL,
  `Market` TEXT NULL DEFAULT NULL,
  `Order_City` TEXT NULL DEFAULT NULL,
  `Order_Country` TEXT NULL DEFAULT NULL,
  `Order_Customer_Id` INT NULL DEFAULT NULL,
  `order_date` TEXT NULL DEFAULT NULL,
  `Order_Id` INT NULL DEFAULT NULL,
  `Order_Item_Cardprod_Id` INT NULL DEFAULT NULL,
  `Order_Item_Discount` DOUBLE NULL DEFAULT NULL,
  `Order_Item_Discount_Rate` DOUBLE NULL DEFAULT NULL,
  `Order_Item_Id` INT NULL DEFAULT NULL,
  `Order_Item_Product_Price` DOUBLE NULL DEFAULT NULL,
  `Order_Item_Profit_Ratio` DOUBLE NULL DEFAULT NULL,
  `Order_Item_Quantity` INT NULL DEFAULT NULL,
  `Sales` DOUBLE NULL DEFAULT NULL,
  `Order_Item_Total` DOUBLE NULL DEFAULT NULL,
  `Order_Profit_Per_Order` DOUBLE NULL DEFAULT NULL,
  `Order_Region` TEXT NULL DEFAULT NULL,
  `Order_State` TEXT NULL DEFAULT NULL,
  `Order_Status` TEXT NULL DEFAULT NULL,
  `Order_Zipcode` TEXT NULL DEFAULT NULL,
  `Product_Card_Id` INT NULL DEFAULT NULL,
  `Product_Category_Id` INT NULL DEFAULT NULL,
  `Product_Description` TEXT NULL DEFAULT NULL,
  `Product_Image` TEXT NULL DEFAULT NULL,
  `Product_Name` TEXT NULL DEFAULT NULL,
  `Product_Price` DOUBLE NULL DEFAULT NULL,
  `Product_Status` INT NULL DEFAULT NULL,
  `shipping_date_DateOrders` TEXT NULL DEFAULT NULL,
  `Shipping_Mode` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- What is the average number of days for shipping (real) and days for shipment (scheduled)?
SELECT ROUND(Avg(days_for_shipping),0) AS 'Average Number Days of Shippping', 
	   ROUND(AVG(Days_for_shipment_scheduled),0) AS 'Average Number for Shipment (Scheduled)'  
FROM datacosupplychaindataset;

-- What is the average benefit per order and sales per customer? 
SELECT CONCAT( '$ ', ROUND(AVG(Benefit_per_order),2)) AS 'Average Benefit per Order', 
	   CONCAT( '$ ', ROUND(AVG(Sales_per_customer),2)) AS 'Average sales per customer'
FROM datacosupplychaindataset;

-- How many orders experienced late delivery risk? What percentage of total orders does this represent?
SELECT Late_delivery_risk, Order_Item_Total
FROM datacosupplychaindataset
WHERE Late_delivery_risk = 1;

-- What are the different categories of products in the supply chain data, and what are their sales figures?
SELECT Categor_Name, ROUND(sum(Sales),2) 
FROM datacosupplychaindataset
GROUP BY Categor_Name
ORDER BY Sales DESC;

-- Which customer city has the highest sales? What about the lowest sales?
SELECT Customer_City, sales AS 'Highest Sales' 
FROM datacosupplychaindataset
ORDER BY sales DESC
LIMIT 1;
SELECT Customer_City, sales AS 'Lowest Sales' 
FROM datacosupplychaindataset
ORDER BY sales ASC
LIMIT 1;

-- How many orders are from each customer country?
SELECT order_country, count(Order_Country) AS "Country's Order"
FROM datacosupplychaindataset
GROUP BY Order_country;

-- How many orders were placed in each department?
SELECT Department_Name, sum(Order_Item_Quantity) AS 'Number of Items Placed'
FROM datacosupplychaindataset
GROUP BY Department_Name
ORDER BY Order_Item_Quantity DESC; 

-- What are the most common shipping modes used in the orders?
SELECT Shipping_Mode, COUNT(Shipping_Mode) AS 'Number of Shippping Mode'
FROM datacosupplychaindataset 
GROUP BY Shipping_Mode
ORDER BY COUNT(Shipping_Mode) DESC;

-- Which market (region) has the highest sales and profit per order?
SELECT Market, 
	ROUND(SUM(Sales),2) AS 'Total Sales',
	ROUND(SUM(Order_Profit_Per_Order),2)  AS 'Profit per order'
FROM datacosupplychaindataset
GROUP BY Market
LIMIT 1;

-- Give a list of orders that are pending orders
SELECT Categor_Name, 
	   concat(Customer_Fname," ", Customer_Lname) AS "Customer's Name", 
       Order_Country, 
       order_date, 
       Order_Status
FROM datacosupplychaindataset
WHERE Order_Status = 'PENDING'
ORDER BY order_date;



