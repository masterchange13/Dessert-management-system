-- MySQL dump 10.13  Distrib 8.2.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: community_dessert
-- ------------------------------------------------------
-- Server version	8.2.0

DROP DATABASE IF EXISTS `community_dessert`;
CREATE DATABASE IF NOT EXISTS `community_dessert`;
use `community_dessert`;

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
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type` (
  `id` bigint NOT NULL COMMENT '主键',
  `type` int NOT NULL COMMENT '1 ',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '分类名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  `idn` bigint DEFAULT NULL COMMENT '编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_type_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (8888,1,'健康低脂','2024-04-19 09:32:02','2024-04-19 21:11:07',1,1,1),(22501,1,'甜蜜心情','2024-04-19 09:16:58','2024-04-19 10:54:45',1,1,2),(22502,1,'TOP榜单','2024-04-19 09:17:07','2024-04-19 12:11:06',1,1,3),(22503,1,'今日热销','2024-04-19 09:17:28','2024-04-19 14:37:13',1,1,4),(22504,1,'当季新品','2024-04-19 11:36:15','2024-04-19 14:39:15',1,1,5),(22505,1,'经典模块','2024-04-19 20:43:04','2024-04-19 20:47:42',1,1,6);
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `type_id` bigint NOT NULL,
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '商品码',
  `image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '图片',
  `description` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `status` int NOT NULL DEFAULT '1' COMMENT '0 停售 1 起售',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_user` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_dish_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='商品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1397850392090947585,'挪威森林',22501,4000.00,'123412341234','nwsl.jpg','动物奶油，蓝莓，蓝莓酱',1,'2021-05-27 09:41:19',1,0,'2024-01-04 15:21:51',0),(1397850851245600769,'培根芝芝吐司',22503,1500.00,'123412341234','pgzzts.jpg','培根，芝士，全麦面包',1,'2021-05-27 09:43:08',1,0,'2024-01-04 15:21:51',0),(1397851099502260226,'橘子海',22503,1500.00,'23412341234','jzh.png','美式咖啡，橘子汁',1,'2021-05-27 09:44:08',1,0,'2024-01-04 15:15:38',0),(1397851370462687234,'芭乐啵啵',22504,2000.00,'1246812345678','blbb.png','芭乐，动物奶油，牛奶',1,'2021-05-27 09:45:12',1,0,'2024-01-04 15:15:38',0),(1397851668262465537,'桂花椰奶冻',22504,1800.00,'1234567812345678','ghynd.png','桂花，椰奶',1,'2021-05-27 09:46:23',1,0,'2024-01-04 15:15:38',0),(1397852391150759938,'抹茶坚果脆脆',22504,1500.00,'2346812468','mcjgcc.png','坚果碎，抹茶粉，全麦面包',1,'2021-05-27 09:49:16',1,0,'2024-01-04 15:15:38',0),(1397853183287013378,'麻薯波提甜甜圈',22501,1500.00,'123456787654321','msbtttq.jpg','麻薯，草莓',1,'2021-05-27 09:52:24',1,0,'2024-01-04 15:21:51',0),(1397853709101740034,'蓝莓拿破仑',22504,2000.00,'1234321234321','lmnpl.png','蓝莓，动物奶油',1,'2021-05-27 09:54:30',1,0,'2024-01-04 15:15:38',0),(1397853890262118402,'樱花梦龙啵啵杯',22502,1800.00,'1234212321234','yhmlbbb.png','梦龙雪糕，动物奶油',1,'2021-05-27 09:55:13',1,0,'2024-01-04 15:15:38',0),(1397854652581064706,'草莓千层',22501,1000.00,'2345312·345321','cmqc.png','草莓，动物奶油',1,'2023-12-19 21:13:19',1,0,'2024-01-04 15:15:38',0),(1397854865672679425,'碱水面包',8888,1200.00,'23456431·23456','jsmb.jpg','面粉，椰蓉',1,'2021-05-27 09:59:06',1,0,'2024-01-04 15:21:51',0),(1397860242057375745,'低糖全麦吐司',8888,1500.00,'123456786543213456','dtqmmb.png','小麦面粉',1,'2021-05-27 10:20:27',1,0,'2024-01-04 15:15:38',0),(1397860578738352129,'坚果大列巴',8888,1800.00,'12345678654','jgdlb.png','坚果碎，面粉',1,'2021-05-27 10:21:48',1,0,'2024-01-04 15:15:38',0),(1397860792492666881,'生椰拿铁',22505,2500.00,'213456432123456','synt.png','椰汁，拿铁',1,'2021-05-27 10:22:39',1,0,'2024-01-04 15:15:38',0),(1397860963880316929,'牛油三文鱼贝果',8888,1800.00,'1234563212345','nyswybg.jpg','牛油果，三文鱼，贝果',1,'2021-05-27 10:23:19',1,0,'2024-01-04 15:21:51',0),(1397861683434139649,'柿柿如意',22501,1500.00,'1234567876543213456','ssry.png','面粉，柿子，动物奶油',1,'2021-05-27 10:26:11',1,0,'2024-01-04 15:15:38',0),(1397862198033297410,'草莓抹茶瑞士卷',22501,1800.00,'123456786532455','cmmcrsj.png','草莓，抹茶，面粉',1,'2021-05-27 10:28:14',1,0,'2024-01-04 15:15:38',0),(1397862477831122945,'青提椰椰',22505,1500.00,'1234567865432','qtyy.png','青提，椰奶',1,'2021-05-27 10:29:20',1,0,'2024-01-04 15:15:38',0),(1413342036832100354,'奶油舒芙蕾',22505,990.00,'','nysfl.png','面粉，动物奶油',1,'2023-12-18 09:38:25',1,0,'2024-01-04 15:15:38',0),(1413384757047271425,'芝士莓莓',22504,3000.00,'','zsmm.png','草莓，奶盖',1,'2023-09-06 20:48:07',1,0,'2024-01-04 15:15:38',0);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking`
