-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: starbase_nexus_api
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AspNetRoleClaims`
--

DROP TABLE IF EXISTS `AspNetRoleClaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AspNetRoleClaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(255) NOT NULL,
  `ClaimType` longtext,
  `ClaimValue` longtext,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetRoleClaims`
--

LOCK TABLES `AspNetRoleClaims` WRITE;
/*!40000 ALTER TABLE `AspNetRoleClaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `AspNetRoleClaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetRoles`
--

DROP TABLE IF EXISTS `AspNetRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AspNetRoles` (
  `Id` varchar(255) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `Name` varchar(256) DEFAULT NULL,
  `NormalizedName` varchar(256) DEFAULT NULL,
  `ConcurrencyStamp` longtext,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetRoles`
--

LOCK TABLES `AspNetRoles` WRITE;
/*!40000 ALTER TABLE `AspNetRoles` DISABLE KEYS */;
INSERT INTO `AspNetRoles` VALUES ('1da9ec55-3568-47f7-88cb-3b1caf71df5b','2021-09-02 09:02:07.762752',NULL,'Administrator','ADMINISTRATOR','ef09440c-c465-4660-b443-100cbc568bd7'),('88ee3172-947b-4ebb-b905-3481a72ce953','2021-09-02 18:04:51.969841',NULL,'Moderator','MODERATOR','523af5b6-9b82-4f2e-be24-65e6eb06e3d7');
/*!40000 ALTER TABLE `AspNetRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUserClaims`
--

DROP TABLE IF EXISTS `AspNetUserClaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AspNetUserClaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) NOT NULL,
  `ClaimType` longtext,
  `ClaimValue` longtext,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUserClaims`
--

LOCK TABLES `AspNetUserClaims` WRITE;
/*!40000 ALTER TABLE `AspNetUserClaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `AspNetUserClaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUserLogins`
--

