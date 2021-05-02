drop schema IF EXISTS `ace_and_tate`; -- To make sure this database and its data are not interferred with, in the case another database has the same name
create schema IF NOT EXISTS `ace_and_tate`;
use `ace_and_tate`; -- Ensures the tables and inserts are made into this database

DROP TABLE IF EXISTS `Product`;

CREATE TABLE `Product` ( -- Stores the Product ID, product price and product name
  `Product_ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Product_Name` varchar(50) NOT NULL DEFAULT 'Product Name',
  `Price` varchar(7) NOT NULL DEFAULT '£0.00',
  PRIMARY KEY (`Product_ID`)
) AUTO_INCREMENT=10;

LOCK TABLES `Product` WRITE;
INSERT INTO `Product` VALUES (000001,'Neil Satin Silver','£98.00'),(000002,'Jay Gunmetal Large','£98.00'),(000003,'Stan Clear','£118.00'),(000004,'Jay Matte Black Clip-ons','£50.00'),(000005,'Easton Saffron Clip-ons','£50.00'),(000006,'Gift Card','£100.00'),(000007,'Gift Card','€200.00'),(000008,'Max Sunglasses','£138.00'),(000009,'Heather Sunglasses','£98.00');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Glasses`;
CREATE TABLE `Glasses` (
  `Glasses_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Product_ID` int(6) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Glasses_ID`),
  CONSTRAINT `glassesToProduct` FOREIGN KEY (`Product_ID`) REFERENCES `Product`(`Product_ID`) -- represents how this table is a subtype of 'Product'
) AUTO_INCREMENT=4;

LOCK TABLES `Glasses` WRITE;
INSERT INTO `Glasses` VALUES (00001,000001),(00002,000002),(00003,000003);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Glasses_Types`;

CREATE TABLE `Glasses_Types` (
  `GType_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Glasses_ID` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`GType_ID`),
  CONSTRAINT `gtypesToglasses` FOREIGN KEY (`Glasses_ID`) REFERENCES `Glasses`(`Glasses_ID`)
) AUTO_INCREMENT=4;

LOCK TABLES `Glasses_Types` WRITE;
INSERT INTO `Glasses_Types` VALUES (00001,00001),(00002,00002),(00003,00003);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Sunglasses`;

CREATE TABLE `Sunglasses` (
  `Sunglasses_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Product_ID` int(6) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Sunglasses_ID`),
  KEY `products.S_idx` (`Product_ID`),
  CONSTRAINT `products.S` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`)
) AUTO_INCREMENT=3;

LOCK TABLES `sunglasses` WRITE;
INSERT INTO `sunglasses` VALUES (00001,000008),(00002,000009);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Sunglasses_Types`;

CREATE TABLE `Sunglasses_Types` (
  `Type_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Sunglasses_ID` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Type_ID`),
  KEY `ID_idx` (`Sunglasses_ID`),
  CONSTRAINT `Sunglasses_ID` FOREIGN KEY (`Sunglasses_ID`) REFERENCES `Sunglasses` (`Sunglasses_ID`)
) AUTO_INCREMENT=3;

LOCK TABLES `Sunglasses_Types` WRITE;
INSERT INTO `Sunglasses_Types` VALUES (00001,00001),(00002,00002);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Accessories`;

CREATE TABLE `Accessories` (
  `Accessories_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Product_ID` int(6) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Accessories_ID`),
  CONSTRAINT `accessoriesToProduct` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`)
) AUTO_INCREMENT=5;

LOCK TABLES `Accessories` WRITE;
INSERT INTO `Accessories` VALUES (00001,000004),(00002,000005),(00003,000006),(00004,000007);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Gift_Card`;

