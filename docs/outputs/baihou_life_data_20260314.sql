-- MySQL dump 10.13  Distrib 9.3.0, for macos15.2 (arm64)
--
-- Host: localhost    Database: baihou_life
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Dumping data for table `bh_appointment`
--

LOCK TABLES `bh_appointment` WRITE;
/*!40000 ALTER TABLE `bh_appointment` DISABLE KEYS */;
INSERT INTO `bh_appointment` VALUES (1,'APT202603100001',1001,'张先生','13800000001','measure','2026-03-12','morning','佛山市顺德区示例地址1号','上门量尺',1,'foshan','pending',NULL,NULL,NULL,NULL,NULL,'2026-03-10 15:29:30','2026-03-10 15:29:30'),(2,'APT202603100002',1002,'李女士','13800000002','install','2026-03-13','afternoon','广州市天河区示例地址2号','安装服务',2,'guangzhou','confirmed',3001,'已电话确认',NULL,NULL,NULL,'2026-03-10 15:29:30','2026-03-10 15:29:30');
/*!40000 ALTER TABLE `bh_appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_banner`
--

LOCK TABLES `bh_banner` WRITE;
/*!40000 ALTER TABLE `bh_banner` DISABLE KEYS */;
INSERT INTO `bh_banner` VALUES (1,'首页推荐','https://cdn.example.com/banner-home.jpg','url','https://baihou-life.example.com','[\"ALL\"]','2026-03-10 15:29:30','2026-04-09 15:29:30',100,1,'2026-03-10 15:29:30','2026-03-10 15:29:30'),(2,'佛山专区','https://cdn.example.com/banner-foshan.jpg','category','4','[\"foshan\"]','2026-03-10 15:29:30','2026-04-09 15:29:30',90,1,'2026-03-10 15:29:30','2026-03-10 15:29:30');
/*!40000 ALTER TABLE `bh_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_category`
--

LOCK TABLES `bh_category` WRITE;
/*!40000 ALTER TABLE `bh_category` DISABLE KEYS */;
INSERT INTO `bh_category` VALUES (1,0,'主材',NULL,10,1,'system','2026-03-10 15:29:30','',NULL,NULL),(2,0,'定制',NULL,20,1,'system','2026-03-10 15:29:30','',NULL,NULL),(3,0,'软装',NULL,30,1,'system','2026-03-10 15:29:30','',NULL,NULL),(4,1,'瓷砖',NULL,10,1,'system','2026-03-10 15:29:30','',NULL,NULL),(5,1,'木地板',NULL,20,1,'system','2026-03-10 15:29:30','',NULL,NULL),(6,2,'橱柜',NULL,10,1,'system','2026-03-10 15:29:30','',NULL,NULL),(7,2,'定制衣柜',NULL,20,1,'system','2026-03-10 15:29:30','',NULL,NULL),(8,3,'沙发',NULL,10,1,'system','2026-03-10 15:29:30','',NULL,NULL),(9,3,'窗帘',NULL,20,1,'system','2026-03-10 15:29:30','',NULL,NULL);
/*!40000 ALTER TABLE `bh_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_designer`
--

LOCK TABLES `bh_designer` WRITE;
/*!40000 ALTER TABLE `bh_designer` DISABLE KEYS */;
INSERT INTO `bh_designer` VALUES (1,1001,'张三','AES:13900005678','hash-13900005678','柏厚设计',1,0.88,'active',0,NULL,'system','2026-03-10 15:29:30','system','2026-03-10 15:29:30');
/*!40000 ALTER TABLE `bh_designer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_designer_group`
--

LOCK TABLES `bh_designer_group` WRITE;
/*!40000 ALTER TABLE `bh_designer_group` DISABLE KEYS */;
INSERT INTO `bh_designer_group` VALUES (1,'核心设计师',0.90,'2026-03-10 15:29:30','2026-03-10 15:29:30'),(2,'合作设计师',0.95,'2026-03-10 15:29:30','2026-03-10 15:29:30');
/*!40000 ALTER TABLE `bh_designer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_lead`
--

LOCK TABLES `bh_lead` WRITE;
/*!40000 ALTER TABLE `bh_lead` DISABLE KEYS */;
INSERT INTO `bh_lead` VALUES (1,1001,1,'云幕沙发',10,'张先生','13800000001','偏现代客厅方案','foshan','new',NULL,'product_detail',NULL,'2026-03-10 15:29:30','2026-03-10 15:29:30','0'),(2,1002,2,'山影茶几',20,'李女士','13800000002','希望三天内上门沟通','guangzhou','following',2001,'home_banner','已联系客户','2026-03-10 15:29:30','2026-03-10 15:29:30','0');
/*!40000 ALTER TABLE `bh_lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_media`
--

LOCK TABLES `bh_media` WRITE;
/*!40000 ALTER TABLE `bh_media` DISABLE KEYS */;
INSERT INTO `bh_media` VALUES (5001,1001,'scene','/profile/products/tile_1001_scene.jpg','/profile/products/tile_1001_scene.jpg','webp',102400,'scene_01.webp','public',10,'2026-03-10 15:29:30'),(5002,1001,'element','/profile/products/tile_1001_elem.jpg','/profile/products/tile_1001_elem.jpg','webp',87322,'element_01.webp','public',20,'2026-03-10 15:29:30'),(5003,1001,'spec','/profile/products/tile_1001_spec.jpg','/profile/products/tile_1001_spec.jpg','webp',76420,'spec_01.webp','public',30,'2026-03-10 15:29:30'),(5004,1001,'source',NULL,NULL,'skp',15728640,'BH-001.skp','designer',40,'2026-03-10 15:29:30'),(5005,1002,'scene','/profile/products/wood_1002_scene.jpg','/profile/products/wood_1002_scene.jpg','webp',95421,'scene_01.webp','public',10,'2026-03-10 15:29:30'),(6001,2001,'scene','/profile/products/tile_2001_scene.jpg','/profile/products/tile_2001_scene.jpg','jpg',150000,'scene_t001_1.jpg','public',10,'2026-03-13 19:57:44'),(6002,2001,'element','/profile/products/tile_2001_elem.jpg','/profile/products/tile_2001_elem.jpg','jpg',120000,'element_t001_1.jpg','public',20,'2026-03-13 19:57:44'),(6003,2002,'scene','/profile/products/tile_2002_scene.jpg','/profile/products/tile_2002_scene.jpg','jpg',140000,'scene_t002_1.jpg','public',10,'2026-03-13 19:57:44'),(6004,2003,'scene','/profile/products/sofa_2003_scene1.jpg','/profile/products/sofa_2003_scene1.jpg','jpg',160000,'scene_s001_1.jpg','public',10,'2026-03-13 19:57:44'),(6005,2003,'scene','/profile/products/sofa_2003_scene2.jpg','/profile/products/sofa_2003_scene2.jpg','jpg',170000,'scene_s001_2.jpg','public',20,'2026-03-13 19:57:44'),(6006,2004,'scene','/profile/products/sofa_2004_scene.jpg','/profile/products/sofa_2004_scene.jpg','jpg',130000,'scene_s002_1.jpg','public',10,'2026-03-13 19:57:44'),(7001,3001,'scene','/profile/products/tile.jpg','/profile/products/tile.jpg','jpg',150000,'tile.jpg','public',10,'2026-03-13 20:12:00'),(7002,3002,'scene','/profile/products/wood.jpg','/profile/products/wood.jpg','jpg',150000,'wood.jpg','public',10,'2026-03-13 20:12:00'),(7003,3003,'scene','/profile/products/cabinet.jpg','/profile/products/cabinet.jpg','jpg',150000,'cabinet.jpg','public',10,'2026-03-13 20:12:00'),(7004,3004,'scene','/profile/products/wardrobe.jpg','/profile/products/wardrobe.jpg','jpg',150000,'wardrobe.jpg','public',10,'2026-03-13 20:12:00'),(7005,3005,'scene','/profile/products/sofa.jpg','/profile/products/sofa.jpg','jpg',150000,'sofa.jpg','public',10,'2026-03-13 20:12:00'),(7006,3006,'scene','/profile/products/curtain.jpg','/profile/products/curtain.jpg','jpg',150000,'curtain.jpg','public',10,'2026-03-13 20:12:00');
/*!40000 ALTER TABLE `bh_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_order`
--

LOCK TABLES `bh_order` WRITE;
/*!40000 ALTER TABLE `bh_order` DISABLE KEYS */;
INSERT INTO `bh_order` VALUES (1,'ORD202603100001',1001,'foshan',1280.00,1280.00,'paid','wechat_pay','wx202603100001','客厅套装','待确认处理',NULL,'2026-03-10 09:30:00',NULL,NULL,NULL,'2026-03-10 10:00:00','2026-03-10 15:29:30','2026-03-10 15:29:30'),(2,'ORD202603100002',1002,'guangzhou',860.00,860.00,'processing','wechat_pay','wx202603100002','餐厅单品','安排出库',NULL,'2026-03-10 08:30:00',NULL,NULL,NULL,'2026-03-10 09:00:00','2026-03-10 15:29:30','2026-03-10 15:29:30'),(3,'ORD1773464368741',1003,'chengdu',499.00,499.00,'pending_pay',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-03-14 13:29:29','2026-03-14 12:59:28','2026-03-14 12:59:28'),(4,'ORD1773464371166',1003,'chengdu',499.00,499.00,'pending_pay',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-03-14 13:29:31','2026-03-14 12:59:31','2026-03-14 12:59:31'),(5,'ORD1773464372508',1003,'chengdu',499.00,499.00,'pending_pay',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-03-14 13:29:33','2026-03-14 12:59:32','2026-03-14 12:59:32');
/*!40000 ALTER TABLE `bh_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_product`
--

LOCK TABLES `bh_product` WRITE;
/*!40000 ALTER TABLE `bh_product` DISABLE KEYS */;
INSERT INTO `bh_product` VALUES (1001,'现代瓷砖 800x800','BH-001','柏厚生活','CT-800',4,299.00,'元/片',0.95,'[\"chengdu\", \"foshan\"]','[\"living_room\"]','[\"new_house\"]','{\"size\": \"800x800\", \"material\": \"ceramic\"}','一期初始化示例商品','draft',100,'0','system','2026-03-10 15:29:30','',NULL),(1002,'原木木地板','BH-002','柏厚生活','WD-1200',5,599.00,'元/平方米',0.90,'[\"chengdu\"]','[\"bedroom\"]','[\"renovation\"]','{\"size\": \"1200x190\", \"material\": \"wood\"}','一期初始化示例商品','off_shelf',90,'0','system','2026-03-10 15:29:30','',NULL),(2001,'萨米特 奢石岩板 1200x2400','BH-T-001','萨米特','SMT-YS-1224',4,1299.00,'元/片',0.85,'[\"chengdu\", \"foshan\", \"wuhan\"]','[\"living_room\", \"bathroom\"]','[\"new_house\", \"villa\"]','{\"size\": \"1200x2400\", \"material\": \"sintered_stone\", \"thickness\": \"9mm\"}','萨米特奢石系列大规格岩板，质感非凡','on_shelf',10,'0','system','2026-03-13 19:57:12','','2026-03-13 19:57:44'),(2002,'马可波罗 现代灰 600x1200','BH-T-002','马可波罗','MKL-H-612',4,159.00,'元/片',0.90,'[\"chengdu\", \"foshan\"]','[\"living_room\", \"kitchen\", \"balcony\"]','[\"renovation\", \"new_house\"]','{\"size\": \"600x1200\", \"finish\": \"matte\", \"material\": \"ceramic\"}','马可波罗现代简约哑光防滑灰砖','on_shelf',20,'0','system','2026-03-13 19:57:12','','2026-03-13 19:57:44'),(2003,'米兰极简 意式真皮沙发 3人座','BH-S-001','柏厚精选','BH-SF-01',8,8999.00,'元/套',0.80,'[\"chengdu\", \"foshan\", \"wuhan\"]','[\"living_room\"]','[\"new_house\"]','{\"seat\": \"3\", \"color\": \"caramel\", \"material\": \"leather\"}','意式极简头层牛皮沙发，人体工学设计，舒适坐感','on_shelf',30,'0','system','2026-03-13 19:57:12','','2026-03-13 19:57:44'),(2004,'北欧风 羊羔绒布艺懒人沙发','BH-S-002','柏厚精选','BH-SF-02',8,1299.00,'元/件',0.85,'[\"chengdu\", \"wuhan\"]','[\"bedroom\", \"study_room\"]','[\"renovation\"]','{\"color\": \"off_white\", \"material\": \"fabric\"}','网红款布艺懒人沙发，角落里的松弛感','on_shelf',40,'0','system','2026-03-13 19:57:12','','2026-03-13 19:57:44'),(3001,'蒙娜丽莎 抗菌薄板瓷砖 600x1200','BH-T-003','蒙娜丽莎','MN-6120',4,129.00,'元/片',0.90,'[\"chengdu\", \"foshan\"]','[\"living_room\", \"bathroom\"]','[\"minimalist\", \"wabi_sabi\"]','{\"size\": \"600x1200\", \"material\": \"ceramic\"}','抗菌自洁釉面，适用于极简风设计','on_shelf',10,'0','system','2026-03-13 20:12:00','',NULL),(3002,'大自然 橡木实木复合地板','BH-W-001','大自然','DZR-X-1200',5,299.00,'元/平米',0.85,'[\"chengdu\", \"foshan\"]','[\"bedroom\", \"living_room\"]','[\"healing\", \"minimalist\"]','{\"size\": \"1200x150\", \"material\": \"wood\"}','环保等级ENF级，治愈系原木色','on_shelf',20,'0','system','2026-03-13 20:12:00','',NULL),(3003,'欧派 极简一字型橱柜','BH-C-001','欧派','OP-K-001',6,9999.00,'元/套',0.80,'[\"chengdu\", \"foshan\", \"wuhan\"]','[\"kitchen\"]','[\"minimalist\"]','{\"style\": \"straight\", \"material\": \"quartz_stone\"}','极简高柜内嵌电器，防污门板','on_shelf',30,'0','system','2026-03-13 20:12:00','',NULL),(3004,'索菲亚 铝框玻璃对开门衣柜','BH-CW-001','索菲亚','SFY-W-001',7,7999.00,'元/套',0.80,'[\"chengdu\", \"foshan\", \"wuhan\"]','[\"bedroom\"]','[\"minimalist\", \"healing\"]','{\"style\": \"aluminum\", \"material\": \"glass\"}','窄边铝框，茶色玻璃，自带智能感应灯','on_shelf',40,'0','system','2026-03-13 20:12:00','',NULL),(3005,'顾家家居 豆腐块模块沙发','BH-S-003','顾家家居','GJ-SF-03',8,4599.00,'元/套',0.85,'[\"chengdu\", \"foshan\", \"wuhan\"]','[\"living_room\"]','[\"wabi_sabi\", \"healing\"]','{\"seats\": \"4\", \"material\": \"fabric\"}','科技布防猫抓系列，自由模块拼合','on_shelf',50,'0','system','2026-03-13 20:12:00','',NULL),(3006,'日式 亚麻透光遮纱窗帘','BH-CT-001','柏厚精选','BH-CT-001',9,499.00,'元/米',0.90,'[\"chengdu\", \"foshan\", \"wuhan\"]','[\"living_room\", \"bedroom\"]','[\"wabi_sabi\", \"healing\"]','{\"shading\": \"50%\", \"material\": \"linen\"}','日式侘寂风，自然垂坠感强','on_shelf',60,'0','system','2026-03-13 20:12:00','',NULL);
/*!40000 ALTER TABLE `bh_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_region`
--

LOCK TABLES `bh_region` WRITE;
/*!40000 ALTER TABLE `bh_region` DISABLE KEYS */;
INSERT INTO `bh_region` VALUES ('chengdu','成都','四川',30.572815,104.066801,1,10,'system','2026-03-10 15:29:30','',NULL,NULL),('foshan','佛山','广东',23.021478,113.121416,1,20,'system','2026-03-10 15:29:30','',NULL,NULL),('wuhan','武汉','湖北',30.592760,114.305250,1,30,'system','2026-03-10 15:29:30','',NULL,NULL);
/*!40000 ALTER TABLE `bh_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bh_wx_user`
--

LOCK TABLES `bh_wx_user` WRITE;
/*!40000 ALTER TABLE `bh_wx_user` DISABLE KEYS */;
INSERT INTO `bh_wx_user` VALUES (1001,'wx-openid-1001',NULL,'AES:13900005678','hash-13900005678','设计师候选用户',NULL,1,NULL,'active',NULL,'2026-03-10 15:29:30','2026-03-10 15:29:30'),(1002,'0c3shJGa1xK6lL0CdFGa1XVUzk0shJGa',NULL,NULL,NULL,NULL,NULL,1,NULL,'active','2026-03-14 12:44:44','2026-03-14 12:44:44','2026-03-14 12:44:44'),(1003,'0a3qG51w3PntF63gTb4w3Vuskx3qG51p',NULL,NULL,NULL,NULL,NULL,1,NULL,'active','2026-03-14 12:58:44','2026-03-14 12:58:44','2026-03-14 12:58:44');
/*!40000 ALTER TABLE `bh_wx_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2026-03-10 15:29:14','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2026-03-10 15:29:14','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2026-03-10 15:29:14','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2026-03-10 15:29:14','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2026-03-10 15:29:14','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2026-03-10 15:29:14','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),(7,'用户管理-初始密码修改策略','sys.account.initPasswordModify','1','Y','admin','2026-03-10 15:29:14','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),(8,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2026-03-10 15:29:14','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-10 15:29:14','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2026-03-10 15:29:14','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2026-03-10 15:29:14','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2026-03-10 15:29:14','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2026-03-10 15:29:14','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2026-03-10 15:29:14','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2026-03-10 15:29:14','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2026-03-10 15:29:14','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2026-03-10 15:29:14','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2026-03-10 15:29:14','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2026-03-10 15:29:14','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2026-03-10 15:29:14','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2026-03-10 15:29:14','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2026-03-10 15:29:14','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2026-03-10 15:29:14','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2026-03-10 15:29:14','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2026-03-10 15:29:14','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2026-03-10 15:29:14','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2026-03-10 15:29:14','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2026-03-10 15:29:14','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2026-03-10 15:29:14','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2026-03-10 15:29:14','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2026-03-10 15:29:14','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2026-03-10 15:29:14','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2026-03-10 15:29:14','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2026-03-10 15:29:14','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2026-03-10 15:29:14','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2026-03-10 15:29:14','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2026-03-10 15:29:14','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2026-03-10 15:29:14','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2026-03-10 15:29:14','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2026-03-10 15:29:14','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2026-03-10 15:29:14','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2026-03-10 15:29:14','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2026-03-10 15:29:14','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2026-03-10 15:29:14','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2026-03-10 15:29:14','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2026-03-10 15:29:14','',NULL,'系统工具目录'),(4,'若依官网',0,4,'http://ruoyi.vip',NULL,'','',0,0,'M','0','0','','guide','admin','2026-03-10 15:29:14','',NULL,'若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2026-03-10 15:29:14','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2026-03-10 15:29:14','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2026-03-10 15:29:14','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2026-03-10 15:29:14','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2026-03-10 15:29:14','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2026-03-10 15:29:14','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2026-03-10 15:29:14','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2026-03-10 15:29:14','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2026-03-10 15:29:14','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2026-03-10 15:29:14','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2026-03-10 15:29:14','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2026-03-10 15:29:14','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2026-03-10 15:29:14','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2026-03-10 15:29:14','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2026-03-10 15:29:14','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2026-03-10 15:29:14','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2026-03-10 15:29:14','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2026-03-10 15:29:14','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2026-03-10 15:29:14','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2026-03-10 15:29:14','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2026-03-10 15:29:14','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2026-03-10 15:29:14','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2026-03-10 15:29:14','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2026-03-10 15:29:14','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2026-03-10 15:29:14','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2026-03-10 15:29:14','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2026-03-10 15:29:14','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2026-03-10 15:29:14','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2026-03-10 15:29:14','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2026-03-10 15:29:14','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2026-03-10 15:29:14','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2026-03-10 15:29:14','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2026-03-10 15:29:14','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2026-03-10 15:29:14','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2026-03-10 15:29:14','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2026-03-10 15:29:14','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2026-03-10 15:29:14','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2026-03-10 15:29:14','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2026-03-10 15:29:14','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2026-03-10 15:29:14','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2026-03-10 15:29:14','',NULL,''),(2000,'柏厚生活',0,6,'baihou','','','',1,0,'M','0','0','','guide','admin','2026-03-10 15:29:30','',NULL,'柏厚生活业务目录'),(2001,'商品管理',2000,1,'products','baihou/products/index','','',1,0,'C','0','0','baihou:product:list','shopping','admin','2026-03-10 15:29:30','',NULL,'柏厚生活商品管理'),(2002,'品类管理',2000,2,'categories','baihou/categories/index','','',1,0,'C','0','0','baihou:category:list','tree-table','admin','2026-03-10 15:29:30','',NULL,'柏厚生活品类管理'),(2003,'区域管理',2000,3,'regions','baihou/regions/index','','',1,0,'C','0','0','baihou:region:list','guide','admin','2026-03-10 15:29:30','',NULL,'柏厚生活区域管理'),(2004,'Banner管理',2000,4,'banners','baihou/banners/index','','',1,0,'C','0','0','baihou:banner:list','build','admin','2026-03-10 15:29:30','',NULL,'柏厚生活Banner管理'),(2005,'设计师管理',2000,5,'designers','baihou/designers/index','','',1,0,'C','0','0','baihou:designer:list','peoples','admin','2026-03-10 15:29:30','',NULL,'柏厚生活设计师管理'),(2006,'设计师分组',2000,6,'designer-groups','baihou/designer-groups/index','','',1,0,'C','0','0','baihou:designerGroup:list','tree','admin','2026-03-10 15:29:30','',NULL,'柏厚生活设计师分组'),(2007,'线索管理',2000,7,'leads','baihou/leads/index','','',1,0,'C','0','0','baihou:lead:list','message','admin','2026-03-10 15:29:30','',NULL,'柏厚生活线索管理'),(2008,'预约管理',2000,8,'appointments','baihou/appointments/index','','',1,0,'C','0','0','baihou:appointment:list','date','admin','2026-03-10 15:29:30','',NULL,'柏厚生活预约管理'),(2009,'订单管理',2000,9,'orders','baihou/orders/index','','',1,0,'C','0','0','baihou:order:list','money','admin','2026-03-10 15:29:30','',NULL,'柏厚生活订单管理'),(2010,'商品查询',2001,1,'#','','','',1,0,'F','0','0','baihou:product:query','#','admin','2026-03-10 15:29:30','',NULL,''),(2011,'商品新增',2001,2,'#','','','',1,0,'F','0','0','baihou:product:add','#','admin','2026-03-10 15:29:30','',NULL,''),(2012,'商品修改',2001,3,'#','','','',1,0,'F','0','0','baihou:product:edit','#','admin','2026-03-10 15:29:30','',NULL,''),(2013,'商品归档',2001,4,'#','','','',1,0,'F','0','0','baihou:product:remove','#','admin','2026-03-10 15:29:30','',NULL,''),(2014,'品类新增',2002,1,'#','','','',1,0,'F','0','0','baihou:category:add','#','admin','2026-03-10 15:29:30','',NULL,''),(2015,'品类修改',2002,2,'#','','','',1,0,'F','0','0','baihou:category:edit','#','admin','2026-03-10 15:29:30','',NULL,''),(2016,'区域新增',2003,1,'#','','','',1,0,'F','0','0','baihou:region:add','#','admin','2026-03-10 15:29:30','',NULL,''),(2017,'区域修改',2003,2,'#','','','',1,0,'F','0','0','baihou:region:edit','#','admin','2026-03-10 15:29:30','',NULL,''),(2018,'Banner新增',2004,1,'#','','','',1,0,'F','0','0','baihou:banner:add','#','admin','2026-03-10 15:29:30','',NULL,''),(2019,'Banner修改',2004,2,'#','','','',1,0,'F','0','0','baihou:banner:edit','#','admin','2026-03-10 15:29:30','',NULL,''),(2020,'Banner删除',2004,3,'#','','','',1,0,'F','0','0','baihou:banner:remove','#','admin','2026-03-10 15:29:30','',NULL,''),(2021,'设计师新增',2005,1,'#','','','',1,0,'F','0','0','baihou:designer:add','#','admin','2026-03-10 15:29:30','',NULL,''),(2022,'设计师修改',2005,2,'#','','','',1,0,'F','0','0','baihou:designer:edit','#','admin','2026-03-10 15:29:30','',NULL,''),(2023,'分组新增',2006,1,'#','','','',1,0,'F','0','0','baihou:designerGroup:add','#','admin','2026-03-10 15:29:30','',NULL,''),(2024,'分组修改',2006,2,'#','','','',1,0,'F','0','0','baihou:designerGroup:edit','#','admin','2026-03-10 15:29:30','',NULL,''),(2025,'线索更新',2007,1,'#','','','',1,0,'F','0','0','baihou:lead:edit','#','admin','2026-03-10 15:29:30','',NULL,''),(2026,'线索导出',2007,2,'#','','','',1,0,'F','0','0','baihou:lead:export','#','admin','2026-03-10 15:29:30','',NULL,''),(2027,'预约更新',2008,1,'#','','','',1,0,'F','0','0','baihou:appointment:edit','#','admin','2026-03-10 15:29:30','',NULL,''),(2028,'订单更新',2009,1,'#','','','',1,0,'F','0','0','baihou:order:edit','#','admin','2026-03-10 15:29:30','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2026-03-10 15:29:14','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2026-03-10 15:29:14','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2026-03-10 15:29:14','',NULL,''),(2,'se','项目经理',2,'0','admin','2026-03-10 15:29:14','',NULL,''),(3,'hr','人力资源',3,'0','admin','2026-03-10 15:29:14','',NULL,''),(4,'user','普通员工',4,'0','admin','2026-03-10 15:29:14','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2026-03-10 15:29:14','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2026-03-10 15:29:14','',NULL,'普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (1,2000),(1,2001),(1,2002),(1,2003),(1,2004),(1,2005),(1,2006),(1,2007),(1,2008),(1,2009),(1,2010),(1,2011),(1,2012),(1,2013),(1,2014),(1,2015),(1,2016),(1,2017),(1,2018),(1,2019),(1,2020),(1,2021),(1,2022),(1,2023),(1,2024),(1,2025),(1,2026),(1,2027),(1,2028),(2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','若依','00','ry@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-10 15:29:14','2026-03-10 15:29:14','admin','2026-03-10 15:29:14','',NULL,'管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-10 15:29:14','2026-03-10 15:29:14','admin','2026-03-10 15:29:14','',NULL,'测试员');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-14 13:29:27