DROP TABLE IF EXISTS `AspNetUserLogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AspNetUserLogins` (
  `LoginProvider` varchar(255) NOT NULL,
  `ProviderKey` varchar(255) NOT NULL,
  `ProviderDisplayName` longtext,
  `UserId` varchar(255) NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUserLogins`
--

LOCK TABLES `AspNetUserLogins` WRITE;
/*!40000 ALTER TABLE `AspNetUserLogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `AspNetUserLogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUserRoles`
--

DROP TABLE IF EXISTS `AspNetUserRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AspNetUserRoles` (
  `UserId` varchar(255) NOT NULL,
  `RoleId` varchar(255) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUserRoles`
--

LOCK TABLES `AspNetUserRoles` WRITE;
/*!40000 ALTER TABLE `AspNetUserRoles` DISABLE KEYS */;
INSERT INTO `AspNetUserRoles` VALUES ('dd1a4bcf-140b-4bb8-906b-93a18739812d','1da9ec55-3568-47f7-88cb-3b1caf71df5b'),('9a1999c7-b8f4-4870-830d-32be20f01e08','88ee3172-947b-4ebb-b905-3481a72ce953');
/*!40000 ALTER TABLE `AspNetUserRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUserTokens`
--

DROP TABLE IF EXISTS `AspNetUserTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AspNetUserTokens` (
  `UserId` varchar(255) NOT NULL,
  `LoginProvider` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Value` longtext,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUserTokens`
--

LOCK TABLES `AspNetUserTokens` WRITE;
/*!40000 ALTER TABLE `AspNetUserTokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `AspNetUserTokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUsers`
--

DROP TABLE IF EXISTS `AspNetUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AspNetUsers` (
  `Id` varchar(255) NOT NULL,
  `AboutMe` longtext,
  `AvatarUri` varchar(255) DEFAULT NULL,
  `DiscordId` varchar(255) DEFAULT NULL,
  `LastLogin` datetime(6) DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `UserName` varchar(256) DEFAULT NULL,
  `NormalizedUserName` varchar(256) DEFAULT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `NormalizedEmail` varchar(256) DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext,
  `SecurityStamp` longtext,
  `ConcurrencyStamp` longtext,
  `PhoneNumber` longtext,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_AspNetUsers_DiscordId` (`DiscordId`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUsers`
--

LOCK TABLES `AspNetUsers` WRITE;
/*!40000 ALTER TABLE `AspNetUsers` DISABLE KEYS */;
INSERT INTO `AspNetUsers` VALUES ('9a1999c7-b8f4-4870-830d-32be20f01e08',NULL,'https://cdn.discordapp.com/avatars/166564413984342016/e68e54fde55b46a63650460a02a09223.png','166564413984342016','2021-09-03 10:02:35.776548','2021-09-03 10:02:35.746981','2021-09-03 10:02:35.776565','PoLLi','POLLI','polli@starbase-nexus.net','POLLI@STARBASE-NEXUS.NET',1,'AQAAAAEAACcQAAAAEOTI/j9K1+55sAL0AdDkv25FEfbsIuwB+tqWvfTYGPfmnQ5nB8PwAiy1T39Vf64kdA==','3HRN7EXJRLPPC4UVM4MT3SX55X7YGHZ5','e2c8690c-0b1a-4347-a99f-d134aab2452e',NULL,0,0,NULL,0,0),('dd1a4bcf-140b-4bb8-906b-93a18739812d',NULL,'https://cdn.discordapp.com/avatars/311235761381048332/d354cd414ad33c9baadebf13841125a9.png','311235761381048332','2021-09-04 00:06:38.008186','2021-09-01 17:31:03.177149','2021-09-04 00:06:38.008197','WildChild85','WILDCHILD85','wildchild85@starbase-nexus.net','WILDCHILD85@STARBASE-NEXUS.NET',1,'AQAAAAEAACcQAAAAELK9Fl8xiCkSAPquVcd3Wso5TTSumuTKXjEk/BrhhR9TrhRAbfjW7Bug3q6cTSImTA==','SWAEMYRCDKMVQ4FFCM7WDTDNXX4MYD3X','a0dfc6e4-ee04-4105-9767-781938eeeddf',NULL,0,0,NULL,0,0);
/*!40000 ALTER TABLE `AspNetUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Authentication_RefreshTokens`
--

DROP TABLE IF EXISTS `Authentication_RefreshTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Authentication_RefreshTokens` (
  `Id` char(36) NOT NULL,
  `UserId` varchar(255) NOT NULL,
  `Token` varchar(255) NOT NULL,
  `ExpiresAt` datetime(6) NOT NULL,
  `IpAddress` varchar(255) DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `IX_Authentication_RefreshTokens_UserId` (`UserId`),
  CONSTRAINT `FK_Authentication_RefreshTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Authentication_RefreshTokens`
--

LOCK TABLES `Authentication_RefreshTokens` WRITE;
/*!40000 ALTER TABLE `Authentication_RefreshTokens` DISABLE KEYS */;
INSERT INTO `Authentication_RefreshTokens` VALUES ('08d96d6e-45d1-4614-875c-ca4f5496ebe2','dd1a4bcf-140b-4bb8-906b-93a18739812d','HrOMNxi2lzw4Qly+cid76EdJWI40g1M4no16BNdo/dU=','2021-09-15 17:31:03.470554','::1','2021-09-01 19:31:02.433143'),('08d96dee-cf07-451c-812a-643870b2276f','dd1a4bcf-140b-4bb8-906b-93a18739812d','uqIuktmlfRzPkmmAciqMa0NUQET97BFAGXjtDTjUScM=','2021-09-16 08:51:09.250933','::1','2021-09-02 10:51:09.029204'),('08d96dee-e323-4344-85a2-eaadf9f68c9f','dd1a4bcf-140b-4bb8-906b-93a18739812d','TgjG+ZVIxljZBEOiSIuvaGu4cRWZCGKyz4mkcErFT+Q=','2021-09-16 08:51:43.001402','::1','2021-09-02 10:51:42.740387'),('08d96df0-6784-41d5-84c7-3685d985d1d4','dd1a4bcf-140b-4bb8-906b-93a18739812d','B7CwQd6x//kYW1c9Qh4qVUvTXA9z8KQr45lMLaHuvpg=','2021-09-16 09:02:34.581357','::1','2021-09-02 11:02:34.347638'),('08d96df6-056c-4b70-8d93-21d507e19279','dd1a4bcf-140b-4bb8-906b-93a18739812d','S9F9FYUakNq76HTHAQ1Ib2LKFR1WClWClk1Y3ZIY6LU=','2021-09-16 09:42:46.989590','::1','2021-09-02 11:42:46.764697'),('08d96e1f-f860-4f57-8c1b-4a9303c9162e','dd1a4bcf-140b-4bb8-906b-93a18739812d','GslE5ZXB6i2Pk2PWGpYGUZmn+wqBTntEF+vE9N9a+70=','2021-09-16 14:43:03.963758','::1','2021-09-02 16:43:03.450767'),('08d96e2d-172e-4bd8-83ce-cbd3f745a8e2','dd1a4bcf-140b-4bb8-906b-93a18739812d','iJ51eQNo8EVIKRQC6viIKqTdXHM032dcck8x6IBvIE0=','2021-09-16 16:16:59.115684','::1','2021-09-02 18:16:58.565255'),('08d96e32-e54b-474b-86d3-2686d39dda88','dd1a4bcf-140b-4bb8-906b-93a18739812d','vNmHo5b0xgAFGQaOMCZog01g1hEi9SMcszMz1gKRmgw=','2021-09-16 16:58:32.398286','::1','2021-09-02 18:58:31.851643'),('08d96e39-f8b3-443e-8261-82cec121b1f5','dd1a4bcf-140b-4bb8-906b-93a18739812d','+EJ6kuhnpGl/2RTeIIDR/XU2ccGS1a3QsN69w4gaF5o=','2021-09-16 17:49:11.419224','::1','2021-09-02 19:49:10.903392'),('08d96e41-f096-4dfb-8489-3d3e4b3a09fa','dd1a4bcf-140b-4bb8-906b-93a18739812d','S+E12ms6DTbKNL0i4uwHq4LxkRZu7x+P0G/Lfajmh9M=','2021-09-16 18:46:13.787570','::1','2021-09-02 20:46:13.265216'),('08d96e5e-3f57-45a8-85b6-ced9eac3fcca','dd1a4bcf-140b-4bb8-906b-93a18739812d','/rB5DpvzMopJ5n/NgLjh5sjzB9GK+aGGqBoSJL1c3HA=','2021-09-16 22:08:51.806924','2.244.132.236','2021-09-03 00:08:51.872021'),('08d96e68-3f11-4c45-8e0c-9b92391c0973','dd1a4bcf-140b-4bb8-906b-93a18739812d','5Dx09vmMH/IMYvSlsjJxht7s+uNGjMfj6pDia+72Ido=','2021-09-16 23:20:26.319831','2.244.132.236','2021-09-03 01:20:26.376562'),('08d96eb8-5018-4e32-89bd-6ed5c8b3b2d5','dd1a4bcf-140b-4bb8-906b-93a18739812d','nBDpsudmizBVQljQf6VumIUEZtu33FyXibF+DrALJGI=','2021-09-17 08:53:34.647906','2.244.101.10','2021-09-03 10:53:34.650451'),('08d96ec1-f467-4d03-873d-d17cde580e8e','9a1999c7-b8f4-4870-830d-32be20f01e08','OzlbDPitP8CXU5lm2OuSwW4pZN1rxXIj2y57+Cjidgk=','2021-09-17 10:02:35.782226','88.153.89.130','2021-09-03 12:02:35.783731'),('08d96edb-e6c0-4750-877f-85d7aac8429e','dd1a4bcf-140b-4bb8-906b-93a18739812d','5WvZu4ECwn9KeI9e2H1mcmYXLHoQCV1svSqDrk14ys8=','2021-09-17 13:08:19.790082','2.244.101.10','2021-09-03 15:08:19.791839'),('08d96ee9-9a00-4cd3-83f5-a96a79f04376','dd1a4bcf-140b-4bb8-906b-93a18739812d','CPQuO7hnkrtPkwcznG6/MhQ3F07ha6YSh+FYqe/ok80=','2021-09-17 14:46:23.981215','2.244.101.10','2021-09-03 16:46:23.982978'),('08d96f01-a1f4-4538-8965-802eed483f97','dd1a4bcf-140b-4bb8-906b-93a18739812d','mWWY4zVZYUEfA6kvVI+HXJQ9+mT2Y04UL5Il+v2zM7w=','2021-09-17 17:38:25.242967','2.244.101.10','2021-09-03 19:38:25.244120'),('08d96f14-6675-4fed-8b68-e5396127c1ff','dd1a4bcf-140b-4bb8-906b-93a18739812d','LmX+cpFOSAqR/8e2pjiQlofZX3HvQejyCMJEaz3EIF0=','2021-09-17 19:52:45.867299','2.244.101.10','2021-09-03 21:52:45.868580'),('08d96f1b-a5cb-4373-8781-a0a73859e500','dd1a4bcf-140b-4bb8-906b-93a18739812d','ITkBNdhY87pZhXtrwT6Dz/VgNp/c109dee9IuGjB9QE=','2021-09-17 20:44:38.581095','2.244.101.10','2021-09-03 22:44:38.630560'),('08d96f28-5082-4368-8ceb-c11fb5377431','dd1a4bcf-140b-4bb8-906b-93a18739812d','vWen8zMan/j1ahqlg+9xShVtwfW8AMcH2U4/T/2bAs8=','2021-09-17 22:15:18.972075','2.244.101.10','2021-09-04 00:15:18.974088'),('08d96f2d-4d94-4ba7-8fac-71304d0ae45c','dd1a4bcf-140b-4bb8-906b-93a18739812d','1Rw+otgctpFxIlvriN7SUAcn8nlHHCQNuoZN91sC9bI=','2021-09-17 22:51:01.543917','2.244.101.10','2021-09-04 00:51:01.545824');
/*!40000 ALTER TABLE `Authentication_RefreshTokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InGame_ItemCategories`
--

DROP TABLE IF EXISTS `InGame_ItemCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InGame_ItemCategories` (
  `Id` char(36) NOT NULL,
  `Description` longtext,
  `Name` varchar(255) NOT NULL,
  `ParentId` char(36) DEFAULT NULL,
  `OldId` int unsigned DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_InGame_ItemCategories_ParentId` (`ParentId`),
  CONSTRAINT `FK_InGame_ItemCategories_InGame_ItemCategories_ParentId` FOREIGN KEY (`ParentId`) REFERENCES `InGame_ItemCategories` (`Id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InGame_ItemCategories`
--

LOCK TABLES `InGame_ItemCategories` WRITE;
/*!40000 ALTER TABLE `InGame_ItemCategories` DISABLE KEYS */;
INSERT INTO `InGame_ItemCategories` VALUES ('08d96e44-f906-4d87-8315-bbb4c9c79b53',NULL,'Beams',NULL,NULL,'2021-09-02 19:07:56.485999',NULL),('08d96e45-0628-4cb3-8ed3-44aa4cbcbcb6',NULL,'Angled Beams','08d96e44-f906-4d87-8315-bbb4c9c79b53',NULL,'2021-09-02 19:08:18.477413',NULL),('08d96e45-0ed0-4527-80c9-8fff28744fc4',NULL,'Corner Beams','08d96e44-f906-4d87-8315-bbb4c9c79b53',NULL,'2021-09-02 19:08:32.996947',NULL),('08d96e45-158c-459f-8878-35e8bae70c81',NULL,'Intersection Beams','08d96e44-f906-4d87-8315-bbb4c9c79b53',NULL,'2021-09-02 19:08:44.295506',NULL),('08d96e45-1b0b-4d59-8024-72792c3eed5f',NULL,'Special Beams','08d96e44-f906-4d87-8315-bbb4c9c79b53',NULL,'2021-09-02 19:08:53.519644',NULL),('08d96e45-22ed-4377-8696-8d54c905ca59',NULL,'Straight Beams','08d96e44-f906-4d87-8315-bbb4c9c79b53',NULL,'2021-09-02 19:09:06.740723',NULL),('08d96e45-32e6-4259-803b-cff10e4c3309',NULL,'Decorative Plates',NULL,NULL,'2021-09-02 19:09:33.537929',NULL),('08d96e45-38ff-4258-882b-ee334d671167',NULL,'Devices',NULL,NULL,'2021-09-02 19:09:43.768079',NULL),('08d96e45-3dff-43af-8047-b86f55551364',NULL,'Cargo','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:09:52.157231',NULL),('08d96e45-58cb-4b68-864b-d4d937cc1f1a',NULL,'Controls','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:10:37.118078',NULL),('08d96e45-666b-43aa-8ea6-668c1e849783',NULL,'Crafting','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:10:59.973869',NULL),('08d96e45-6c6e-4f64-8aa2-20ca1ed8b29e',NULL,'Doors','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:11:10.064662',NULL),('08d96e45-73ed-42d7-891e-733b9451b78a',NULL,'Lamps','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:11:22.635879',NULL),('08d96e45-7c46-41b6-8c6a-c69cdda898dc',NULL,'Navigation','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:11:36.640461',NULL),('08d96e45-8754-4080-88f6-5e07591875f2',NULL,'Networking','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:11:55.186652',NULL),('08d96e45-8e09-4864-816c-f43800e9ea99',NULL,'Utility','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:12:06.442425',NULL),('08d96e45-94f7-44d6-84de-e6e50c80f6be',NULL,'YOLOL','08d96e45-38ff-4258-882b-ee334d671167',NULL,'2021-09-02 19:12:18.067046',NULL),('08d96e45-9f39-4f94-824f-8f4958cdcd46',NULL,'Furnishings',NULL,NULL,'2021-09-02 19:12:35.281198',NULL),('08d96e45-a57a-451c-8075-0465e2d2bdb6',NULL,'Furniture','08d96e45-9f39-4f94-824f-8f4958cdcd46',NULL,'2021-09-02 19:12:45.769222',NULL),('08d96e45-aca0-4d47-807a-9431707b56a1',NULL,'Hardpoints',NULL,NULL,'2021-09-02 19:12:57.765656',NULL),('08d96e45-b306-444e-84aa-d8a8fe1d26a0',NULL,'Machinery',NULL,NULL,'2021-09-02 19:13:08.496788','2021-09-02 19:13:15.023559'),('08d96e45-bd9f-4a28-8978-aa65d916e108',NULL,'Launchers','08d96e45-b306-444e-84aa-d8a8fe1d26a0',NULL,'2021-09-02 19:13:26.279094',NULL),('08d96e45-c457-4db5-8f37-6cf59fde4607',NULL,'Power','08d96e45-b306-444e-84aa-d8a8fe1d26a0',NULL,'2021-09-02 19:13:37.552751','2021-09-02 19:13:59.696860'),('08d96e45-cc0a-48fb-89a3-c8f46c60574b',NULL,'Thrusters','08d96e45-b306-444e-84aa-d8a8fe1d26a0',NULL,'2021-09-02 19:13:50.467950',NULL),('08d96e45-df4d-496c-8eb8-28d75055b5c3',NULL,'Tools','08d96e45-b306-444e-84aa-d8a8fe1d26a0',NULL,'2021-09-02 19:14:22.783947',NULL),('08d96e45-e596-4b47-8cef-2dfd753f8b40',NULL,'Utility','08d96e45-b306-444e-84aa-d8a8fe1d26a0',NULL,'2021-09-02 19:14:33.329434',NULL),('08d96e45-eba5-4c19-80bb-7071906b7933',NULL,'Weapons','08d96e45-b306-444e-84aa-d8a8fe1d26a0',NULL,'2021-09-02 19:14:43.494414',NULL),('08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'Plates',NULL,NULL,'2021-09-02 19:14:54.869142',NULL),('08d96e46-0540-4ab4-8379-834c352f45ae',NULL,'Angled Plates','08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'2021-09-02 19:15:26.452687',NULL),('08d96e46-16ac-47e3-8404-d68151607a35',NULL,'Basic Plates','08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'2021-09-02 19:15:55.680592',NULL),('08d96e46-1e85-417b-841b-d41330f541f3',NULL,'Corner Plates','08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'2021-09-02 19:16:08.844136',NULL),('08d96e46-26a3-46c7-8003-6f3b192841cb',NULL,'Curved Plates','08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'2021-09-02 19:16:22.464686',NULL),('08d96e46-3f50-4e68-82c2-2fc9c7f16029',NULL,'Pyramid Plates','08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'2021-09-02 19:17:03.866904',NULL),('08d96e46-467d-44cc-84aa-be9a388c8832',NULL,'Special Plates','08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'2021-09-02 19:17:15.901951',NULL),('08d96e46-4da8-4c8a-8d56-e96b9fbc5c8f',NULL,'Triangle Plates','08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'2021-09-02 19:17:27.930955',NULL),('08d96e46-5793-4e89-8d74-206c04ec0cea',NULL,'Window Plates','08d96e45-f26d-466e-81b1-6bc3473bc389',NULL,'2021-09-02 19:17:44.571362',NULL),('08d96e46-5e8b-47ac-8237-5852756021c5',NULL,'Windows',NULL,NULL,'2021-09-02 19:17:56.260169',NULL);
/*!40000 ALTER TABLE `InGame_ItemCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InGame_Items`
--

DROP TABLE IF EXISTS `InGame_Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InGame_Items` (
  `Id` char(36) NOT NULL,
  `Description` longtext NOT NULL,
  `Name` varchar(255) NOT NULL,
  `IconUri` varchar(255) DEFAULT NULL,
  `ItemCategoryId` char(36) NOT NULL,
  `WikiUri` varchar(255) DEFAULT NULL,
  `Mass` float DEFAULT NULL,
  `CorrosionResistance` float DEFAULT NULL,
  `PrimaryMaterialId` char(36) DEFAULT NULL,
  `ElectricInput` float DEFAULT NULL,
  `ElectricOutput` float DEFAULT NULL,
  `ElectricityConversionBonusFactor` float DEFAULT NULL,
  `ElectricCapacity` float DEFAULT NULL,
  `PropellantInput` float DEFAULT NULL,
  `PropellantOutput` float DEFAULT NULL,
  `PropellantConversionBonusFactor` float DEFAULT NULL,
  `PropellantCapacity` float DEFAULT NULL,
  `ThrustPower` float DEFAULT NULL,
  `Tier` int DEFAULT NULL,
  `FuelCapacity` float DEFAULT NULL,
  `FuelInput` float DEFAULT NULL,
  `HeatGeneration` float DEFAULT NULL,
  `ElectricityPerShot` float DEFAULT NULL,
  `ElectricityPerRecharge` float DEFAULT NULL,
  `HeatGenerationPerShot` float DEFAULT NULL,
  `HeatDissipation` float DEFAULT NULL,
  `MinMuzzleVelocity` float DEFAULT NULL,
  `MaxMuzzleVelocity` float DEFAULT NULL,
  `RateOfFire` float DEFAULT NULL,
  `ChargeCapacity` float DEFAULT NULL,
  `MagazineCapacity` float DEFAULT NULL,
  `ProjectileMass` float DEFAULT NULL,
  `ProjectileEnergy` float DEFAULT NULL,
  `ProjectileLifetime` float DEFAULT NULL,
  `ResearchPointsCube` float DEFAULT NULL,
  `ResearchPointsPower` float DEFAULT NULL,
  `ResearchPointsShield` float DEFAULT NULL,
  `ResearchPointsGear` float DEFAULT NULL,
  `OldId` int unsigned DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `WarmupTime` float DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_InGame_Items_ItemCategoryId` (`ItemCategoryId`),
  KEY `IX_InGame_Items_PrimaryMaterialId` (`PrimaryMaterialId`),
  CONSTRAINT `FK_InGame_Items_InGame_ItemCategories_ItemCategoryId` FOREIGN KEY (`ItemCategoryId`) REFERENCES `InGame_ItemCategories` (`Id`) ON DELETE RESTRICT,
  CONSTRAINT `FK_InGame_Items_InGame_Materials_PrimaryMaterialId` FOREIGN KEY (`PrimaryMaterialId`) REFERENCES `InGame_Materials` (`Id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InGame_Items`
--

LOCK TABLES `InGame_Items` WRITE;
/*!40000 ALTER TABLE `InGame_Items` DISABLE KEYS */;
INSERT INTO `InGame_Items` VALUES ('08d96f16-1828-496f-8c26-62d01f096805','The small 3D printer is a smaller, but slower version of the large printer. It has an integrated utility box and can accept it\'s own fuel rod, or use power provided from other sources','Small Printer','https://wiki.starbasegame.com/images/thumb/8/8c/3D_Printer_Small.png/486px-3D_Printer_Small.png','08d96e45-38ff-4258-882b-ee334d671167','https://wiki.starbasegame.com/index.php/3D_Printer',32128.8,439,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',10000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:04:53.546729','2021-09-03 20:12:51.689699',NULL),('08d96f16-80e1-4758-889c-435edc6fb209','The large 3D printer requires a Utility box to connect to a station\'s power grid and to access the station inventory for material and to output complete parts.','Large Printer','https://wiki.starbasegame.com/images/thumb/1/15/3D_printer_large.png/800px-3D_printer_large.png','08d96e45-38ff-4258-882b-ee334d671167','https://wiki.starbasegame.com/index.php/3D_Printer',721414,474,'08d96e2f-d960-480b-8a86-af79c60023c1',10000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:07:49.186296',NULL,NULL),('08d96f1b-a731-4c66-811d-10fa59738933','The audio signal device is used to add audio feedback to spaceships and station devices. They support a plethora of options to customize the playback of audio, and can be wired to directly via their sockets or via a modular interface on their backside.','Audio signal device mark 1','https://wiki.starbasegame.com/images/2/20/Audio_signal_device_mark_1.png','08d96e45-58cb-4b68-864b-d4d937cc1f1a','https://wiki.starbasegame.com/index.php/Audio_signal_device_mark_1',64.33,470,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:44:40.951002','2021-09-03 22:15:21.021848',NULL),('08d96f1b-d3d0-494b-8215-95369cf433ce','A battery is a storage device for electrical energy, and currently is available in just one size. This battery holds up to 10,000 energy units and has two sockets on opposite sides for ease-of-use, but are also semi-modular and can share connections with batteries placed immediately adjacent to them. Small ships can run entirely on batteries, but most ships use them as a buffer to handle periods of higher energy drain while their generators are warming up. Batteries with energy stored tend to explode when damaged, so designers should be careful about how many batteries they place near one another.','Small Rechargebale Battery','https://wiki.starbasegame.com/images/1/13/Battery_nov_2019.png','08d96e45-c457-4db5-8f37-6cf59fde4607','https://wiki.starbasegame.com/index.php/Battery',3236.64,790,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',10000,10000,NULL,1000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:45:55.810517','2021-09-03 22:16:12.109703',NULL),('08d96f1c-3ffb-4fbf-8194-c72a95de75e4','The box thruster body is a device designed to house other components required for the box thruster to function, and to provide convenient mounting points along its hull. Unlike triangle thrusters, the box thruster body has no interfaces to share propellant and power with adjacent thrusters, and each requires its own hardpoint to function.','Box Thruster Tier 1 Body','https://wiki.starbasegame.com/images/thumb/d/d8/Box_thruster_body%2C_tier_1.png/1280px-Box_thruster_body%2C_tier_1.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Box_thruster_body',10362,280,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',240,NULL,NULL,NULL,30,NULL,NULL,NULL,400000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:48:57.288518','2021-09-03 22:30:41.965093',NULL),('08d96f1c-5fb9-4913-8385-b44e74d80a29','The box thruster body is a device designed to house other components required for the box thruster to function, and to provide convenient mounting points along its hull. Unlike triangle thrusters, the box thruster body has no interfaces to share propellant and power with adjacent thrusters, and each requires its own hardpoint to function.','Box Thruster Tier 2 Body','https://wiki.starbasegame.com/images/thumb/2/2d/Box_thruster_body%2C_tier_2.png/1280px-Box_thruster_body%2C_tier_2.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Box_thruster_body',10117.8,425,'08d96e2e-8159-4985-89d4-f6f4550f3f9c',216,NULL,NULL,NULL,27,NULL,NULL,NULL,440000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:49:50.540494','2021-09-03 22:31:53.662197',NULL),('08d96f1c-919e-4adf-853f-8d4346dd5f6d','The box thruster body is a device designed to house other components required for the box thruster to function, and to provide convenient mounting points along its hull. Unlike triangle thrusters, the box thruster body has no interfaces to share propellant and power with adjacent thrusters, and each requires its own hardpoint to function.','Box Thruster Tier 3 Body','https://wiki.starbasegame.com/images/thumb/4/4e/Box_thruster_body%2C_tier_3.png/1280px-Box_thruster_body%2C_tier_3.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Box_thruster_body',8812.58,411,'08d96e2f-932b-4f3b-8431-3c8a0d5a17bf',360,NULL,NULL,NULL,42,NULL,NULL,NULL,520000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:51:14.250168','2021-09-03 22:33:11.054702',NULL),('08d96f1c-b732-4f6e-8f90-4d64ff491831','The box thruster combustion chamber is a device that burns propellant to produce thrust force.','Box thruster combustion chamber','https://wiki.starbasegame.com/images/thumb/6/68/Box_thruster_combustion_chamber%2C_tier_1.png/1024px-Box_thruster_combustion_chamber%2C_tier_1.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Box_thruster_combustion_chamber',7223.07,295,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,41.28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:52:17.297702','2021-09-03 22:34:20.000860',NULL),('08d96f1d-01bc-4d79-821f-a057f6ac3168','The box thruster nozzle is a device that directs the force generated by the combustion chamber in order to produce usable thrust force.','Box Thruster Tier 1 Nozzle','https://wiki.starbasegame.com/images/3/3b/Box_thruster_nozzle%2C_tier_1.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Box_thruster_nozzle',5644.87,230,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,100000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:54:22.352686','2021-09-03 22:35:35.054033',NULL),('08d96f1d-1abc-4a82-85c7-dc14b01172de','The box thruster nozzle is a device that directs the force generated by the combustion chamber in order to produce usable thrust force.','Box Thruster Tier 2 Nozzle','https://wiki.starbasegame.com/images/4/4d/Box_thruster_nozzle%2C_tier_2.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Box_thruster_nozzle',5497.66,410,'08d96e2e-8159-4985-89d4-f6f4550f3f9c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:55:04.294563','2021-09-03 22:36:16.915355',NULL),('08d96f1d-3570-4d5f-8671-a075c3e0ea1f','The box thruster nozzle is a device that directs the force generated by the combustion chamber in order to produce usable thrust force.','Box Thruster Tier 3 Nozzle','https://wiki.starbasegame.com/images/d/dd/Box_thruster_nozzle%2C_tier_3.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Box_thruster_nozzle',5341.72,300,'08d96e2f-932b-4f3b-8431-3c8a0d5a17bf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,130000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 20:55:49.096264','2021-09-03 22:36:47.416683',NULL),('08d96f2c-0bbf-4b86-82ab-ccb0486293ca','Propellant tanks are the vessels used to store propellant, which thrusters use to produce force. They come in a variety of sizes, and are constructed of the propellant tank and two structural supports, which also provide socket access to the propellant tank itself. These support pieces also have one modular device interface per piece, and the propellant tank can also convey other resources if the tank is placed in-line with a pipe network.','Large Hydrogen Propellant Tank','https://wiki.starbasegame.com/images/1/16/H2_Propellant_tank_%28large%29.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Propellant_tank',16224.6,710,'08d96e2e-8159-4985-89d4-f6f4550f3f9c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,9000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 22:42:01.599705',NULL,NULL),('08d96f2c-4d1d-404d-843e-ddba2d4c3e9b','Propellant tanks are the vessels used to store propellant, which thrusters use to produce force. They come in a variety of sizes, and are constructed of the propellant tank and two structural supports, which also provide socket access to the propellant tank itself. These support pieces also have one modular device interface per piece, and the propellant tank can also convey other resources if the tank is placed in-line with a pipe network.','Large Hydrogen Propellant Tank Support','https://wiki.starbasegame.com/images/1/16/H2_Propellant_tank_%28large%29.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Propellant_tank',3760.9,380,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,50000,50000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 22:43:51.263048',NULL,NULL),('08d96f2c-a9cd-4bbb-8e4b-ec491767bfcc','Maneuver thrusters are a type of thruster used almost exclusively to provide attitude control to spaceships, allowing them to maneuver. Though they produce relatively little thrust, maneuver thrusters are simple devices with a low profile, which makes them attractive options for smaller spacecraft.','Maneuver Thruster Tier 1','https://wiki.starbasegame.com/images/5/53/Maneuver_thruster%2C_tier_1_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Maneuver_thruster',553.35,305,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',40,NULL,NULL,NULL,15,NULL,NULL,NULL,40000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 22:46:26.771557',NULL,NULL),('08d96f2c-e100-486f-856d-df06722a39aa','Maneuver thrusters are a type of thruster used almost exclusively to provide attitude control to spaceships, allowing them to maneuver. Though they produce relatively little thrust, maneuver thrusters are simple devices with a low profile, which makes them attractive options for smaller spacecraft.','Maneuver Thruster Tier 2','https://wiki.starbasegame.com/images/1/11/Maneuver_thruster%2C_tier_2_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Maneuver_thruster',549.4,470,'08d96e2e-8159-4985-89d4-f6f4550f3f9c',36,NULL,NULL,NULL,13.5,NULL,NULL,NULL,44000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 22:47:59.379137',NULL,NULL),('08d96f2d-1162-4cca-824d-5d5a11c4efab','Maneuver thrusters are a type of thruster used almost exclusively to provide attitude control to spaceships, allowing them to maneuver. Though they produce relatively little thrust, maneuver thrusters are simple devices with a low profile, which makes them attractive options for smaller spacecraft.','Maneuver Thruster Tier 3','https://wiki.starbasegame.com/images/0/0c/Maneuver_thruster%2C_tier_3_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Maneuver_thruster',487.98,295,'08d96e2f-932b-4f3b-8431-3c8a0d5a17bf',60,NULL,NULL,NULL,18,NULL,NULL,NULL,52000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 22:49:20.553805',NULL,NULL),('08d96f2d-4ebb-4f82-8051-e5ff74cd5968','Propellant tanks are the vessels used to store propellant, which thrusters use to produce force. They come in a variety of sizes, and are constructed of the propellant tank and two structural supports, which also provide socket access to the propellant tank itself. These support pieces also have one modular device interface per piece, and the propellant tank can also convey other resources if the tank is placed in-line with a pipe network.','Medium Hydrogen Propellant Tank','https://wiki.starbasegame.com/images/d/db/H2_Propellant_tank_%28med%29.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Propellant_tank',7332.4,710,'08d96e2e-8159-4985-89d4-f6f4550f3f9c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,4000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 22:51:03.479223',NULL,NULL),('08d96f2d-7fa5-476f-8a60-11e2ccc4cab7','Propellant tanks are the vessels used to store propellant, which thrusters use to produce force. They come in a variety of sizes, and are constructed of the propellant tank and two structural supports, which also provide socket access to the propellant tank itself. These support pieces also have one modular device interface per piece, and the propellant tank can also convey other resources if the tank is placed in-line with a pipe network.','Medium Hydrogen Propellant Tank','https://wiki.starbasegame.com/images/d/db/H2_Propellant_tank_%28med%29.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Propellant_tank',1676.22,380,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,50000,50000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 22:52:25.540106',NULL,NULL),('08d96f30-a825-45fc-86d1-3c79fdaed555','The plasma thruster capacitor is a device that mounts to the capacitor struct of a plasma thruster. They store vast amounts of charge, and four of them are required for a properly assembled plasma thruster.','Plasma Thruster Capacitor','https://wiki.starbasegame.com/images/1/1a/Plasma_thruster%2C_capacitor.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_capacitor',11786,668,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:15:01.992998',NULL,NULL),('08d96f31-2678-4372-8045-5c2c08b469cc','The plasma thruster capacitor struct is a device that mounts capacitors to the plasma thruster. Two of them are required for the proper construction of a plasma thruster, bolted around the core module of the thruster.','Plasma Thruster Capacitor Struct','https://wiki.starbasegame.com/images/1/1c/Plasma_thruster%2C_capacitor_struct.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_capacitor_struct',22779.2,365,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:18:33.913310',NULL,NULL),('08d96f31-66ae-4170-8a04-6a91dfcae13d','The plasma thruster core is the device responsible for generating the thrust force of a plasma thruster, in conjunction with the engines. Just one is required for the proper assembly of a plasma thruster.','Plasma Thruster Core','https://wiki.starbasegame.com/images/c/c0/Plasma_thruster%2C_core.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_core',43056.9,494,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:20:21.640852',NULL,60),('08d96f32-0564-44f7-803e-e6eb052427f9','The plasma thruster engine is one of the components of a plasma thruster that corroborate to produce thrust. A properly assembled plasma thruster requires four of these to function, and they are assembled in 2×2 pattern.','Plasma Thruster Engine','https://wiki.starbasegame.com/images/b/b0/Plasma_thruster%2C_engine.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_engine',39736.1,510,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',NULL,NULL,NULL,NULL,NULL,NULL,0.05,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:24:47.914765',NULL,NULL),('08d96f32-c776-44f9-8dda-7a4e1b164fda','The plasma thruster frame is a component of the plasma thruster that mounts the superconductors to the engine of the thruster. Four of these are required for a properly assembled plasma thruster, arranged in a 2×2 pattern.','Plasma Thruster Frame','https://wiki.starbasegame.com/images/a/a4/Plasma_thruster%2C_frame.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_frame',34942.7,440,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',NULL,NULL,0.0725,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:30:13.510633',NULL,NULL),('08d96f33-263b-4e64-883f-ad9622d885c4','The plasma thruster nozzle is a component of the plasma thruster that is mounted at the very end of the superconductor tunnel. They serve to direct the force of a plasma thruster, and two of these are needed for a properly assembled plasma thruster.','Plasma Thruster Nozzle','https://wiki.starbasegame.com/images/1/11/Plasma_thruster%2C_nozzle.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_nozzle',25805.3,450,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',456.65,NULL,NULL,NULL,124,NULL,NULL,NULL,2000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:32:52.511395','2021-09-03 23:44:27.517575',NULL),('08d96f33-749e-4c6c-8989-0ae5218023bc','The plasma thruster nozzle collar is a component of the plasma thruster that goes between the frame and the superconductor assembly. Two of these are required for a properly assembled plasma thruster.','Plasma Thruster Nozzle Collar','https://wiki.starbasegame.com/images/f/fb/Plasma_thruster%2C_nozzle_collar.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_nozzle_collar',40444.3,470,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:35:04.021885',NULL,NULL),('08d96f33-adf3-49a0-8c79-854df1d90889','The plasma thruster superconductors are responsible for the magnification of the thrust force generated by the core. They come in forms with and without struts, and complete superconductor rings (composed of four superconductor parts) can be stacked linearly to add an additional 7,000,000 thrust per ring.','Plasma Thruster Superconductor','https://wiki.starbasegame.com/images/4/41/Plasma_thruster%2C_superconductor.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_superconductor',45253,521,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',220,NULL,NULL,NULL,96.5,NULL,NULL,NULL,1750000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:36:40.207751','2021-09-03 23:45:32.403379',NULL),('08d96f33-d769-45ef-8269-76fcb782118b','The plasma thruster superconductors are responsible for the magnification of the thrust force generated by the core. They come in forms with and without struts, and complete superconductor rings (composed of four superconductor parts) can be stacked linearly to add an additional 7,000,000 thrust per ring.','Plasma Thruster Superconductor Struct','https://wiki.starbasegame.com/images/e/ed/Plasma_thruster%2C_superconductor_struct.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Plasma_thruster_superconductor',48344.2,521,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',220,NULL,NULL,NULL,96.5,NULL,NULL,NULL,1750000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:37:49.766139','2021-09-03 23:45:59.803728',NULL),('08d96f35-4c8f-4386-8161-6a8d4ad9c43a','Propellant tanks are the vessels used to store propellant, which thrusters use to produce force. They come in a variety of sizes, and are constructed of the propellant tank and two structural supports, which also provide socket access to the propellant tank itself. These support pieces also have one modular device interface per piece, and the propellant tank can also convey other resources if the tank is placed in-line with a pipe network.','Small Hydrogen Propellant Tank','https://wiki.starbasegame.com/images/2/22/H2_Propellant_tank_%28sm%29.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Propellant_tank',2368.97,360,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:48:15.804340',NULL,NULL),('08d96f35-772d-4bd6-8e82-0a8cb401abc0','Propellant tanks are the vessels used to store propellant, which thrusters use to produce force. They come in a variety of sizes, and are constructed of the propellant tank and two structural supports, which also provide socket access to the propellant tank itself. These support pieces also have one modular device interface per piece, and the propellant tank can also convey other resources if the tank is placed in-line with a pipe network.','Small Hydrogen Propellant Tank Support','https://wiki.starbasegame.com/images/2/22/H2_Propellant_tank_%28sm%29.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Propellant_tank',1054.44,380,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,50000,50000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:49:27.307511',NULL,NULL),('08d96f36-a6eb-4c63-844e-8c554416a160','The electricity converter is a device that takes power from a ship\'s power network and converts it into local power, which can be used by thrusters.','Thruster Electricity Converter Tier 1','https://wiki.starbasegame.com/images/1/1e/Thruster_electricity_converter%2C_tier_1_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Thruster_electricity_converter',171.22,420,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,0.25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:57:56.902669','2021-09-03 23:59:22.953239',NULL),('08d96f36-d62a-410e-8e0c-4acb4127b6a3','The electricity converter is a device that takes power from a ship\'s power network and converts it into local power, which can be used by thrusters.','Thruster Electricity Converter Tier 2','https://wiki.starbasegame.com/images/e/e2/Thruster_electricity_converter%2C_tier_2_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Thruster_electricity_converter',162.12,500,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,0.3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-03 23:59:16.163878',NULL,NULL),('08d96f36-fe3d-46ee-8dcb-108b554eeefc','The electricity converter is a device that takes power from a ship\'s power network and converts it into local power, which can be used by thrusters.','Thruster Electricity Converter Tier3','https://wiki.starbasegame.com/images/e/e6/Thruster_electricity_converter%2C_tier_3_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Thruster_electricity_converter',160.23,330,'08d96e2f-c54a-48db-89b2-1baaa0d93c20',NULL,NULL,0.35,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:00:23.399496','2021-09-04 00:00:29.877479',NULL),('08d96f37-2e2e-48d1-8ea8-a9b837e085bb','The gas converter is a device that handles the ingest of propellant, and prepares it for burning in the combustion chamber of a thruster.','Thruster Propellant Converter Tier 1','https://wiki.starbasegame.com/images/7/7e/Thruster_gas_converter%2C_tier_1_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Thruster_gas_converter',191.2,420,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,NULL,NULL,0.2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:01:43.832606',NULL,NULL),('08d96f37-52af-4b34-8427-1f3e7e59f52e','The gas converter is a device that handles the ingest of propellant, and prepares it for burning in the combustion chamber of a thruster.','Thruster Propellant Converter Tier 2','https://wiki.starbasegame.com/images/d/dd/Thruster_gas_converter%2C_tier_2_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Thruster_gas_converter',191.95,500,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,NULL,NULL,0.25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:02:45.077163',NULL,NULL),('08d96f37-9104-47ac-825a-2ecf111bdb11','The gas converter is a device that handles the ingest of propellant, and prepares it for burning in the combustion chamber of a thruster.','Thruster Propellant Converter Tier 3','https://wiki.starbasegame.com/images/8/86/Thruster_gas_converter%2C_tier_3_updated.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Thruster_gas_converter',189.19,510,'08d96e2f-932b-4f3b-8431-3c8a0d5a17bf',NULL,NULL,NULL,NULL,NULL,NULL,0.35,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:04:29.651429',NULL,NULL),('08d96f37-dd8e-4f16-8d59-bd006f2a22ef','The triangle thruster body is a device designed to house other components required for the triangle thruster to function, and to provide convenient mounting points along its hull. The triangle thruster body is unique in that it also contains three resource ports that can share propellant and electricity with adjacent thrusters, enabling the construction of larger thruster banks that all operate from the same hardpoint. However, when triangle thrusters are assembled this way, they will always act as one thruster, and individual thrusters in the array cannot fire without also firing the rest of the thruster bank.','Triangle Thruster Base Tier 1','https://wiki.starbasegame.com/images/8/8d/Triangle_thruster_base%2C_tier_1.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Triangle_thruster_body',7030.76,280,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',110,NULL,NULL,NULL,27,NULL,NULL,NULL,240000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:06:38.065587',NULL,NULL),('08d96f38-22ec-44d9-88d3-2731aeec164e','The triangle thruster body is a device designed to house other components required for the triangle thruster to function, and to provide convenient mounting points along its hull. The triangle thruster body is unique in that it also contains three resource ports that can share propellant and electricity with adjacent thrusters, enabling the construction of larger thruster banks that all operate from the same hardpoint. However, when triangle thrusters are assembled this way, they will always act as one thruster, and individual thrusters in the array cannot fire without also firing the rest of the thruster bank.','Triangle Thruster Base Tier 2','https://wiki.starbasegame.com/images/7/79/Triangle_thruster_base%2C_tier_2.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Triangle_thruster_body',6435.93,505,'08d96e2e-8159-4985-89d4-f6f4550f3f9c',99,NULL,NULL,NULL,24.3,NULL,NULL,NULL,264000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:08:34.440224',NULL,NULL),('08d96f38-5d4b-45bb-8aef-e7898082c1db','The triangle thruster body is a device designed to house other components required for the triangle thruster to function, and to provide convenient mounting points along its hull. The triangle thruster body is unique in that it also contains three resource ports that can share propellant and electricity with adjacent thrusters, enabling the construction of larger thruster banks that all operate from the same hardpoint. However, when triangle thrusters are assembled this way, they will always act as one thruster, and individual thrusters in the array cannot fire without also firing the rest of the thruster bank.','Triangle Thruster Base Tier 3','https://wiki.starbasegame.com/images/f/f4/Triangle_thruster_base%2C_tier_3.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Triangle_thruster_body',5979.49,410,'08d96e2f-932b-4f3b-8431-3c8a0d5a17bf',165,NULL,NULL,NULL,37.8,NULL,NULL,NULL,312000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:10:12.371216',NULL,NULL),('08d96f39-090e-42bd-8977-08fce61966af','The triangle thruster combustion chamber is a device that burns propellant to produce thrust force.','Triangle Thruster Combustion Chamber','https://wiki.starbasegame.com/images/2/21/Triangle_thruster_combustion_chamber%2C_tier_1.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Triangle_thruster_combustion_chamber',4629.02,295,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:15:00.538150',NULL,NULL),('08d96f39-31c0-4ce2-8b25-764e853fc422','The triangle thruster nozzle is a device that directs the force generated by the combustion chamber in order to produce usable thrust force.','Triangle Thruster Nozzle Tier 1','https://wiki.starbasegame.com/images/e/e7/Triangle_thruster_nozzle%2C_tier_1.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Triangle_thruster_nozzle',2167.89,235,'08d96e2d-f8ed-417b-8173-3e624c5bcb96',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,60000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:16:08.817718',NULL,NULL),('08d96f39-8f2f-4959-894f-a4eef5143dc1','The triangle thruster nozzle is a device that directs the force generated by the combustion chamber in order to produce usable thrust force.','Triangle Thruster Nozzle Tier 2','https://wiki.starbasegame.com/images/2/2a/Triangle_thruster_nozzle%2C_tier_2.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Triangle_thruster_nozzle',2151.63,410,'08d96e2e-8159-4985-89d4-f6f4550f3f9c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,66000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:18:45.571828',NULL,NULL),('08d96f39-b408-436d-821d-31956569f1a5','The triangle thruster nozzle is a device that directs the force generated by the combustion chamber in order to produce usable thrust force.','Triangle Thruster Nozzle Tier3','https://wiki.starbasegame.com/images/a/af/Triangle_thruster_nozzle%2C_tier_3.png','08d96e45-cc0a-48fb-89a3-c8f46c60574b','https://wiki.starbasegame.com/index.php/Triangle_thruster_nozzle',2090.59,300,'08d96e2f-932b-4f3b-8431-3c8a0d5a17bf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,78000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-04 00:19:47.389493',NULL,NULL);
/*!40000 ALTER TABLE `InGame_Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InGame_MaterialCategories`
--

DROP TABLE IF EXISTS `InGame_MaterialCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InGame_MaterialCategories` (
  `Id` char(36) NOT NULL,
  `Description` longtext NOT NULL,
  `Name` varchar(255) NOT NULL,
  `OldId` int unsigned DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InGame_MaterialCategories`
--

LOCK TABLES `InGame_MaterialCategories` WRITE;
/*!40000 ALTER TABLE `InGame_MaterialCategories` DISABLE KEYS */;
INSERT INTO `InGame_MaterialCategories` VALUES ('08d96df3-7999-43ce-823c-0df428b86f9d','Surface material of many asteroids. Plentiful, cheap, and constantly in demand due to their wide use in base level manufacturing processes.','Rocks',NULL,'2021-09-02 09:24:33.430688',NULL),('08d96df3-c0e4-47f7-8f41-99f4d84455d6','Industrial metal ores','Industrial metal ores',NULL,'2021-09-02 09:26:33.031811',NULL),('08d96df3-cb3d-444a-89ff-34fafc7da3ea','Minor noble metal ores','Minor noble metal ores',NULL,'2021-09-02 09:26:50.390715',NULL),('08d96df3-d338-4c67-80ec-f5ca1c702e0e','Noble metal ores','Noble metal ores',NULL,'2021-09-02 09:27:03.783127',NULL),('08d96df3-db23-4c6e-8f3e-caaae5f96152','Frozen materials','Frozen materials',NULL,'2021-09-02 09:27:17.067207',NULL),('08d96df3-e3ed-4056-8d46-4239df0783be','Alloy materials','Alloy materials',NULL,'2021-09-02 09:27:31.807882',NULL);
/*!40000 ALTER TABLE `InGame_MaterialCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InGame_Materials`
--

DROP TABLE IF EXISTS `InGame_Materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InGame_Materials` (
  `Id` char(36) NOT NULL,
  `Description` longtext NOT NULL,
  `Name` varchar(255) NOT NULL,
  `MaterialCategoryId` char(36) NOT NULL,
  `Armor` double DEFAULT NULL,
  `MinArmor` double DEFAULT NULL,
  `VoxelPenetrationMultiplier` double DEFAULT NULL,
  `CorrosionResistance` double DEFAULT NULL,
  `Transformability` double DEFAULT NULL,
  `StructuralDurability` double DEFAULT NULL,
  `Density` double DEFAULT NULL,
  `OreDensity` double DEFAULT NULL,
  `IconUriRaw` varchar(255) DEFAULT NULL,
  `IconUriRefined` varchar(255) DEFAULT NULL,
  `IconUriOreChunk` varchar(255) DEFAULT NULL,
  `OldId` int unsigned DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_InGame_Materials_MaterialCategoryId` (`MaterialCategoryId`),
  CONSTRAINT `FK_InGame_Materials_InGame_MaterialCategories_MaterialCategoryId` FOREIGN KEY (`MaterialCategoryId`) REFERENCES `InGame_MaterialCategories` (`Id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InGame_Materials`
--

LOCK TABLES `InGame_Materials` WRITE;
/*!40000 ALTER TABLE `InGame_Materials` DISABLE KEYS */;
INSERT INTO `InGame_Materials` VALUES ('08d96e2d-2b94-4f26-8764-c05946ccc543','Carbonate mineral that is used in station construction.','Valkite','08d96df3-7999-43ce-823c-0df428b86f9d',0.3,0,177,400,20,40,9.95,8.08,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Valkite_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Valkite_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Valkite_ore-chunk.png',NULL,'2021-09-02 16:17:33.361688','2021-09-02 16:58:44.648326'),('08d96e2d-669e-49bf-82cb-18ce14ee3428','Abundantly found material used in making glass. basic electronic components and composite materials.','Ajatite','08d96df3-7999-43ce-823c-0df428b86f9d',0.2,0,261,500,40,30,8.6,6.31,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ajatite_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ajatite_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ajatite_ore-chunk.png',NULL,'2021-09-02 16:19:12.389477','2021-09-02 16:58:44.649110'),('08d96e2d-c281-4e92-89ce-ca97462d51d8','Metamorphic rock material.','Talkite','08d96df3-7999-43ce-823c-0df428b86f9d',1.5,0,81,500,65,70,13.75,NULL,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Talkite_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Talkite_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Talkite_ore-chunk.png',NULL,'2021-09-02 16:21:46.551404','2021-09-02 16:58:42.626672'),('08d96e2d-f8ed-417b-8173-3e624c5bcb96','Sturdy metal that is common in low-G planetoids and asteroids. Widely used in many applications.','Bastium','08d96df3-c0e4-47f7-8f41-99f4d84455d6',0.75,0.1,177,400,40,80,9.95,8.08,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Bastium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Bastium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Bastium_ore-chunk.png',NULL,'2021-09-02 16:23:17.850800','2021-09-02 16:58:42.634244'),('08d96e2e-8159-4985-89d4-f6f4550f3f9c','Corrosion resistant metal that is used in applications that require resistance against corrosive substances or highly allotropic properties.','Aegisium','08d96df3-c0e4-47f7-8f41-99f4d84455d6',1.9,0.5,191,800,150,60,9.67,7.67,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Aegisium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Aegisium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Aegisium_ore-chunk.png',NULL,'2021-09-02 16:27:06.732026','2021-09-02 16:58:42.665122'),('08d96e2e-9531-4a70-8b54-43b0487b6818','Metal with high density that is rarely found in large quantities outside gravity wells of planets or large moons.','Oninum','08d96df3-c0e4-47f7-8f41-99f4d84455d6',5.7,0.25,33,500,40,50,22.5,14,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Oninum_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Oninum_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Oninum_ore-chunk.png',NULL,'2021-09-02 16:27:40.024687','2021-09-02 16:58:42.651973'),('08d96e2e-bc01-473d-85c8-2c3b3dc912b5','Heavy metal with high melting point. Used widely as heat shielding material in machinery and as armor.','Charodium','08d96df3-c0e4-47f7-8f41-99f4d84455d6',3.7,0.35,67,200,70,60,15,11.25,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Charodium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Charodium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Charodium_ore-chunk.png',NULL,'2021-09-02 16:28:45.139946','2021-09-02 16:58:42.625513'),('08d96e2e-dec1-4481-8f42-47ed17ef8f63','Lightweight fibrous material that has excellent electric resistance.','Merkerium','08d96df3-c0e4-47f7-8f41-99f4d84455d6',1.9,0.4,209,200,20,60,9.36,7.36,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Merkerium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Merkerium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Merkerium_ore-chunk.png',NULL,'2021-09-02 16:29:43.439644','2021-09-02 16:58:42.653437'),('08d96e2e-f20c-4881-8086-2ca55b764084','Dense metal that is used as radiation shielding material.','Lukium','08d96df3-c0e4-47f7-8f41-99f4d84455d6',3.5,0.1,28,600,60,40,25,15.25,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Lukium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Lukium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Lukium_ore-chunk.png',NULL,'2021-09-02 16:30:15.809509','2021-09-02 16:58:42.635820'),('08d96e2f-11f9-4dfa-8eba-48ff21604102','Strong and durable metal with excellent tension and stress resistance.','Targium','08d96df3-c0e4-47f7-8f41-99f4d84455d6',4.1,0.08,50,300,65,110,17.5,NULL,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Targium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Targium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Targium_ore-chunk.png',NULL,'2021-09-02 16:31:09.374325','2021-09-02 16:58:42.640038'),('08d96e2f-2913-4ac3-8754-754f38ac76a2','Lightweight metal that is a prevalently used material in tools. electronics and machinery.','Tengium','08d96df3-cb3d-444a-89ff-34fafc7da3ea',0.5,0.25,261,600,50,50,8.6,6.31,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Tengium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Tengium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Tengium_ore-chunk.png',NULL,'2021-09-02 16:31:48.130999','2021-09-02 16:58:42.629702'),('08d96e2f-3c7f-42cc-815b-5caf9f5635c4','Reactive alkali metal that is used in optics. energy storage and as heat transfer material.','Ilmatrium','08d96df3-cb3d-444a-89ff-34fafc7da3ea',0.35,0.3,177,500,70,40,9.95,8.08,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ilmatrium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ilmatrium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ilmatrium_ore-chunk.png',NULL,'2021-09-02 16:32:20.712230','2021-09-02 16:58:42.644910'),('08d96e2f-4db8-47a5-8f86-cce6e62da803','Highly reactive metal. Used as heat transfer material and in some applications in electronics.','Ukonium','08d96df3-cb3d-444a-89ff-34fafc7da3ea',0.2,0.15,261,100,100,20,8.6,6.31,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ukonium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ukonium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ukonium_ore-chunk.png',NULL,'2021-09-02 16:32:49.609048','2021-09-02 16:58:44.649520'),('08d96e2f-6867-417d-8c49-2cc8856b22a8','Ductile and light metal that is commonly used in electronics as a power transfer medium.','Vokarium','08d96df3-cb3d-444a-89ff-34fafc7da3ea',0.25,0.15,232,200,80,60,9.01,6.78,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Vokarium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Vokarium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Vokarium_ore-chunk.png',NULL,'2021-09-02 16:33:34.374162','2021-09-02 16:58:42.625294'),('08d96e2f-7c2a-4e86-8b59-97b8d532cdb2','Radioactive metal that is used in fission generators as fuel. Exorium also has uses in some sensors and in kinetic ammunition as penetrator.','Exorium','08d96df3-cb3d-444a-89ff-34fafc7da3ea',2,0.1,32,600,20,30,23,14.25,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Exorium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Exorium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Exorium_ore-chunk.png',NULL,'2021-09-02 16:34:07.534164','2021-09-02 16:58:42.627329'),('08d96e2f-932b-4f3b-8431-3c8a0d5a17bf','Light and ductile metal that has excellent heat resistance.','Ymrium','08d96df3-cb3d-444a-89ff-34fafc7da3ea',2.25,0.15,248,400,80,70,8.78,NULL,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ymrium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ymrium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ymrium_ore-chunk.png',NULL,'2021-09-02 16:34:46.128779','2021-09-02 16:58:44.643997'),('08d96e2f-a796-495a-88ad-61088692fa64','Conductive metal with wide use in advanced capacitors and energy production applications.','Naflite','08d96df3-cb3d-444a-89ff-34fafc7da3ea',0.9,0.1,209,700,100,70,9.36,NULL,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Naflite_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Naflite_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Naflite_ore-chunk.png',NULL,'2021-09-02 16:35:20.381864','2021-09-02 16:58:42.623462'),('08d96e2f-c54a-48db-89b2-1baaa0d93c20','Strong and lightweight metal. commonly used in tools and weapons.','Kutonium','08d96df3-d338-4c67-80ec-f5ca1c702e0e',2.1,0.1,209,200,40,60,9.36,7.36,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Kutonium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Kutonium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Kutonium_ore-chunk.png',NULL,'2021-09-02 16:36:10.215234','2021-09-02 16:58:42.634138'),('08d96e2f-d960-480b-8a86-af79c60023c1','Rare transition metal that has wide use in electronics. alloys and weapons.','Arkanium','08d96df3-d338-4c67-80ec-f5ca1c702e0e',0.45,0.25,357,700,80,20,6.99,4.31,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Arkanium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Arkanium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Arkanium_ore-chunk.png',NULL,'2021-09-02 16:36:43.913516','2021-09-02 16:58:42.628938'),('08d96e2f-ebf8-444b-816b-9a0df18333ac','Dense transition metal that is used in advanced electronics.','Corazium','08d96df3-d338-4c67-80ec-f5ca1c702e0e',0.35,0.05,100,500,50,20,12.5,9.95,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Corazium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Corazium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Corazium_ore-chunk.png',NULL,'2021-09-02 16:37:15.107119','2021-09-02 16:58:42.631749'),('08d96e2f-ff5e-450a-8a4e-6a1573bccb72','Very rare transition metal. Used in advanced energy weapons and high end electronics.','Xhalium','08d96df3-d338-4c67-80ec-f5ca1c702e0e',0.33,0.25,357,750,90,30,7.36,6.31,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Xhalium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Xhalium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Xhalium_ore-chunk.png',NULL,'2021-09-02 16:37:47.652599','2021-09-02 16:58:44.646198'),('08d96e30-13bd-474c-808f-8d2bf3308d5b','Heavy precious metal that is formed in supernovae. Highly resistant to corrosive agents.','Daltium','08d96df3-d338-4c67-80ec-f5ca1c702e0e',3.8,0.07,75,1400,45,50,14.5,NULL,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Daltium_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Daltium_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Daltium_ore-chunk.png',NULL,'2021-09-02 16:38:21.830554','2021-09-02 16:58:42.611899'),('08d96e30-249e-4df9-8673-13a882f9be5c','Compound of hydrogen and oxygen.','Ice','08d96df3-db23-4c6e-8f3e-caaae5f96152',NULL,NULL,NULL,NULL,NULL,NULL,NULL,7.36,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ice_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ice_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Ice_ore-chunk.png',NULL,'2021-09-02 16:38:50.151382','2021-09-02 16:58:42.539248'),('08d96e30-3283-4dfc-85a5-2fbf29d24778','Often manifests in gas or crystalline form. Highly reactive material and when oxidized. Surtrite becomes highly corrosive to many materials.','Surtrite','08d96df3-db23-4c6e-8f3e-caaae5f96152',NULL,NULL,NULL,NULL,NULL,NULL,NULL,6.31,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Surtrite_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Surtrite_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Surtrite_ore-chunk.png',NULL,'2021-09-02 16:39:13.462548','2021-09-02 16:58:42.584024'),('08d96e30-4203-460b-8053-850a3dea98a3','Corrosive gas which is used in explosives and as reaction propellant.','Nhurgite','08d96df3-db23-4c6e-8f3e-caaae5f96152',NULL,NULL,NULL,NULL,NULL,NULL,NULL,6.31,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Nhurgite_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Nhurgite_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Nhurgite_ore-chunk.png',NULL,'2021-09-02 16:39:39.464004','2021-09-02 16:58:42.498651'),('08d96e30-58a0-4416-8122-9787e937f6f6','Inert gas manifested from supernovae of dying stars.','Haderite','08d96df3-db23-4c6e-8f3e-caaae5f96152',NULL,NULL,NULL,NULL,NULL,NULL,NULL,7.36,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Haderite_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Haderite_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Haderite_ore-chunk.png',NULL,'2021-09-02 16:40:17.401963','2021-09-02 16:58:42.507770'),('08d96e30-635e-4786-8617-3de1b807f05e','Radioactive gas which is often used in energy weapons and lights.','Karnite','08d96df3-db23-4c6e-8f3e-caaae5f96152',NULL,NULL,NULL,NULL,NULL,NULL,NULL,6.31,'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Karnite_raw.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Karnite_refined.png','https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/materials/Karnite_ore-chunk.png',NULL,'2021-09-02 16:40:35.425776','2021-09-02 16:58:42.465698');
/*!40000 ALTER TABLE `InGame_Materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__EFMigrationsHistory`
--

DROP TABLE IF EXISTS `__EFMigrationsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__EFMigrationsHistory`
--

LOCK TABLES `__EFMigrationsHistory` WRITE;
/*!40000 ALTER TABLE `__EFMigrationsHistory` DISABLE KEYS */;
INSERT INTO `__EFMigrationsHistory` VALUES ('20210831172256_Initial','5.0.9'),('20210902173348_RemoveRedundantIconFieldInMaterial','5.0.9'),('20210902190707_MakeItemCategoryDescriptionOptional','5.0.9'),('20210903230659_AddWarmupTimeToItem','5.0.9');
/*!40000 ALTER TABLE `__EFMigrationsHistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-04  2:20:43