CREATE TABLE `Gift_Card` (
  `Gift_Card_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Expiry_Date` date NOT NULL,
  `Accessories_ID` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Gift_Card_ID`),
  KEY `accessories_gc_idx` (`Accessories_ID`),
  CONSTRAINT `accessories_gc` FOREIGN KEY (`Accessories_ID`) REFERENCES `Accessories` (`Accessories_ID`) -- Refers to the Accessories entity as it is a subtype of it
) AUTO_INCREMENT=3;

LOCK TABLES `Gift_Card` WRITE;
INSERT INTO `Gift_Card` VALUES (00001,'2021-08-11',00003),(00002,'2020-12-04',00004); -- Had to makesure every expiry dat is in the format YYYY-MM-DD
UNLOCK TABLES;

DROP TABLE IF EXISTS `Clip_On`;

CREATE TABLE `Clip_On` (
  `Clip_On_ID` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Accessories_ID` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Clip_On_ID`),
  KEY `accessories_co_idx` (`Accessories_ID`),
  CONSTRAINT `accessories_co` FOREIGN KEY (`Accessories_ID`) REFERENCES `Accessories` (`Accessories_ID`)
) AUTO_INCREMENT=3;

LOCK TABLES `Clip_On` WRITE;
INSERT INTO `Clip_On` VALUES (0001,00001),(0002,00002);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Clip_On_Styles`;

CREATE TABLE `Clip_On_Styles` (
  `Style_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Style_Name` enum('WIlson','Easton','Max','Pierce','Neil','Jay') NOT NULL,
  `Colour` enum('Gunmetal','Satin Gold','Matte black','Satin Silver','Satin Gold Yellow','Saffron') NOT NULL,
  `Clip_On_ID` int(4) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Style_ID`),
  KEY `styleToClipon_idx` (`Clip_On_ID`),
  CONSTRAINT `styleToClipon` FOREIGN KEY (`Clip_On_ID`) REFERENCES `Clip_On` (`Clip_On_ID`)
) AUTO_INCREMENT=5;

LOCK TABLES `Clip_On_Styles` WRITE;
INSERT INTO `Clip_On_Styles` VALUES (00003,'Jay','Matte black',0001),(00004,'Easton','Saffron',0002);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Customer`;

CREATE TABLE `Customer` (
  `Customer_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(50) NOT NULL DEFAULT 'John',
  `Last_Name` varchar(50) NOT NULL DEFAULT 'Apple',
  `Gender` enum('Male','Female') NOT NULL,
  `Prescription_Right` varchar(5) DEFAULT NULL,
  `Prescription_Left` varchar(5) DEFAULT NULL,
  `Email` varchar(50) NOT NULL DEFAULT 'johnapple@email.com',
  `Phone_Number` varchar(20) NOT NULL,
  PRIMARY KEY (`Customer_ID`)
) AUTO_INCREMENT=6;

LOCK TABLES `Customer` WRITE;
INSERT INTO `Customer` VALUES (00001,'Brad','Leone','Male','-0.25','-0.25','bleone@gmail.com','07689563459'),(00002,'Eleanor','Stropp','Female','-1.75','-1.50','eleanor.stropp@yahoo.com','+447322568009'),(00003,'Roxanne','Gonzales','Female','-2.50','-2.50','rgonzales@hotmail.com','07425719267'),(00004,'Chris','Morocco','Male',NULL,NULL,'chrismarocs@gmail.com','+33 790384133'),(00005,'Carla','Lalli-Music','Female','-3.00','-3.25','c.lalli_music@outlook.co.uk','+447224087645');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Addresses`;

CREATE TABLE `Addresses` (
  `Address_ID` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Postcode` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  PRIMARY KEY (`Address_ID`)
) AUTO_INCREMENT=9;

LOCK TABLES `Addresses` WRITE;
INSERT INTO `Addresses` VALUES (0001,'SW3 5DK','London'),(0002,'NW2 8JF','London'),(0003,'SE15 9IL','London'),(0004,'HA1 8JD','London'),(0005,'N2 8FX','London'),(0006,'75008','Paris'),(0007,'E9 2DP','London'),(0008,'EC1 3NA','London');
UNLOCK TABLES;

DROP TABLE IF EXISTS `Basket`;

CREATE TABLE `Basket` (
  `Basket_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Total` double NOT NULL,
  `Customer_ID` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Basket_ID`),
  KEY `which_customer_idx` (`Customer_ID`),
  CONSTRAINT `which_customer` FOREIGN KEY (`Customer_ID`) REFERENCES `Customer` (`Customer_ID`)
) AUTO_INCREMENT=6;

LOCK TABLES `Basket` WRITE;
INSERT INTO `Basket` VALUES (00001,168,00001),(00002,138,00002),(00003,100,00003),(00004,200,00004),(00005,216,00005);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Basket_Product`;

CREATE TABLE `Basket_Product` ( -- Used to link the 'Basket' and 'Product' tables
  `BP_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Basket_ID` int(5) unsigned zerofill NOT NULL,
  `Product_ID` int(6) unsigned zerofill NOT NULL,
  PRIMARY KEY (`BP_ID`),
  KEY `bp_Basket_idx` (`Basket_ID`),
  KEY `bp_Product_idx` (`Product_ID`),
  CONSTRAINT `bp_Basket` FOREIGN KEY (`Basket_ID`) REFERENCES `Basket` (`Basket_ID`),
  CONSTRAINT `bp_Product` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`)
) AUTO_INCREMENT=8;

