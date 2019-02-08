-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: flowershop
-- ------------------------------------------------------
-- Server version	5.7.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientcart`
--

DROP TABLE IF EXISTS `clientcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientcart` (
  `clientId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `productAmount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientcart`
--

LOCK TABLES `clientcart` WRITE;
/*!40000 ALTER TABLE `clientcart` DISABLE KEYS */;
INSERT INTO `clientcart` VALUES (1,2,3),(3,2,6);
/*!40000 ALTER TABLE `clientcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'rose',11,6),(2,'aster',7,2),(3,'amaranth',2,9),(4,'begonia',10,19),(5,'camellias',5,15),(6,'dahlia',12,16),(8,'zinnia',10,11),(9,'violets',11,16),(10,'buttercup',7,54),(11,'carnation',8,8),(12,'hibiscus',10,92);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `mail` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'admin','ad','admin'),(1,'ant','toor','toor'),(3,'Mary','mm','mary@mary'),(4,'Den','dd','den@den');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'flowershop'
--
/*!50003 DROP PROCEDURE IF EXISTS `cart_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cart_procedure`(in operation int,in cId int,in pId int,in pA int)
BEGIN
	case operation
		
        
        #get client cart
		when 1 then
		select * from flowershop.clientcart
        where clientId=cId;
        
        #set amount
        when 2 then
        SET SQL_SAFE_UPDATES = 0;
			UPDATE flowershop.clientcart
			SET productAmount = pA, productId = pId
			WHERE clientId = cId and productId = pId;
            select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id
            and clientcart.clientId = cId;
        
        #set amount and get all table
        when 21 then
        SET SQL_SAFE_UPDATES = 0;
			UPDATE flowershop.clientcart
			SET productAmount = pA, productId = pId
			WHERE clientId = cId and productId = pId;
            select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id;
        
        
        #add new item to cart    
		when 3 then 
			insert into flowershop.clientcart(clientId,productId,productAmount)
            values (cId,pId,pA);
            select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id
            and clientcart.clientId = cId;
        
		#add new item to cart and return all table
		when 31 then 
			insert into flowershop.clientcart(clientId,productId,productAmount)
            values (cId,pId,pA);
            select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id;
            
        
        
        #get all table
        when 4 then
			select * from flowershop.clientcart;
        
        #remove item 
        when 5 then
			delete from  flowershop.clientcart
			where clientId = cId and pId=productId;
			select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id
            and clientcart.clientId = cId;
            
		#remove item and get all the table
        when 51 then
			delete from  flowershop.clientcart
			where clientId = cId and pId=productId;
			select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id;
            
            
            
		#remove all items for some user
        when 6 then 
			delete from flowershop.clientcart
            where clientId = cId;
            select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id
            and clientcart.clientId = cId;
            
            
		#remove all items for some user and return all table
        when 7 then 
			delete from flowershop.clientcart
            where clientId = cId;
            select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id;
            
            
            
		#get table with flowers for user
        when 9 then 
			select * from flowershop.clientcart
            INNER JOIN products on clientcart.productId = products.id
            and clientcart.clientId = cId;
            
            
		else begin end;
	end case;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_Prod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_Prod`(in operation int,in idP int ,in nameP nvarchar(255),in priceP int,in amountP int)
BEGIN
	CASE operation
    
		#get all flowers
		WHEN 1 THEN
			SELECT * FROM flowershop.products;
            
		#get flower by name
		WHEN 2 THEN 
			SELECT * FROM flowershop.products
            WHERE name = nameP;
            
		#change amount
		WHEN 3 THEN 
		SET SQL_SAFE_UPDATES = 0;
			UPDATE flowershop.products
			SET amount = amountP
			WHERE name = nameP;
            SELECT * FROM flowershop.products;
            
		#change amount & price
		WHEN 4 THEN 
        SET SQL_SAFE_UPDATES = 0;
			UPDATE flowershop.products
			SET amount = amountP,price = priceP
			WHERE name = nameP;
            SELECT * FROM flowershop.products;
            
		#add flower
        when 5 then
        SET SQL_SAFE_UPDATES = 0;
			INSERT INTO flowershop.products(id,name,price,amount)
			values (idP,nameP,priceP,amountP);
            select * from flowershop.products;
			
		#remove flower
        when 6 then 
        SET SQL_SAFE_UPDATES = 0;
			DELETE FROM flowershop.products
			WHERE name=nameP;
            select * from flowershop.products;
            
		ELSE BEGIN END;
	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_procedure`(in operation int,in idU int ,in loginU varchar(255),in paswdU varchar(255),in mailU varchar(255))
BEGIN
	CASE operation
    
		#add new user
		WHEN 1 then
		SET SQL_SAFE_UPDATES = 0;
			INSERT INTO flowershop.users(id,login,password,mail)
			values (idU,loginU,paswdU,mailU);
            select * from flowershop.users;
        
        #update user data by id
        WHEN 2 then
        SET SQL_SAFE_UPDATES = 0;
			UPDATE flowershop.users
			SET login = loginU,password=paswdU,mail=mailU
            WHERE id = idU;
            select * from flowershop.users;
		
        #delete user by id
        when 3 then 
        SET SQL_SAFE_UPDATES = 0;
			DELETE FROM flowershop.users
			WHERE id=idU;
            select * from flowershop.users;

		#get user list
        WHEN 9 then 
			select * from flowershop.users;
        
        #get user by name
        when 4 then
			select * from flowershop.users
			where login = loginU;
	        
		ELSE BEGIN END; 
	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-22 14:02:11