--

DROP TABLE IF EXISTS `parking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking` (
  `id` bigint NOT NULL COMMENT '主键',
  `type_id` bigint NOT NULL COMMENT '小区id',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '车位名称',
  `price` decimal(10,2) NOT NULL COMMENT '车位价格',
  `status` int DEFAULT NULL COMMENT '状态 0:停用 1:启用',
  `code` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '编码',
  `description` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_setmeal_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='车位';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking`
--

LOCK TABLES `parking` WRITE;
/*!40000 ALTER TABLE `parking` DISABLE KEYS */;
INSERT INTO `parking` VALUES (1735998028753326082,22508,'0001',100000.00,1,'','阿萨大大','10.png','2023-12-16 20:19:18','2023-12-18 09:40:41',1,1,0),(1737098938585948161,22507,'0002',100000.00,1,'','好车位','10.png','2023-12-19 21:13:55','2023-12-19 21:13:55',1,1,0),(1737102196394110977,22506,'0003',100000.00,1,'','沥青','10.png','2023-12-19 21:26:52','2023-12-19 21:26:52',1,1,0);
/*!40000 ALTER TABLE `parking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '姓名',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0:禁用，1:正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT '0' COMMENT '创建人',
  `update_user` bigint DEFAULT '0' COMMENT '修改人',
  `purview` bigint NOT NULL COMMENT '权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='住户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','123456','15519675958','1','320811211308131510',1,'2024-04-20 08:22:30','2024-01-04 08:22:33',0,0,1),(2,'lili','123456','17359581830','0','320811211308131510',1,'2024-04-20 23:40:58','2023-12-18 11:49:28',1,1,1),(3,'xm','123456','15861065205','1','320811200303031120',1,'2024-04-20 21:33:56','2023-12-19 21:33:56',1,1,0),(4,'xyl','123456','15366514682','1','320811200308031510',1,'2024-04-20 01:38:30','2024-01-04 01:38:30',1736411167747706881,1736411167747706881,0),(5,'fly','123456','13015814010','1','320811200308031510',1,'2024-04-20 02:27:50','2024-01-04 02:27:50',NULL,NULL,0),(6,'jyt','123456','17397978932','1','320811200308031510',1,'2024-04-20 02:28:25','2024-01-04 02:28:25',NULL,NULL,0),(7,'lulu','123456','18762159367','1','320811200308031510',1,'2024-04-20 02:31:00','2024-01-04 02:31:00',NULL,NULL,0),(8,'lala','123456','18762159367','1','320811200308031510',1,'2024-04-20 08:06:34','2024-01-04 08:06:34',NULL,NULL,0),(9,'haha','123456','18762159367','1','320811200308031510',1,'2024-04-20 08:07:32','2024-01-04 08:07:32',NULL,NULL,0),(10,'tata','123456','18762159367','1','320811200308031510',1,'2024-04-20 08:08:52','2024-01-04 08:08:52',NULL,NULL,0),(1742824752996954113,'waa','151515','15519675957','0','555555555555555555',1,'2024-04-20 16:26:16','2024-01-04 16:26:16',1,1,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-27 17:46:20