LOCK TABLES `Basket_Product` WRITE;
INSERT INTO `Basket_Product` VALUES (00001,00001,000003),(00002,00001,000004),(00003,00002,000008),(00004,00003,000006),(00005,00004,000007),(00006,00005,000001),(00007,00005,000003);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Customer_Shipping`;

CREATE TABLE `Customer_Shipping` ( -- Each pair of Customer ID and Address_ID are given an ID so that they can be identified an referenced easily in the Address table
  `Ship_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Customer_ID` int(5) unsigned zerofill NOT NULL,
  `Address_ID` int(4) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Ship_ID`),
  KEY `customerFromShipping_idx` (`Customer_ID`),
  KEY `addressFromShippping_idx` (`Address_ID`),
  CONSTRAINT `addressFromShippping` FOREIGN KEY (`Address_ID`) REFERENCES `Addresses` (`Address_ID`),
  CONSTRAINT `customerFromShipping` FOREIGN KEY (`Customer_ID`) REFERENCES `Customer` (`Customer_ID`)
) AUTO_INCREMENT=23;

LOCK TABLES `Customer_Shipping` WRITE;
INSERT INTO `Customer_Shipping` VALUES (00015,00001,0001),(00016,00002,0002),(00017,00002,0003),(00018,00003,0004),(00019,00003,0005),(00020,00004,0006),(00021,00004,0007),(00022,00005,0008);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Payment_Type`;

CREATE TABLE `Payment_Type` (
  `Payment_ID` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Order_Date` date NOT NULL,
  `Order_ID` int(5) unsigned zerofill NOT NULL, /*As every payment is linked to a customer''s order */
  PRIMARY KEY (`Payment_ID`)
) AUTO_INCREMENT=6;

LOCK TABLES `Payment_Type` WRITE;
INSERT INTO `Payment_Type` VALUES (000001,'2019-08-06',00001),(000002,'2019-09-21',00002),(000003,'2019-10-10',00003),(000004,'2019-10-31',00004),(000005,'2020-01-06',00005);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Stores`;

CREATE TABLE `Stores` (
  `Store_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Address` varchar(50) NOT NULL DEFAULT 'Address',
  `Postcode` varchar(10) NOT NULL DEFAULT 'Postcode',
  `Phone_Number` varchar(20) NOT NULL DEFAULT 'Shop''s Phone Number',
  `Total_Employees` int(20) unsigned NOT NULL,
  PRIMARY KEY (`Store_ID`)
) AUTO_INCREMENT=5;

LOCK TABLES `Stores` WRITE;
INSERT INTO `Stores` VALUES (00001,'10 Earlham Street','WC2H 9LN','02039362694',5),(00002,'15 Brewer Street','W1F 0RJ','02039664043',4),(00003,'Haarlemmerstraat 70','1013 ET','+31202618921',3),(00004,'Bergmannstrasse 94','10961','+493056795707',3);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Employees`;

