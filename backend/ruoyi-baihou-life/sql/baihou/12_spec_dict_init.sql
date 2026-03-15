-- =====================================================================
-- 12_spec_dict_init.sql
-- 规格参数模板表 + 空间/场景标签字典
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. bh_category_spec_def 建表
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bh_category_spec_def` (
  `spec_def_id`  bigint       NOT NULL AUTO_INCREMENT COMMENT '规格定义ID',
  `category_id`  bigint       NOT NULL                COMMENT '品类ID',
  `spec_key`     varchar(64)  NOT NULL                COMMENT '字段Key（英文）',
  `spec_label`   varchar(64)  NOT NULL                COMMENT '显示名称',
  `input_type`   varchar(20)  NOT NULL DEFAULT 'text' COMMENT '输入类型：text/number/select',
  `options`      varchar(500)          DEFAULT NULL   COMMENT '选项 JSON（select类型用）',
  `unit`         varchar(32)           DEFAULT NULL   COMMENT '单位',
  `is_required`  tinyint      NOT NULL DEFAULT 0      COMMENT '是否必填：0否 1是',
  `sort_order`   int          NOT NULL DEFAULT 10     COMMENT '排序',
  `create_by`    varchar(64)           DEFAULT ''     COMMENT '创建者',
  `create_time`  datetime              DEFAULT NULL   COMMENT '创建时间',
  `update_by`    varchar(64)           DEFAULT ''     COMMENT '更新者',
  `update_time`  datetime              DEFAULT NULL   COMMENT '更新时间',
  `remark`       varchar(500)          DEFAULT NULL   COMMENT '备注',
  PRIMARY KEY (`spec_def_id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品类规格定义';

-- ---------------------------------------------------------------------
-- 2. 空间标签字典
-- ---------------------------------------------------------------------
INSERT IGNORE INTO `sys_dict_type` (`dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `remark`)
VALUES ('空间标签', 'baihou_space_tag', '0', 'admin', NOW(), '商品空间标签');

INSERT IGNORE INTO `sys_dict_data`
  (`dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `remark`)
VALUES
  (1,  '客厅',   '客厅',   'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (2,  '餐厅',   '餐厅',   'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (3,  '卧室',   '卧室',   'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (4,  '书房',   '书房',   'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (5,  '儿童房', '儿童房', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (6,  '厨房',   '厨房',   'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (7,  '卫生间', '卫生间', 'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (8,  '阳台',   '阳台',   'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (9,  '玄关',   '玄关',   'baihou_space_tag', '', 'default', 'N', '0', 'admin', NOW(), '');

-- ---------------------------------------------------------------------
-- 3. 场景标签字典
-- ---------------------------------------------------------------------
INSERT IGNORE INTO `sys_dict_type` (`dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `remark`)
VALUES ('场景标签', 'baihou_scene_tag', '0', 'admin', NOW(), '商品场景风格标签');

INSERT IGNORE INTO `sys_dict_data`
  (`dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `remark`)
VALUES
  (1,  '现代简约', '现代简约', 'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (2,  '北欧',     '北欧',     'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (3,  '奶油',     '奶油',     'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (4,  '中古',     '中古',     'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (5,  '新中式',   '新中式',   'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (6,  '轻奢',     '轻奢',     'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (7,  '美式',     '美式',     'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (8,  '工业风',   '工业风',   'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), ''),
  (9,  '法式',     '法式',     'baihou_scene_tag', '', 'default', 'N', '0', 'admin', NOW(), '');
