/*
 Navicat Premium Dump SQL

 Source Server         : ruoyi
 Source Server Type    : MySQL
 Source Server Version : 90300 (9.3.0)
 Source Host           : localhost:3306
 Source Schema         : baihou_life

 Target Server Type    : MySQL
 Target Server Version : 90300 (9.3.0)
 File Encoding         : 65001

 Date: 15/03/2026 15:30:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bh_appointment
-- ----------------------------
DROP TABLE IF EXISTS `bh_appointment`;
CREATE TABLE `bh_appointment` (
  `appointment_id` bigint NOT NULL AUTO_INCREMENT,
  `appointment_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `customer_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_phone` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `service_type` varchar(16) COLLATE utf8mb4_general_ci NOT NULL,
  `preferred_date` date NOT NULL,
  `preferred_time` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `remark` text COLLATE utf8mb4_general_ci,
  `product_id` bigint DEFAULT NULL,
  `region_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `assigned_to` bigint DEFAULT NULL,
  `admin_note` text COLLATE utf8mb4_general_ci,
  `confirmed_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`appointment_id`),
  UNIQUE KEY `uk_bh_appointment_no` (`appointment_no`),
  KEY `idx_bh_appointment_user_id` (`user_id`),
  KEY `idx_bh_appointment_region_status` (`region_id`,`status`),
  KEY `idx_bh_appointment_preferred_date` (`preferred_date`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of bh_appointment
-- ----------------------------
BEGIN;
INSERT INTO `bh_appointment` (`appointment_id`, `appointment_no`, `user_id`, `customer_name`, `customer_phone`, `service_type`, `preferred_date`, `preferred_time`, `address`, `remark`, `product_id`, `region_id`, `status`, `assigned_to`, `admin_note`, `confirmed_at`, `completed_at`, `cancelled_at`, `create_time`, `update_time`) VALUES (1, 'APT202603150001', 1001, '张先生', '13800000001', 'measure', '2026-03-18', 'morning', '佛山市顺德区示例地址1号', '预约岩板上门量尺', 1001, 'foshan', 'confirmed', 2001, '已确认量尺档期', '2026-03-15 10:00:00', NULL, NULL, '2026-03-15 15:28:53', '2026-03-15 15:28:53');
INSERT INTO `bh_appointment` (`appointment_id`, `appointment_no`, `user_id`, `customer_name`, `customer_phone`, `service_type`, `preferred_date`, `preferred_time`, `address`, `remark`, `product_id`, `region_id`, `status`, `assigned_to`, `admin_note`, `confirmed_at`, `completed_at`, `cancelled_at`, `create_time`, `update_time`) VALUES (2, 'APT202603150002', 1002, '李女士', '13800000002', 'install', '2026-03-19', 'afternoon', '成都市高新区示例地址2号', '地板安装前勘测', 2001, 'chengdu', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-03-15 15:28:53', '2026-03-15 15:28:53');
INSERT INTO `bh_appointment` (`appointment_id`, `appointment_no`, `user_id`, `customer_name`, `customer_phone`, `service_type`, `preferred_date`, `preferred_time`, `address`, `remark`, `product_id`, `region_id`, `status`, `assigned_to`, `admin_note`, `confirmed_at`, `completed_at`, `cancelled_at`, `create_time`, `update_time`) VALUES (3, 'APT202603150003', 1003, '王先生', '13800000003', 'measure', '2026-03-20', 'evening', '武汉市武昌区示例地址3号', '客厅沙发尺寸复尺', 5001, 'wuhan', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-03-15 15:28:53', '2026-03-15 15:28:53');
INSERT INTO `bh_appointment` (`appointment_id`, `appointment_no`, `user_id`, `customer_name`, `customer_phone`, `service_type`, `preferred_date`, `preferred_time`, `address`, `remark`, `product_id`, `region_id`, `status`, `assigned_to`, `admin_note`, `confirmed_at`, `completed_at`, `cancelled_at`, `create_time`, `update_time`) VALUES (4, 'APT202603150004', 1004, '赵女士', '13800000004', 'install', '2026-03-21', 'morning', '佛山市南海区示例地址4号', '窗帘轨道安装条件确认', 6001, 'foshan', 'confirmed', 2003, '已电话确认', '2026-03-15 11:20:00', NULL, NULL, '2026-03-15 15:28:53', '2026-03-15 15:28:53');
COMMIT;

-- ----------------------------
-- Table structure for bh_banner
-- ----------------------------
DROP TABLE IF EXISTS `bh_banner`;
CREATE TABLE `bh_banner` (
  `banner_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Banner主键',
  `title` varchar(128) NOT NULL COMMENT '标题',
  `image_url` varchar(512) NOT NULL COMMENT '图片地址',
  `link_type` varchar(16) NOT NULL COMMENT '跳转类型(product/category/url/none)',
  `link_value` varchar(256) DEFAULT NULL COMMENT '跳转目标',
  `regions` json DEFAULT NULL COMMENT '展示区域JSON',
  `start_time` datetime DEFAULT NULL COMMENT '展示开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '展示结束时间',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '排序',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Banner推荐位表';

-- ----------------------------
-- Records of bh_banner
-- ----------------------------
BEGIN;
INSERT INTO `bh_banner` (`banner_id`, `title`, `image_url`, `link_type`, `link_value`, `regions`, `start_time`, `end_time`, `sort_order`, `is_active`, `create_time`, `update_time`) VALUES (1, '首页推荐', 'https://cdn.example.com/banner-home.jpg', 'url', 'https://baihou-life.example.com', '[\"ALL\"]', '2026-03-10 15:29:30', '2026-04-09 15:29:30', 100, 1, '2026-03-10 15:29:30', '2026-03-10 15:29:30');
INSERT INTO `bh_banner` (`banner_id`, `title`, `image_url`, `link_type`, `link_value`, `regions`, `start_time`, `end_time`, `sort_order`, `is_active`, `create_time`, `update_time`) VALUES (2, '佛山专区', 'https://cdn.example.com/banner-foshan.jpg', 'category', '4', '[\"foshan\"]', '2026-03-10 15:29:30', '2026-04-09 15:29:30', 90, 1, '2026-03-10 15:29:30', '2026-03-10 15:29:30');
COMMIT;

-- ----------------------------
-- Table structure for bh_category
-- ----------------------------
DROP TABLE IF EXISTS `bh_category`;
CREATE TABLE `bh_category` (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '品类主键',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父级ID(0=一级分类)',
  `name` varchar(64) NOT NULL COMMENT '品类名称',
  `icon_url` varchar(256) DEFAULT NULL COMMENT '图标URL',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '同级排序',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='品类表';

-- ----------------------------
-- Records of bh_category
-- ----------------------------
BEGIN;
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 0, '主材', NULL, 10, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 0, '定制', NULL, 20, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 0, '软装', NULL, 30, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 1, '瓷砖', NULL, 10, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, 1, '木地板', NULL, 20, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, 2, '橱柜', NULL, 10, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, 2, '定制衣柜', NULL, 20, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, 3, '沙发', NULL, 10, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_category` (`category_id`, `parent_id`, `name`, `icon_url`, `sort_order`, `is_active`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, 3, '窗帘', NULL, 20, 1, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for bh_category_spec_def
-- ----------------------------
DROP TABLE IF EXISTS `bh_category_spec_def`;
CREATE TABLE `bh_category_spec_def` (
  `spec_def_id` bigint NOT NULL AUTO_INCREMENT COMMENT '规格定义ID',
  `category_id` bigint NOT NULL COMMENT '品类ID',
  `spec_key` varchar(64) NOT NULL COMMENT '字段Key（英文）',
  `spec_label` varchar(64) NOT NULL COMMENT '显示名称',
  `input_type` varchar(20) NOT NULL DEFAULT 'text' COMMENT '输入类型：text/number/select',
  `options` varchar(500) DEFAULT NULL COMMENT '选项 JSON（select类型用）',
  `unit` varchar(32) DEFAULT NULL COMMENT '单位',
  `is_required` tinyint NOT NULL DEFAULT '0' COMMENT '是否必填：0否 1是',
  `sort_order` int NOT NULL DEFAULT '10' COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`spec_def_id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='品类规格定义';

-- ----------------------------
-- Records of bh_category_spec_def
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for bh_designer
-- ----------------------------
DROP TABLE IF EXISTS `bh_designer`;
CREATE TABLE `bh_designer` (
  `designer_id` bigint NOT NULL AUTO_INCREMENT COMMENT '设计师主键',
  `user_id` bigint DEFAULT NULL COMMENT '关联微信用户ID',
  `name` varchar(64) NOT NULL COMMENT '姓名',
  `phone` varchar(128) NOT NULL COMMENT '手机号(AES加密)',
  `phone_hash` varchar(64) NOT NULL COMMENT '手机号哈希',
  `company` varchar(128) DEFAULT NULL COMMENT '所属公司',
  `group_id` bigint DEFAULT NULL COMMENT '所属分组ID',
  `discount` decimal(3,2) DEFAULT NULL COMMENT '专属折扣率',
  `status` varchar(16) NOT NULL DEFAULT 'active' COMMENT '状态(active/disabled)',
  `download_count` int NOT NULL DEFAULT '0' COMMENT '累计下载次数',
  `last_active_at` datetime DEFAULT NULL COMMENT '最近活跃时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`designer_id`),
  UNIQUE KEY `uk_phone_hash` (`phone_hash`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设计师表';

-- ----------------------------
-- Records of bh_designer
-- ----------------------------
BEGIN;
INSERT INTO `bh_designer` (`designer_id`, `user_id`, `name`, `phone`, `phone_hash`, `company`, `group_id`, `discount`, `status`, `download_count`, `last_active_at`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1, 1001, '张三', 'AES:13900005678', 'hash-13900005678', '柏厚设计', 1, 0.88, 'active', 0, NULL, 'system', '2026-03-10 15:29:30', 'system', '2026-03-10 15:29:30');
COMMIT;

-- ----------------------------
-- Table structure for bh_designer_group
-- ----------------------------
DROP TABLE IF EXISTS `bh_designer_group`;
CREATE TABLE `bh_designer_group` (
  `group_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分组主键',
  `group_name` varchar(64) NOT NULL COMMENT '分组名称',
  `default_discount` decimal(3,2) NOT NULL DEFAULT '1.00' COMMENT '默认折扣率',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设计师分组表';

-- ----------------------------
-- Records of bh_designer_group
-- ----------------------------
BEGIN;
INSERT INTO `bh_designer_group` (`group_id`, `group_name`, `default_discount`, `create_time`, `update_time`) VALUES (1, '核心设计师', 0.90, '2026-03-10 15:29:30', '2026-03-10 15:29:30');
INSERT INTO `bh_designer_group` (`group_id`, `group_name`, `default_discount`, `create_time`, `update_time`) VALUES (2, '合作设计师', 0.95, '2026-03-10 15:29:30', '2026-03-10 15:29:30');
COMMIT;

-- ----------------------------
-- Table structure for bh_lead
-- ----------------------------
DROP TABLE IF EXISTS `bh_lead`;
CREATE TABLE `bh_lead` (
  `lead_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `product_id` bigint DEFAULT NULL,
  `product_name` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `intention` text COLLATE utf8mb4_general_ci,
  `region_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'new',
  `assigned_to` bigint DEFAULT NULL,
  `source` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `follow_note` text COLLATE utf8mb4_general_ci,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`lead_id`),
  KEY `idx_bh_lead_user_product` (`user_id`,`product_id`),
  KEY `idx_bh_lead_region_status` (`region_id`,`status`),
  KEY `idx_bh_lead_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of bh_lead
-- ----------------------------
BEGIN;
INSERT INTO `bh_lead` (`lead_id`, `user_id`, `product_id`, `product_name`, `category_id`, `name`, `phone`, `intention`, `region_id`, `status`, `assigned_to`, `source`, `follow_note`, `create_time`, `update_time`, `del_flag`) VALUES (1, 1001, 1001, '萨米特 云雾白岩板 1200x2400', 4, '张先生', '13800000001', '想做客厅岩板背景和通铺方案', 'foshan', 'following', 2001, 'product_detail', '已发送样板册', '2026-03-15 15:28:53', '2026-03-15 15:28:53', '0');
INSERT INTO `bh_lead` (`lead_id`, `user_id`, `product_id`, `product_name`, `category_id`, `name`, `phone`, `intention`, `region_id`, `status`, `assigned_to`, `source`, `follow_note`, `create_time`, `update_time`, `del_flag`) VALUES (2, 1002, 2001, '大自然 原木橡木地板', 5, '李女士', '13800000002', '关注卧室木地板与环保等级', 'chengdu', 'new', NULL, 'home_banner', NULL, '2026-03-15 15:28:53', '2026-03-15 15:28:53', '0');
INSERT INTO `bh_lead` (`lead_id`, `user_id`, `product_id`, `product_name`, `category_id`, `name`, `phone`, `intention`, `region_id`, `status`, `assigned_to`, `source`, `follow_note`, `create_time`, `update_time`, `del_flag`) VALUES (3, 1003, 5001, '顾家 云朵模块沙发', 8, '王先生', '13800000003', '需要横厅模块拼接建议', 'wuhan', 'following', 2002, 'product_detail', '待约到店体验', '2026-03-15 15:28:53', '2026-03-15 15:28:53', '0');
INSERT INTO `bh_lead` (`lead_id`, `user_id`, `product_id`, `product_name`, `category_id`, `name`, `phone`, `intention`, `region_id`, `status`, `assigned_to`, `source`, `follow_note`, `create_time`, `update_time`, `del_flag`) VALUES (4, 1004, 6001, '柏厚亚麻透光纱帘', 9, '赵女士', '13800000004', '希望先看奶油风窗帘搭配', 'foshan', 'new', NULL, 'product_detail', NULL, '2026-03-15 15:28:53', '2026-03-15 15:28:53', '0');
COMMIT;

-- ----------------------------
-- Table structure for bh_media
-- ----------------------------
DROP TABLE IF EXISTS `bh_media`;
CREATE TABLE `bh_media` (
  `media_id` bigint NOT NULL AUTO_INCREMENT COMMENT '媒体主键',
  `product_id` bigint NOT NULL COMMENT '关联商品ID',
  `type` varchar(16) NOT NULL COMMENT '类型(scene/element/spec/source)',
  `url` varchar(512) DEFAULT NULL COMMENT 'CDN地址',
  `thumbnail_url` varchar(512) DEFAULT NULL COMMENT '缩略图地址',
  `original_url` varchar(512) DEFAULT NULL COMMENT '高清原图地址',
  `file_format` varchar(16) DEFAULT NULL COMMENT '文件格式',
  `file_size` bigint DEFAULT NULL COMMENT '文件大小(字节)',
  `file_name` varchar(256) DEFAULT NULL COMMENT '原始文件名',
  `access_level` varchar(16) NOT NULL DEFAULT 'public' COMMENT '访问级别(public/designer)',
  `asset_role` varchar(16) NOT NULL DEFAULT 'display' COMMENT '资源角色(display/download)',
  `is_cover` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否主图',
  `width` int DEFAULT NULL COMMENT '宽度',
  `height` int DEFAULT NULL COMMENT '高度',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`media_id`),
  KEY `idx_product_type` (`product_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=7007 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='媒体资源表';

-- ----------------------------
-- Records of bh_media
-- ----------------------------
BEGIN;
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5001, 1001, 'scene', '/profile/products/bh-t-001_scene_01.jpg', '/profile/products/bh-t-001_scene_01.jpg', '/profile/products/bh-t-001_scene_01.jpg', 'jpg', 210000, 'bh-t-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5002, 1001, 'scene', '/profile/products/bh-t-001_scene_02.jpg', '/profile/products/bh-t-001_scene_02.jpg', '/profile/products/bh-t-001_scene_02.jpg', 'jpg', 212000, 'bh-t-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5003, 1001, 'element', '/profile/products/bh-t-001_element_01.jpg', '/profile/products/bh-t-001_element_01.jpg', '/profile/products/bh-t-001_element_01.jpg', 'jpg', 160000, 'bh-t-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5004, 1001, 'scene', '/profile/products/bh-t-001_download_01.jpg', '/profile/products/bh-t-001_download_01.jpg', '/profile/products/bh-t-001_download_01_hd.jpg', 'jpg', 430000, 'bh-t-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5005, 1002, 'scene', '/profile/products/bh-t-002_scene_01.jpg', '/profile/products/bh-t-002_scene_01.jpg', '/profile/products/bh-t-002_scene_01.jpg', 'jpg', 208000, 'bh-t-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5006, 1002, 'scene', '/profile/products/bh-t-002_scene_02.jpg', '/profile/products/bh-t-002_scene_02.jpg', '/profile/products/bh-t-002_scene_02.jpg', 'jpg', 209000, 'bh-t-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5007, 1002, 'spec', '/profile/products/bh-t-002_spec_01.jpg', '/profile/products/bh-t-002_spec_01.jpg', '/profile/products/bh-t-002_spec_01.jpg', 'jpg', 158000, 'bh-t-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5008, 1002, 'scene', '/profile/products/bh-t-002_download_01.jpg', '/profile/products/bh-t-002_download_01.jpg', '/profile/products/bh-t-002_download_01_hd.jpg', 'jpg', 420000, 'bh-t-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5009, 2001, 'scene', '/profile/products/bh-w-001_scene_01.jpg', '/profile/products/bh-w-001_scene_01.jpg', '/profile/products/bh-w-001_scene_01.jpg', 'jpg', 205000, 'bh-w-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5010, 2001, 'scene', '/profile/products/bh-w-001_scene_02.jpg', '/profile/products/bh-w-001_scene_02.jpg', '/profile/products/bh-w-001_scene_02.jpg', 'jpg', 206000, 'bh-w-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5011, 2001, 'element', '/profile/products/bh-w-001_element_01.jpg', '/profile/products/bh-w-001_element_01.jpg', '/profile/products/bh-w-001_element_01.jpg', 'jpg', 155000, 'bh-w-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5012, 2001, 'scene', '/profile/products/bh-w-001_download_01.jpg', '/profile/products/bh-w-001_download_01.jpg', '/profile/products/bh-w-001_download_01_hd.jpg', 'jpg', 410000, 'bh-w-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5013, 2002, 'scene', '/profile/products/bh-w-002_scene_01.jpg', '/profile/products/bh-w-002_scene_01.jpg', '/profile/products/bh-w-002_scene_01.jpg', 'jpg', 205000, 'bh-w-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5014, 2002, 'scene', '/profile/products/bh-w-002_scene_02.jpg', '/profile/products/bh-w-002_scene_02.jpg', '/profile/products/bh-w-002_scene_02.jpg', 'jpg', 205000, 'bh-w-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5015, 2002, 'spec', '/profile/products/bh-w-002_spec_01.jpg', '/profile/products/bh-w-002_spec_01.jpg', '/profile/products/bh-w-002_spec_01.jpg', 'jpg', 154000, 'bh-w-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5016, 2002, 'scene', '/profile/products/bh-w-002_download_01.jpg', '/profile/products/bh-w-002_download_01.jpg', '/profile/products/bh-w-002_download_01_hd.jpg', 'jpg', 408000, 'bh-w-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5017, 3001, 'scene', '/profile/products/bh-c-001_scene_01.jpg', '/profile/products/bh-c-001_scene_01.jpg', '/profile/products/bh-c-001_scene_01.jpg', 'jpg', 205000, 'bh-c-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5018, 3001, 'scene', '/profile/products/bh-c-001_scene_02.jpg', '/profile/products/bh-c-001_scene_02.jpg', '/profile/products/bh-c-001_scene_02.jpg', 'jpg', 205000, 'bh-c-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5019, 3001, 'element', '/profile/products/bh-c-001_element_01.jpg', '/profile/products/bh-c-001_element_01.jpg', '/profile/products/bh-c-001_element_01.jpg', 'jpg', 154000, 'bh-c-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5020, 3001, 'scene', '/profile/products/bh-c-001_download_01.jpg', '/profile/products/bh-c-001_download_01.jpg', '/profile/products/bh-c-001_download_01_hd.jpg', 'jpg', 407000, 'bh-c-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5021, 3002, 'scene', '/profile/products/bh-c-002_scene_01.jpg', '/profile/products/bh-c-002_scene_01.jpg', '/profile/products/bh-c-002_scene_01.jpg', 'jpg', 205000, 'bh-c-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5022, 3002, 'scene', '/profile/products/bh-c-002_scene_02.jpg', '/profile/products/bh-c-002_scene_02.jpg', '/profile/products/bh-c-002_scene_02.jpg', 'jpg', 205000, 'bh-c-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5023, 3002, 'spec', '/profile/products/bh-c-002_spec_01.jpg', '/profile/products/bh-c-002_spec_01.jpg', '/profile/products/bh-c-002_spec_01.jpg', 'jpg', 154000, 'bh-c-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5024, 3002, 'scene', '/profile/products/bh-c-002_download_01.jpg', '/profile/products/bh-c-002_download_01.jpg', '/profile/products/bh-c-002_download_01_hd.jpg', 'jpg', 407000, 'bh-c-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5025, 4001, 'scene', '/profile/products/bh-cw-001_scene_01.jpg', '/profile/products/bh-cw-001_scene_01.jpg', '/profile/products/bh-cw-001_scene_01.jpg', 'jpg', 205000, 'bh-cw-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5026, 4001, 'scene', '/profile/products/bh-cw-001_scene_02.jpg', '/profile/products/bh-cw-001_scene_02.jpg', '/profile/products/bh-cw-001_scene_02.jpg', 'jpg', 205000, 'bh-cw-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5027, 4001, 'element', '/profile/products/bh-cw-001_element_01.jpg', '/profile/products/bh-cw-001_element_01.jpg', '/profile/products/bh-cw-001_element_01.jpg', 'jpg', 154000, 'bh-cw-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5028, 4001, 'scene', '/profile/products/bh-cw-001_download_01.jpg', '/profile/products/bh-cw-001_download_01.jpg', '/profile/products/bh-cw-001_download_01_hd.jpg', 'jpg', 407000, 'bh-cw-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5029, 4002, 'scene', '/profile/products/bh-cw-002_scene_01.jpg', '/profile/products/bh-cw-002_scene_01.jpg', '/profile/products/bh-cw-002_scene_01.jpg', 'jpg', 205000, 'bh-cw-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5030, 4002, 'scene', '/profile/products/bh-cw-002_scene_02.jpg', '/profile/products/bh-cw-002_scene_02.jpg', '/profile/products/bh-cw-002_scene_02.jpg', 'jpg', 205000, 'bh-cw-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5031, 4002, 'spec', '/profile/products/bh-cw-002_spec_01.jpg', '/profile/products/bh-cw-002_spec_01.jpg', '/profile/products/bh-cw-002_spec_01.jpg', 'jpg', 154000, 'bh-cw-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5032, 4002, 'scene', '/profile/products/bh-cw-002_download_01.jpg', '/profile/products/bh-cw-002_download_01.jpg', '/profile/products/bh-cw-002_download_01_hd.jpg', 'jpg', 407000, 'bh-cw-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5033, 5001, 'scene', '/profile/products/bh-s-001_scene_01.jpg', '/profile/products/bh-s-001_scene_01.jpg', '/profile/products/bh-s-001_scene_01.jpg', 'jpg', 205000, 'bh-s-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5034, 5001, 'scene', '/profile/products/bh-s-001_scene_02.jpg', '/profile/products/bh-s-001_scene_02.jpg', '/profile/products/bh-s-001_scene_02.jpg', 'jpg', 205000, 'bh-s-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5035, 5001, 'element', '/profile/products/bh-s-001_element_01.jpg', '/profile/products/bh-s-001_element_01.jpg', '/profile/products/bh-s-001_element_01.jpg', 'jpg', 154000, 'bh-s-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5036, 5001, 'scene', '/profile/products/bh-s-001_download_01.jpg', '/profile/products/bh-s-001_download_01.jpg', '/profile/products/bh-s-001_download_01_hd.jpg', 'jpg', 407000, 'bh-s-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5037, 5002, 'scene', '/profile/products/bh-s-002_scene_01.jpg', '/profile/products/bh-s-002_scene_01.jpg', '/profile/products/bh-s-002_scene_01.jpg', 'jpg', 205000, 'bh-s-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5038, 5002, 'scene', '/profile/products/bh-s-002_scene_02.jpg', '/profile/products/bh-s-002_scene_02.jpg', '/profile/products/bh-s-002_scene_02.jpg', 'jpg', 205000, 'bh-s-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5039, 5002, 'spec', '/profile/products/bh-s-002_spec_01.jpg', '/profile/products/bh-s-002_spec_01.jpg', '/profile/products/bh-s-002_spec_01.jpg', 'jpg', 154000, 'bh-s-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5040, 5002, 'scene', '/profile/products/bh-s-002_download_01.jpg', '/profile/products/bh-s-002_download_01.jpg', '/profile/products/bh-s-002_download_01_hd.jpg', 'jpg', 407000, 'bh-s-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5041, 6001, 'scene', '/profile/products/bh-ct-001_scene_01.jpg', '/profile/products/bh-ct-001_scene_01.jpg', '/profile/products/bh-ct-001_scene_01.jpg', 'jpg', 205000, 'bh-ct-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5042, 6001, 'scene', '/profile/products/bh-ct-001_scene_02.jpg', '/profile/products/bh-ct-001_scene_02.jpg', '/profile/products/bh-ct-001_scene_02.jpg', 'jpg', 205000, 'bh-ct-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5043, 6001, 'element', '/profile/products/bh-ct-001_element_01.jpg', '/profile/products/bh-ct-001_element_01.jpg', '/profile/products/bh-ct-001_element_01.jpg', 'jpg', 154000, 'bh-ct-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5044, 6001, 'scene', '/profile/products/bh-ct-001_download_01.jpg', '/profile/products/bh-ct-001_download_01.jpg', '/profile/products/bh-ct-001_download_01_hd.jpg', 'jpg', 407000, 'bh-ct-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5045, 6002, 'scene', '/profile/products/bh-ct-002_scene_01.jpg', '/profile/products/bh-ct-002_scene_01.jpg', '/profile/products/bh-ct-002_scene_01.jpg', 'jpg', 205000, 'bh-ct-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5046, 6002, 'scene', '/profile/products/bh-ct-002_scene_02.jpg', '/profile/products/bh-ct-002_scene_02.jpg', '/profile/products/bh-ct-002_scene_02.jpg', 'jpg', 205000, 'bh-ct-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5047, 6002, 'spec', '/profile/products/bh-ct-002_spec_01.jpg', '/profile/products/bh-ct-002_spec_01.jpg', '/profile/products/bh-ct-002_spec_01.jpg', 'jpg', 154000, 'bh-ct-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, '2026-03-15 15:28:53');
INSERT INTO `bh_media` (`media_id`, `product_id`, `type`, `url`, `thumbnail_url`, `original_url`, `file_format`, `file_size`, `file_name`, `access_level`, `asset_role`, `is_cover`, `width`, `height`, `sort_order`, `create_time`) VALUES (5048, 6002, 'scene', '/profile/products/bh-ct-002_download_01.jpg', '/profile/products/bh-ct-002_download_01.jpg', '/profile/products/bh-ct-002_download_01_hd.jpg', 'jpg', 407000, 'bh-ct-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, '2026-03-15 15:28:53');
COMMIT;

-- ----------------------------
-- Table structure for bh_order
-- ----------------------------
DROP TABLE IF EXISTS `bh_order`;
CREATE TABLE `bh_order` (
  `order_id` bigint NOT NULL AUTO_INCREMENT,
  `order_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `region_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `product_id` bigint NOT NULL DEFAULT '0',
  `product_name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `unit_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL,
  `pay_amount` decimal(10,2) NOT NULL,
  `status` varchar(16) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending_pay',
  `payment_method` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `transaction_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `remark` text COLLATE utf8mb4_general_ci,
  `admin_note` text COLLATE utf8mb4_general_ci,
  `tracking_no` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `shipped_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uk_bh_order_no` (`order_no`),
  KEY `idx_bh_order_user_id` (`user_id`),
  KEY `idx_bh_order_status` (`status`),
  KEY `idx_bh_order_status_expires` (`status`,`expires_at`),
  KEY `idx_bh_order_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of bh_order
-- ----------------------------
BEGIN;
INSERT INTO `bh_order` (`order_id`, `order_no`, `user_id`, `region_id`, `product_id`, `product_name`, `unit_price`, `total_amount`, `pay_amount`, `status`, `payment_method`, `transaction_id`, `remark`, `admin_note`, `tracking_no`, `paid_at`, `shipped_at`, `completed_at`, `closed_at`, `expires_at`, `create_time`, `update_time`) VALUES (1, 'ORD202603150001', 1001, 'foshan', 1001, '萨米特 云雾白岩板 1200x2400', 1299.00, 1299.00, 1299.00, 'paid', 'wechat_pay', 'wx202603150001', '客厅通铺方案', '待安排复尺', NULL, '2026-03-15 09:30:00', NULL, NULL, NULL, '2026-03-15 10:00:00', '2026-03-15 15:28:53', '2026-03-15 15:28:53');
INSERT INTO `bh_order` (`order_id`, `order_no`, `user_id`, `region_id`, `product_id`, `product_name`, `unit_price`, `total_amount`, `pay_amount`, `status`, `payment_method`, `transaction_id`, `remark`, `admin_note`, `tracking_no`, `paid_at`, `shipped_at`, `completed_at`, `closed_at`, `expires_at`, `create_time`, `update_time`) VALUES (2, 'ORD202603150002', 1002, 'chengdu', 2001, '大自然 原木橡木地板', 299.00, 299.00, 299.00, 'pending_pay', NULL, NULL, '卧室地板预定', '待支付', NULL, NULL, NULL, NULL, NULL, '2026-03-15 22:00:00', '2026-03-15 15:28:53', '2026-03-15 15:28:53');
INSERT INTO `bh_order` (`order_id`, `order_no`, `user_id`, `region_id`, `product_id`, `product_name`, `unit_price`, `total_amount`, `pay_amount`, `status`, `payment_method`, `transaction_id`, `remark`, `admin_note`, `tracking_no`, `paid_at`, `shipped_at`, `completed_at`, `closed_at`, `expires_at`, `create_time`, `update_time`) VALUES (3, 'ORD202603150003', 1003, 'wuhan', 5001, '顾家 云朵模块沙发', 5999.00, 5999.00, 5999.00, 'processing', 'wechat_pay', 'wx202603150003', '客厅沙发下单', '安排出库', 'SF20260315003', '2026-03-15 08:20:00', '2026-03-15 14:00:00', NULL, NULL, '2026-03-15 09:00:00', '2026-03-15 15:28:53', '2026-03-15 15:28:53');
INSERT INTO `bh_order` (`order_id`, `order_no`, `user_id`, `region_id`, `product_id`, `product_name`, `unit_price`, `total_amount`, `pay_amount`, `status`, `payment_method`, `transaction_id`, `remark`, `admin_note`, `tracking_no`, `paid_at`, `shipped_at`, `completed_at`, `closed_at`, `expires_at`, `create_time`, `update_time`) VALUES (4, 'ORD202603150004', 1004, 'foshan', 6001, '柏厚亚麻透光纱帘', 499.00, 499.00, 499.00, 'completed', 'wechat_pay', 'wx202603150004', '卧室纱帘方案', '已完成安装', 'CT20260315004', '2026-03-15 07:50:00', '2026-03-15 13:00:00', '2026-03-15 18:00:00', NULL, '2026-03-15 08:30:00', '2026-03-15 15:28:53', '2026-03-15 15:28:53');
COMMIT;

-- ----------------------------
-- Table structure for bh_order_item
-- ----------------------------
DROP TABLE IF EXISTS `bh_order_item`;
CREATE TABLE `bh_order_item` (
  `item_id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `product_name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `unit_price` decimal(10,2) NOT NULL,
  `line_amount` decimal(10,2) NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_id`),
  KEY `idx_bh_order_item_order_id` (`order_id`),
  KEY `idx_bh_order_item_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of bh_order_item
-- ----------------------------
BEGIN;
INSERT INTO `bh_order_item` (`item_id`, `order_id`, `product_id`, `product_name`, `quantity`, `unit_price`, `line_amount`, `create_time`) VALUES (1, 1, 1001, '萨米特 云雾白岩板 1200x2400', 1, 1299.00, 1299.00, '2026-03-15 15:28:53');
INSERT INTO `bh_order_item` (`item_id`, `order_id`, `product_id`, `product_name`, `quantity`, `unit_price`, `line_amount`, `create_time`) VALUES (2, 2, 2001, '大自然 原木橡木地板', 1, 299.00, 299.00, '2026-03-15 15:28:53');
INSERT INTO `bh_order_item` (`item_id`, `order_id`, `product_id`, `product_name`, `quantity`, `unit_price`, `line_amount`, `create_time`) VALUES (3, 3, 5001, '顾家 云朵模块沙发', 1, 5999.00, 5999.00, '2026-03-15 15:28:53');
INSERT INTO `bh_order_item` (`item_id`, `order_id`, `product_id`, `product_name`, `quantity`, `unit_price`, `line_amount`, `create_time`) VALUES (4, 4, 6001, '柏厚亚麻透光纱帘', 1, 499.00, 499.00, '2026-03-15 15:28:53');
COMMIT;

-- ----------------------------
-- Table structure for bh_product
-- ----------------------------
DROP TABLE IF EXISTS `bh_product`;
CREATE TABLE `bh_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品主键',
  `name` varchar(128) NOT NULL COMMENT '商品名称',
  `sku_code` varchar(64) NOT NULL COMMENT 'SKU编码',
  `brand` varchar(64) DEFAULT NULL COMMENT '品牌',
  `model` varchar(64) DEFAULT NULL COMMENT '型号',
  `category_id` bigint NOT NULL COMMENT '品类ID',
  `guide_price` decimal(10,2) DEFAULT NULL COMMENT '指导价(元)',
  `price_unit` varchar(16) DEFAULT NULL COMMENT '计价单位',
  `designer_discount` decimal(3,2) NOT NULL DEFAULT '1.00' COMMENT '设计师折扣率',
  `regions` json DEFAULT NULL COMMENT '可售区域JSON数组',
  `space_tags` json DEFAULT NULL COMMENT '空间标签JSON数组',
  `scene_tags` json DEFAULT NULL COMMENT '场景标签JSON数组',
  `spec_params` json DEFAULT NULL COMMENT '规格参数JSON',
  `description` text COMMENT '商品描述',
  `status` varchar(16) NOT NULL DEFAULT 'draft' COMMENT '状态(draft/on_shelf/off_shelf/archived)',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '排序权重',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标志(0正常 1删除)',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sku_code` (`sku_code`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_sort` (`status`,`sort_order`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=6003 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品表';

-- ----------------------------
-- Records of bh_product
-- ----------------------------
BEGIN;
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1001, '萨米特 云雾白岩板 1200x2400', 'BH-T-001', '萨米特', 'SM-YWB-1224', 4, 1299.00, '元/片', 0.85, '[\"foshan\", \"chengdu\", \"wuhan\"]', '[\"living_room\", \"bathroom\"]', '[\"minimalist\", \"wabi_sabi\"]', '{\"size\": \"1200x2400\", \"finish\": \"matte\", \"material\": \"sintered_stone\"}', '大板通铺方案，适合客厅与卫浴一体化设计。', 'on_shelf', 120, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1002, '马可波罗 暖灰通体砖 600x1200', 'BH-T-002', '马可波罗', 'MK-NH-612', 4, 199.00, '元/片', 0.90, '[\"foshan\", \"chengdu\"]', '[\"living_room\", \"kitchen\", \"balcony\"]', '[\"minimalist\", \"healing\"]', '{\"size\": \"600x1200\", \"finish\": \"soft_light\", \"material\": \"ceramic\"}', '柔光表面，适合全屋通铺与阳台延展。', 'on_shelf', 110, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (2001, '大自然 原木橡木地板', 'BH-W-001', '大自然', 'DZR-XM-150', 5, 299.00, '元/平米', 0.88, '[\"foshan\", \"chengdu\", \"wuhan\"]', '[\"bedroom\", \"living_room\"]', '[\"healing\", \"minimalist\"]', '{\"size\": \"1200x150\", \"grade\": \"ENF\", \"material\": \"wood\"}', '暖木色基调，适合卧室与客厅的治愈风搭配。', 'on_shelf', 100, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (2002, '圣象 深胡桃复合地板', 'BH-W-002', '圣象', 'SX-HT-180', 5, 359.00, '元/平米', 0.85, '[\"foshan\", \"wuhan\"]', '[\"bedroom\", \"study_room\"]', '[\"wabi_sabi\", \"minimalist\"]', '{\"size\": \"1210x165\", \"color\": \"dark_walnut\", \"material\": \"wood\"}', '深胡桃色适合书房、卧室和高质感定制空间。', 'on_shelf', 90, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (3001, '欧派 一字型极简橱柜', 'BH-C-001', '欧派', 'OP-CG-01', 6, 12999.00, '元/套', 0.80, '[\"foshan\", \"chengdu\", \"wuhan\"]', '[\"kitchen\"]', '[\"minimalist\"]', '{\"style\": \"linear\", \"countertop\": \"quartz\", \"door_panel\": \"lacquer\"}', '高柜与台面一体化设计，适合现代平层厨房。', 'on_shelf', 80, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (3002, '志邦 岛台联动橱柜', 'BH-C-002', '志邦', 'ZB-DT-02', 6, 16999.00, '元/套', 0.78, '[\"foshan\", \"wuhan\"]', '[\"kitchen\"]', '[\"minimalist\", \"healing\"]', '{\"style\": \"island\", \"layout\": \"U_shape\", \"countertop\": \"sintered_stone\"}', '岛台联动台面，适合大开间厨房与社交型家居。', 'on_shelf', 70, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (4001, '索菲亚 玻璃门衣柜系统', 'BH-CW-001', '索菲亚', 'SFY-GL-01', 7, 8999.00, '元/套', 0.82, '[\"foshan\", \"chengdu\", \"wuhan\"]', '[\"bedroom\"]', '[\"minimalist\", \"healing\"]', '{\"door\": \"glass\", \"frame\": \"aluminum\", \"light\": \"sensor\"}', '茶玻与灯带组合，适合主卧展示型收纳。', 'on_shelf', 60, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (4002, '欧派 奶油系步入式衣帽间', 'BH-CW-002', '欧派', 'OP-YMG-02', 7, 13999.00, '元/套', 0.80, '[\"foshan\", \"chengdu\"]', '[\"bedroom\", \"cloak_room\"]', '[\"healing\", \"wabi_sabi\"]', '{\"style\": \"walk_in\", \"finish\": \"cream\", \"module\": \"open_close_mix\"}', '奶油系开放与封闭收纳混搭，适合改善型户型。', 'on_shelf', 50, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (5001, '顾家 云朵模块沙发', 'BH-S-001', '顾家家居', 'GJ-SF-01', 8, 5999.00, '元/套', 0.85, '[\"foshan\", \"chengdu\", \"wuhan\"]', '[\"living_room\"]', '[\"healing\", \"minimalist\"]', '{\"seat\": \"4\", \"module\": \"free\", \"material\": \"fabric\"}', '模块自由组合，适合横厅与大客厅场景。', 'on_shelf', 40, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (5002, '柏厚精选 意式真皮沙发', 'BH-S-002', '柏厚精选', 'BH-ITS-02', 8, 8999.00, '元/套', 0.80, '[\"foshan\", \"chengdu\"]', '[\"living_room\"]', '[\"minimalist\", \"wabi_sabi\"]', '{\"seat\": \"3\", \"color\": \"caramel\", \"material\": \"leather\"}', '头层牛皮与低饱和焦糖色组合，适合精装改善客厅。', 'on_shelf', 30, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (6001, '柏厚亚麻透光纱帘', 'BH-CT-001', '柏厚精选', 'BH-SL-01', 9, 499.00, '元/米', 0.90, '[\"foshan\", \"chengdu\", \"wuhan\"]', '[\"living_room\", \"bedroom\"]', '[\"healing\", \"wabi_sabi\"]', '{\"color\": \"ivory\", \"shading\": \"50%\", \"material\": \"linen\"}', '轻透亚麻质感，适合卧室与客厅柔光方案。', 'on_shelf', 20, '0', 'system', '2026-03-15 15:28:53', '', NULL);
INSERT INTO `bh_product` (`id`, `name`, `sku_code`, `brand`, `model`, `category_id`, `guide_price`, `price_unit`, `designer_discount`, `regions`, `space_tags`, `scene_tags`, `spec_params`, `description`, `status`, `sort_order`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (6002, '高克重遮光窗帘套系', 'BH-CT-002', '柏厚精选', 'BH-ZG-02', 9, 899.00, '元/米', 0.88, '[\"foshan\", \"wuhan\"]', '[\"bedroom\", \"study_room\"]', '[\"minimalist\", \"healing\"]', '{\"color\": \"mist_gray\", \"shading\": \"90%\", \"material\": \"blended\"}', '高遮光性能，适合卧室和影音空间。', 'on_shelf', 10, '0', 'system', '2026-03-15 15:28:53', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for bh_region
-- ----------------------------
DROP TABLE IF EXISTS `bh_region`;
CREATE TABLE `bh_region` (
  `region_id` varchar(32) NOT NULL COMMENT '区域标识',
  `region_name` varchar(64) NOT NULL COMMENT '展示名称',
  `province` varchar(32) NOT NULL COMMENT '省份',
  `center_lat` decimal(10,6) DEFAULT NULL COMMENT '中心纬度',
  `center_lng` decimal(10,6) DEFAULT NULL COMMENT '中心经度',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='区域表';

-- ----------------------------
-- Records of bh_region
-- ----------------------------
BEGIN;
INSERT INTO `bh_region` (`region_id`, `region_name`, `province`, `center_lat`, `center_lng`, `is_active`, `sort_order`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ('chengdu', '成都', '四川', 30.572815, 104.066801, 1, 10, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_region` (`region_id`, `region_name`, `province`, `center_lat`, `center_lng`, `is_active`, `sort_order`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ('foshan', '佛山', '广东', 23.021478, 113.121416, 1, 20, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
INSERT INTO `bh_region` (`region_id`, `region_name`, `province`, `center_lat`, `center_lng`, `is_active`, `sort_order`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ('wuhan', '武汉', '湖北', 30.592760, 114.305250, 1, 30, 'system', '2026-03-10 15:29:30', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for bh_wx_user
-- ----------------------------
DROP TABLE IF EXISTS `bh_wx_user`;
CREATE TABLE `bh_wx_user` (
  `uid` bigint NOT NULL AUTO_INCREMENT COMMENT '用户主键',
  `openid` varchar(64) NOT NULL COMMENT '微信openid',
  `unionid` varchar(64) DEFAULT NULL COMMENT '微信unionid',
  `phone` varchar(128) DEFAULT NULL COMMENT '手机号(AES加密)',
  `phone_hash` varchar(64) DEFAULT NULL COMMENT '手机号哈希(用于查询匹配)',
  `nickname` varchar(64) DEFAULT NULL COMMENT '微信昵称',
  `avatar_url` varchar(512) DEFAULT NULL COMMENT '头像URL',
  `role` tinyint NOT NULL DEFAULT '1' COMMENT '角色(0游客/1客户/2设计师/99管理员)',
  `region_id` varchar(32) DEFAULT NULL COMMENT '默认区域',
  `status` varchar(16) NOT NULL DEFAULT 'active' COMMENT '状态(active/disabled)',
  `last_login_time` datetime DEFAULT NULL COMMENT '最近登录时间',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uk_openid` (`openid`),
  KEY `idx_phone_hash` (`phone_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='微信用户表';

-- ----------------------------
-- Records of bh_wx_user
-- ----------------------------
BEGIN;
INSERT INTO `bh_wx_user` (`uid`, `openid`, `unionid`, `phone`, `phone_hash`, `nickname`, `avatar_url`, `role`, `region_id`, `status`, `last_login_time`, `create_time`, `update_time`) VALUES (1001, 'wx-openid-1001', NULL, 'AES:13900005678', 'hash-13900005678', '设计师候选用户', NULL, 1, NULL, 'active', NULL, '2026-03-10 15:29:30', '2026-03-10 15:29:30');
INSERT INTO `bh_wx_user` (`uid`, `openid`, `unionid`, `phone`, `phone_hash`, `nickname`, `avatar_url`, `role`, `region_id`, `status`, `last_login_time`, `create_time`, `update_time`) VALUES (1002, '0c3shJGa1xK6lL0CdFGa1XVUzk0shJGa', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'active', '2026-03-14 12:44:44', '2026-03-14 12:44:44', '2026-03-14 12:44:44');
INSERT INTO `bh_wx_user` (`uid`, `openid`, `unionid`, `phone`, `phone_hash`, `nickname`, `avatar_url`, `role`, `region_id`, `status`, `last_login_time`, `create_time`, `update_time`) VALUES (1003, '0a3qG51w3PntF63gTb4w3Vuskx3qG51p', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'active', '2026-03-14 12:58:44', '2026-03-14 12:58:44', '2026-03-14 12:58:44');
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-03-10 15:29:14', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-03-10 15:29:14', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-03-10 15:29:14', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-03-10 15:29:14', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-03-10 15:29:14', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-03-10 15:29:14', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-03-10 15:29:14', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-03-10 15:29:14', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '性别男');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '性别女');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '通知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '公告');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, 1, '客厅', '客厅', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, 2, '餐厅', '餐厅', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, 3, '卧室', '卧室', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, 4, '书房', '书房', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, 5, '儿童房', '儿童房', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, 6, '厨房', '厨房', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, 7, '卫生间', '卫生间', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, 8, '阳台', '阳台', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, 9, '玄关', '玄关', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, 1, '现代简约', '现代简约', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, 2, '北欧', '北欧', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, 3, '奶油', '奶油', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, 4, '中古', '中古', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, 5, '新中式', '新中式', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, 6, '轻奢', '轻奢', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, 7, '美式', '美式', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, 8, '工业风', '工业风', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, 9, '法式', '法式', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '空间标签', 'baihou_space_tag', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '商品空间标签');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '场景标签', 'baihou_scene_tag', '0', 'admin', '2026-03-15 12:50:31', '', NULL, '商品场景风格标签');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-03-10 15:29:14', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Mac OS >=10.15.7', '0', '登录成功', '2026-03-15 09:20:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Mac OS >=10.15.7', '0', '登录成功', '2026-03-15 10:14:53');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Mac OS >=10.15.7', '1', '验证码错误', '2026-03-15 12:19:11');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Mac OS >=10.15.7', '0', '登录成功', '2026-03-15 12:19:22');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '1', '验证码错误', '2026-03-15 12:41:21');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '0', '登录成功', '2026-03-15 12:41:38');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '0', '登录成功', '2026-03-15 12:46:25');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '1', '验证码错误', '2026-03-15 12:47:55');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '1', '验证码错误', '2026-03-15 12:48:13');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '0', '登录成功', '2026-03-15 12:48:30');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '0', '登录成功', '2026-03-15 12:51:41');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (111, 'ry', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '0', '登录成功', '2026-03-15 12:55:13');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '1', '验证码错误', '2026-03-15 13:02:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '0', '登录成功', '2026-03-15 13:03:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '1', '验证码错误', '2026-03-15 13:06:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Curl 8.7.1', '', '0', '登录成功', '2026-03-15 13:06:13');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Mac OS >=10.15.7', '0', '登录成功', '2026-03-15 15:03:38');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2029 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统管理', 0, 21, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-03-10 15:29:14', 'admin', '2026-03-15 09:21:56', '系统管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统监控', 0, 22, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-03-10 15:29:14', 'admin', '2026-03-15 09:22:01', '系统监控目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统工具', 0, 23, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-03-10 15:29:14', 'admin', '2026-03-15 09:22:04', '系统工具目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-03-10 15:29:14', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-03-10 15:29:14', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-03-10 15:29:14', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-03-10 15:29:14', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-03-10 15:29:14', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-03-10 15:29:14', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-03-10 15:29:14', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-03-10 15:29:14', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-03-10 15:29:14', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-03-10 15:29:14', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-03-10 15:29:14', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-03-10 15:29:14', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-03-10 15:29:14', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-03-10 15:29:14', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-03-10 15:29:14', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-03-10 15:29:14', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-03-10 15:29:14', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-03-10 15:29:14', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-03-10 15:29:14', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-03-10 15:29:14', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2000, '柏厚生活', 0, 1, 'baihou', '', '', '', 1, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-03-10 15:29:30', 'admin', '2026-03-15 09:22:08', '柏厚生活业务目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2001, '商品管理', 2000, 1, 'products', 'baihou/products/index', '', '', 1, 0, 'C', '0', '0', 'baihou:product:list', 'shopping', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活商品管理');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2002, '品类管理', 2000, 2, 'categories', 'baihou/categories/index', '', '', 1, 0, 'C', '0', '0', 'baihou:category:list', 'tree-table', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活品类管理');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2003, '区域管理', 2000, 3, 'regions', 'baihou/regions/index', '', '', 1, 0, 'C', '0', '0', 'baihou:region:list', 'guide', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活区域管理');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2004, 'Banner管理', 2000, 4, 'banners', 'baihou/banners/index', '', '', 1, 0, 'C', '0', '0', 'baihou:banner:list', 'build', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活Banner管理');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2005, '设计师管理', 2000, 5, 'designers', 'baihou/designers/index', '', '', 1, 0, 'C', '0', '0', 'baihou:designer:list', 'peoples', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活设计师管理');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2006, '设计师分组', 2000, 6, 'designer-groups', 'baihou/designer-groups/index', '', '', 1, 0, 'C', '0', '0', 'baihou:designerGroup:list', 'tree', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活设计师分组');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2007, '线索管理', 2000, 7, 'leads', 'baihou/leads/index', '', '', 1, 0, 'C', '0', '0', 'baihou:lead:list', 'message', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活线索管理');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2008, '预约管理', 2000, 8, 'appointments', 'baihou/appointments/index', '', '', 1, 0, 'C', '0', '0', 'baihou:appointment:list', 'date', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活预约管理');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2009, '订单管理', 2000, 9, 'orders', 'baihou/orders/index', '', '', 1, 0, 'C', '0', '0', 'baihou:order:list', 'money', 'admin', '2026-03-10 15:29:30', '', NULL, '柏厚生活订单管理');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2010, '商品查询', 2001, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:product:query', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2011, '商品新增', 2001, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:product:add', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2012, '商品修改', 2001, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:product:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2013, '商品归档', 2001, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:product:remove', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2014, '品类新增', 2002, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:category:add', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2015, '品类修改', 2002, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:category:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2016, '区域新增', 2003, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:region:add', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2017, '区域修改', 2003, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:region:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2018, 'Banner新增', 2004, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:banner:add', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2019, 'Banner修改', 2004, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:banner:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2020, 'Banner删除', 2004, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:banner:remove', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2021, '设计师新增', 2005, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:designer:add', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2022, '设计师修改', 2005, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:designer:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2023, '分组新增', 2006, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:designerGroup:add', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2024, '分组修改', 2006, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:designerGroup:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2025, '线索更新', 2007, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:lead:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2026, '线索导出', 2007, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:lead:export', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2027, '预约更新', 2008, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:appointment:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2028, '订单更新', 2009, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:order:edit', '#', 'admin', '2026-03-10 15:29:30', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-03-10 15:29:14', '', NULL, '管理员');
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-03-10 15:29:14', '', NULL, '管理员');
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (100, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-03-15 09:21:16', 16);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (101, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-03-10 15:29:14\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 09:21:24', 33);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (102, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 09:21:30', 14);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (103, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-10 15:29:14\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":21,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 09:21:56', 24);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (104, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-10 15:29:14\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":22,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 09:22:01', 19);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (105, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-10 15:29:14\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":23,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 09:22:04', 27);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (106, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2026-03-10 15:29:30\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"柏厚生活\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"baihou\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 09:22:08', 18);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (107, '商品管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouProductController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/admin/products/1001/status/on_shelf', '127.0.0.1', '内网IP', '1001 \"on_shelf\" ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'status\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-03-15 12:46:48', 8);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (108, '商品管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouProductController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/admin/products/1001/status/on_shelf', '127.0.0.1', '内网IP', '1001 \"on_shelf\" ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'status\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-03-15 12:48:45', 10);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (109, '线索管理', 5, 'com.ruoyi.baihou.controller.admin.BaihouLeadController.export()', 'GET', 1, 'admin', '研发部门', '/admin/leads/export', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"assignedTo\":2001,\"categoryId\":20,\"createTime\":\"2026-03-10 15:29:30\",\"followNote\":\"已联系客户\",\"leadId\":2,\"name\":\"李女士\",\"params\":{},\"phone\":\"138****0002\",\"productId\":2,\"productName\":\"山影茶几\",\"regionId\":\"guangzhou\",\"status\":\"following\",\"updateTime\":\"2026-03-10 15:29:30\",\"userId\":1002},{\"categoryId\":10,\"createTime\":\"2026-03-10 15:29:30\",\"leadId\":1,\"name\":\"张先生\",\"params\":{},\"phone\":\"138****0001\",\"productId\":1,\"productName\":\"云幕沙发\",\"regionId\":\"foshan\",\"status\":\"new\",\"updateTime\":\"2026-03-10 15:29:30\",\"userId\":1001}]}', 0, NULL, '2026-03-15 12:48:45', 10);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (110, '商品管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouProductController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/admin/products/1001/status/on_shelf', '127.0.0.1', '内网IP', '1001 \"on_shelf\" ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:52:01', 14);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (111, '商品管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouProductController.updateStatus()', 'PUT', 1, 'admin', '研发部门', '/admin/products/1001/status/on_shelf', '127.0.0.1', '内网IP', '1001 \"on_shelf\" ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:52:12', 9);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (112, '线索管理', 5, 'com.ruoyi.baihou.controller.admin.BaihouLeadController.export()', 'GET', 1, 'admin', '研发部门', '/admin/leads/export', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":[{\"assignedTo\":2001,\"categoryId\":20,\"createTime\":\"2026-03-10 15:29:30\",\"followNote\":\"已联系客户\",\"leadId\":2,\"name\":\"李女士\",\"params\":{},\"phone\":\"138****0002\",\"productId\":2,\"productName\":\"山影茶几\",\"regionId\":\"guangzhou\",\"status\":\"following\",\"updateTime\":\"2026-03-10 15:29:30\",\"userId\":1002},{\"categoryId\":10,\"createTime\":\"2026-03-10 15:29:30\",\"leadId\":1,\"name\":\"张先生\",\"params\":{},\"phone\":\"138****0001\",\"productId\":1,\"productName\":\"云幕沙发\",\"regionId\":\"foshan\",\"status\":\"new\",\"updateTime\":\"2026-03-10 15:29:30\",\"userId\":1001}]}', 0, NULL, '2026-03-15 12:55:13', 6);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (113, '线索管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouLeadController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/leads/1', '127.0.0.1', '内网IP', '{}', NULL, 1, '线索状态流转非法', '2026-03-15 12:55:33', 12);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (114, '订单管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouOrderController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/orders/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:55:33', 18);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (115, '预约管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouAppointmentController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/appointments/1', '127.0.0.1', '内网IP', '{}', NULL, 1, '预约状态流转非法', '2026-03-15 12:55:33', 11);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (116, '预约管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouAppointmentController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/appointments/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:55:33', 15);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (117, '订单管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouOrderController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/orders/1', '127.0.0.1', '内网IP', '{}', NULL, 1, '订单状态流转非法', '2026-03-15 12:55:34', 3);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (118, '规格模板', 1, 'com.ruoyi.baihou.controller.admin.BaihouCategoryController.addSpecDef()', 'POST', 1, 'admin', '研发部门', '/admin/categories/4/spec-defs', '127.0.0.1', '内网IP', '4 {\"categoryId\":4,\"inputType\":\"select\",\"isRequired\":1,\"options\":\"[\\\"米白\\\",\\\"浅灰\\\"]\",\"params\":{},\"sortOrder\":99,\"specDefId\":1,\"specKey\":\"test_color\",\"specLabel\":\"测试颜色\",\"unit\":\"\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:56:43', 9);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (119, 'Banner管理', 1, 'com.ruoyi.baihou.controller.admin.BaihouBannerController.add()', 'POST', 1, 'admin', '研发部门', '/admin/banners', '127.0.0.1', '内网IP', '{\"bannerId\":3,\"endTime\":\"2026-04-15 00:00:00\",\"imageUrl\":\"https://cdn.example.com/test-invalid.jpg\",\"isActive\":1,\"linkType\":\"url\",\"linkValue\":\"https://example.com\",\"params\":{},\"regions\":\"[\\\"ALL\\\",\\\"chengdu\\\"]\",\"sortOrder\":1,\"startTime\":\"2026-03-15 00:00:00\",\"title\":\"AUTO-INVALID-ALL-MIX\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:56:43', 7);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (120, 'Banner管理', 1, 'com.ruoyi.baihou.controller.admin.BaihouBannerController.add()', 'POST', 1, 'admin', '研发部门', '/admin/banners', '127.0.0.1', '内网IP', '{\"bannerId\":4,\"endTime\":\"2026-04-15 00:00:00\",\"imageUrl\":\"https://cdn.example.com/test-valid.jpg\",\"isActive\":1,\"linkType\":\"url\",\"linkValue\":\"https://example.com\",\"params\":{},\"regions\":\"[\\\"ALL\\\"]\",\"sortOrder\":2,\"startTime\":\"2026-03-15 00:00:00\",\"title\":\"AUTO-VALID-ALL\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:56:43', 4);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (121, '规格模板', 2, 'com.ruoyi.baihou.controller.admin.BaihouCategoryController.editSpecDef()', 'PUT', 1, 'admin', '研发部门', '/admin/categories/4/spec-defs/1', '127.0.0.1', '内网IP', '4 1 {\"categoryId\":4,\"inputType\":\"text\",\"isRequired\":0,\"options\":\"\",\"params\":{},\"sortOrder\":88,\"specDefId\":1,\"specKey\":\"test_color_v2\",\"specLabel\":\"测试颜色2\",\"unit\":\"mm\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:57:02', 4);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (122, '规格模板', 3, 'com.ruoyi.baihou.controller.admin.BaihouCategoryController.removeSpecDef()', 'DELETE', 1, 'admin', '研发部门', '/admin/categories/4/spec-defs/1', '127.0.0.1', '内网IP', '4 1 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:57:02', 3);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (123, 'Banner管理', 3, 'com.ruoyi.baihou.controller.admin.BaihouBannerController.remove()', 'DELETE', 1, 'admin', '研发部门', '/admin/banners/3', '127.0.0.1', '内网IP', '3 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:57:03', 4);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (124, 'Banner管理', 3, 'com.ruoyi.baihou.controller.admin.BaihouBannerController.remove()', 'DELETE', 1, 'admin', '研发部门', '/admin/banners/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:57:03', 4);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (125, '订单管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouOrderController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/orders/1', '127.0.0.1', '内网IP', '{}', NULL, 1, '发货必须填写物流单号', '2026-03-15 12:57:41', 5);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (126, '线索管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouLeadController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/leads/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:57:41', 9);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (127, '订单管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouOrderController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/orders/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:57:41', 7);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (128, '订单管理', 2, 'com.ruoyi.baihou.controller.admin.BaihouOrderController.update()', 'PATCH', 1, 'admin', '研发部门', '/admin/orders/1', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 12:57:41', 6);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (129, '规格模板', 2, 'com.ruoyi.baihou.controller.admin.BaihouCategoryController.sortSpecDefs()', 'PUT', 1, 'admin', '研发部门', '/admin/categories/4/spec-defs/sort', '127.0.0.1', '内网IP', '4 [] ', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2026-03-15 13:03:18', 1);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (130, 'Banner管理', 1, 'com.ruoyi.baihou.controller.admin.BaihouBannerController.add()', 'POST', 1, 'admin', '研发部门', '/admin/banners', '127.0.0.1', '内网IP', '{\"isActive\":1,\"params\":{},\"regions\":\"[\\\"ALL\\\",\\\"chengdu\\\"]\",\"sortOrder\":1,\"title\":\"tmp-all-mix-check\"} ', NULL, 1, '全部区域不能与具体区域同时选择', '2026-03-15 13:03:18', 4);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (131, '线索管理', 5, 'com.ruoyi.baihou.controller.admin.BaihouLeadController.export()', 'HEAD', 1, 'admin', '研发部门', '/admin/leads/export', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2026-03-15 13:03:18', 229);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (132, '规格模板', 2, 'com.ruoyi.baihou.controller.admin.BaihouCategoryController.sortSpecDefs()', 'PUT', 1, 'admin', '研发部门', '/admin/categories/4/spec-defs/sort', '127.0.0.1', '内网IP', '4 [] ', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2026-03-15 13:03:46', 0);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (133, '规格模板', 2, 'com.ruoyi.baihou.controller.admin.BaihouCategoryController.sortSpecDefs()', 'PUT', 1, 'admin', '研发部门', '/admin/categories/4/spec-defs/sort', '127.0.0.1', '内网IP', '4 [] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 13:06:25', 2);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (134, 'Banner管理', 1, 'com.ruoyi.baihou.controller.admin.BaihouBannerController.add()', 'POST', 1, 'admin', '研发部门', '/admin/banners', '127.0.0.1', '内网IP', '{\"isActive\":1,\"params\":{},\"regions\":\"[\\\"ALL\\\",\\\"chengdu\\\"]\",\"sortOrder\":1,\"title\":\"tmp-all-mix-check\"} ', NULL, 1, '全部区域不能与具体区域同时选择', '2026-03-15 13:06:25', 5);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (135, '线索管理', 5, 'com.ruoyi.baihou.controller.admin.BaihouLeadController.export()', 'HEAD', 1, 'admin', '研发部门', '/admin/leads/export', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2026-03-15 13:06:25', 206);
COMMIT;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-03-10 15:29:14', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-03-10 15:29:14', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-03-10 15:29:14', '', NULL, '超级管理员');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-03-10 15:29:14', 'admin', '2026-03-15 09:21:24', '普通角色');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 100);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 101);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 105);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1060);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) COLLATE utf8mb4_general_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `pwd_update_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-15 15:03:37', '2026-03-10 15:29:14', 'admin', '2026-03-10 15:29:14', '', NULL, '管理员');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `pwd_update_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-15 12:55:14', '2026-03-10 15:29:14', 'admin', '2026-03-10 15:29:14', '', NULL, '测试员');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (1, 1);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (2, 2);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (2, 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