CREATE TABLE `employees` ( -- As 'Employees' is a multi-valued attribute there are many details to record for each employee
  `Employee_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,		
  `First_Name` varchar(50) NOT NULL DEFAULT 'Employee''s First Name',
  `Last_Name` varchar(50) NOT NULL DEFAULT 'Employee''s Last Name',
  `Phone_Number` varchar(45) NOT NULL DEFAULT 'Employee''s Phone Number',
  `Email` varchar(45) NOT NULL DEFAULT 'Employee''s Email',
  `Address` varchar(45) NOT NULL DEFAULT 'Employee''s House Address',
  `Role` varchar(45) NOT NULL DEFAULT 'Employee''s Job Role',
  `Store_ID` int(5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  constraint `employee_store` FOREIGN KEY (`Store_ID`) REFERENCES `Stores` (`Store_ID`)
) AUTO_INCREMENT=16;

LOCK TABLES `employees` WRITE;
INSERT INTO `employees` VALUES (00001,'Rio','Viernes-Gonzales','+447503281328','rio.gonzales@yahoo.com','75 Ladbroke Mews, W2 4LS, London','Optometrist',00001),(00002,'Pheobe','Revolta','07747294361','p_rev@gmail.com','2A Harrow Gardens, EC1 9JX, London','Sales Assistant',00001),(00003,'Madelaine','Donoher-Lambden','07527834010','m.d_l@outlook.com','44 Wallis Street, NW11 4KZ','Sales Assistant',00001),(00004,'Seoeon','Lee','07923749113','seoeon.lee@gmail.com','12 Chancery Lane, WC2A 1JA','Sales Assistant',00001),(00005,'Mitchell','Musso','07937528417','musso99@aol.com','38 Saturn Street, SW8 2MD','Store Manager',00001),(00006,'Gusteau','Pierre','+445368428642','gus_p@gmail.com','45 Edgware Road, W12 1CH','Optometrist',00002),(00007,'Miley','Cyrus','07903220922','m.cyrus@outlook.com','5L Mitchell Mews, SW5 9IL','Sales Assistant',00002),(00008,'Michael','Scott','+447334826591','m_scott22@aol.com','54 Pink Gardens, EC3 5TF','Store Manager',00002),(00009,'Matthew','James','07896455322','james.matt@gmail.com','42 Manor Park, E15 3BK','Sales Assistant',00002),(00010,'Neil','Patrick-Harris','+310054321649','neil_p.h@gmail.com','32 Strauss Avenue, 10036','Store Manager',00003),(00011,'Clark','Kent','+315539672178','kent_clark@aol.com','4L Lee Street, 10028','Optometrist',00003),(00012,'Ariana','Grande','+315427900436','a.grande@yahoo.com','77 Star Park, 10045','Sales Assistant',00003),(00013,'Mickey','Mouse','01513498654','mickey_mouse@gmail.com','3G Disney Lanes, 40067','Store Manager',00004),(00014,'Donald','Duck','01515961328','duck.don@aol.com','56 Coin Mews, 40043','Optometrist',00004),(00015,'Chloe','Sullivan','01517823495','sullivan_chloe@gmail.com','33 Lois Lane, 40069','Sales Assistant',00004);
UNLOCK TABLES;

DROP TABLE IF EXISTS `Stocklist`;

CREATE TABLE `Stocklist` ( 
  `Stocklist_ID` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT, -- Serves as providing a primary key for each pair of Store_ID and Product_ID
  `Store_ID` int(5) unsigned zerofill NOT NULL,
  `Product_ID` int(6) unsigned zerofill NOT NULL,
  `Quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Stocklist_ID`),
  KEY `stock_Product_idx` (`Product_ID`),
  CONSTRAINT `stock_Product` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`),
  constraint `stock_store` FOREIGN KEY (`Store_ID`) REFERENCES `Stores` (`Store_ID`)
) AUTO_INCREMENT=20;

LOCK TABLES `Stocklist` WRITE;
INSERT INTO `Stocklist` VALUES (00001,00001,000001,3),(00002,00001,000002,2),(00003,00001,000003,5),(00004,00001,000004,10),(00005,00002,000002,7),(00006,00002,000003,1),(00007,00002,000004,4),(00008,00002,000005,9),(00009,00002,000009,2),(00010,00003,000004,11),(00011,00003,000005,1),(00012,00003,000006,2),(00013,00003,000007,9),(00014,00003,000008,4),(00015,00004,000006,8),(00016,00004,000007,2),(00017,00004,000008,8),(00018,00004,000009,3),(00019,00004,000001,9);
UNLOCK TABLES;

