-- 柏厚生活商品演示数据重建脚本
-- 目标：重建商品、媒体、留资、预约、订单演示数据，并对齐多图/主图/高清下载模型

SET @stmt = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE bh_media ADD COLUMN original_url VARCHAR(512) DEFAULT NULL COMMENT ''高清原图地址'' AFTER thumbnail_url',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'bh_media' AND COLUMN_NAME = 'original_url'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE bh_media ADD COLUMN asset_role VARCHAR(16) NOT NULL DEFAULT ''display'' COMMENT ''资源角色(display/download)'' AFTER access_level',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'bh_media' AND COLUMN_NAME = 'asset_role'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE bh_media ADD COLUMN is_cover TINYINT(1) NOT NULL DEFAULT 0 COMMENT ''是否主图'' AFTER asset_role',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'bh_media' AND COLUMN_NAME = 'is_cover'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE bh_media ADD COLUMN width INT DEFAULT NULL COMMENT ''宽度'' AFTER is_cover',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'bh_media' AND COLUMN_NAME = 'width'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

SET @stmt = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE bh_media ADD COLUMN height INT DEFAULT NULL COMMENT ''高度'' AFTER width',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'bh_media' AND COLUMN_NAME = 'height'
);
PREPARE alter_stmt FROM @stmt;
EXECUTE alter_stmt;
DEALLOCATE PREPARE alter_stmt;

DELETE FROM bh_order_item;
DELETE FROM bh_order;
DELETE FROM bh_appointment;
DELETE FROM bh_lead;
DELETE FROM bh_media;
DELETE FROM bh_product;

INSERT INTO bh_product (
    id, name, sku_code, brand, model, category_id, guide_price, price_unit, designer_discount,
    regions, space_tags, scene_tags, spec_params, description, status, sort_order, del_flag, create_by, create_time
) VALUES
    (1001, '萨米特 云雾白岩板 1200x2400', 'BH-T-001', '萨米特', 'SM-YWB-1224', 4, 1299.00, '元/片', 0.85, JSON_ARRAY('foshan', 'chengdu', 'wuhan'), JSON_ARRAY('living_room', 'bathroom'), JSON_ARRAY('minimalist', 'wabi_sabi'), JSON_OBJECT('size', '1200x2400', 'material', 'sintered_stone', 'finish', 'matte'), '大板通铺方案，适合客厅与卫浴一体化设计。', 'on_shelf', 120, '0', 'system', NOW()),
    (1002, '马可波罗 暖灰通体砖 600x1200', 'BH-T-002', '马可波罗', 'MK-NH-612', 4, 199.00, '元/片', 0.90, JSON_ARRAY('foshan', 'chengdu'), JSON_ARRAY('living_room', 'kitchen', 'balcony'), JSON_ARRAY('minimalist', 'healing'), JSON_OBJECT('size', '600x1200', 'material', 'ceramic', 'finish', 'soft_light'), '柔光表面，适合全屋通铺与阳台延展。', 'on_shelf', 110, '0', 'system', NOW()),
    (2001, '大自然 原木橡木地板', 'BH-W-001', '大自然', 'DZR-XM-150', 5, 299.00, '元/平米', 0.88, JSON_ARRAY('foshan', 'chengdu', 'wuhan'), JSON_ARRAY('bedroom', 'living_room'), JSON_ARRAY('healing', 'minimalist'), JSON_OBJECT('size', '1200x150', 'material', 'wood', 'grade', 'ENF'), '暖木色基调，适合卧室与客厅的治愈风搭配。', 'on_shelf', 100, '0', 'system', NOW()),
    (2002, '圣象 深胡桃复合地板', 'BH-W-002', '圣象', 'SX-HT-180', 5, 359.00, '元/平米', 0.85, JSON_ARRAY('foshan', 'wuhan'), JSON_ARRAY('bedroom', 'study_room'), JSON_ARRAY('wabi_sabi', 'minimalist'), JSON_OBJECT('size', '1210x165', 'material', 'wood', 'color', 'dark_walnut'), '深胡桃色适合书房、卧室和高质感定制空间。', 'on_shelf', 90, '0', 'system', NOW()),
    (3001, '欧派 一字型极简橱柜', 'BH-C-001', '欧派', 'OP-CG-01', 6, 12999.00, '元/套', 0.80, JSON_ARRAY('foshan', 'chengdu', 'wuhan'), JSON_ARRAY('kitchen'), JSON_ARRAY('minimalist'), JSON_OBJECT('style', 'linear', 'countertop', 'quartz', 'door_panel', 'lacquer'), '高柜与台面一体化设计，适合现代平层厨房。', 'on_shelf', 80, '0', 'system', NOW()),
    (3002, '志邦 岛台联动橱柜', 'BH-C-002', '志邦', 'ZB-DT-02', 6, 16999.00, '元/套', 0.78, JSON_ARRAY('foshan', 'wuhan'), JSON_ARRAY('kitchen'), JSON_ARRAY('minimalist', 'healing'), JSON_OBJECT('style', 'island', 'countertop', 'sintered_stone', 'layout', 'U_shape'), '岛台联动台面，适合大开间厨房与社交型家居。', 'on_shelf', 70, '0', 'system', NOW()),
    (4001, '索菲亚 玻璃门衣柜系统', 'BH-CW-001', '索菲亚', 'SFY-GL-01', 7, 8999.00, '元/套', 0.82, JSON_ARRAY('foshan', 'chengdu', 'wuhan'), JSON_ARRAY('bedroom'), JSON_ARRAY('minimalist', 'healing'), JSON_OBJECT('door', 'glass', 'frame', 'aluminum', 'light', 'sensor'), '茶玻与灯带组合，适合主卧展示型收纳。', 'on_shelf', 60, '0', 'system', NOW()),
    (4002, '欧派 奶油系步入式衣帽间', 'BH-CW-002', '欧派', 'OP-YMG-02', 7, 13999.00, '元/套', 0.80, JSON_ARRAY('foshan', 'chengdu'), JSON_ARRAY('bedroom', 'cloak_room'), JSON_ARRAY('healing', 'wabi_sabi'), JSON_OBJECT('style', 'walk_in', 'finish', 'cream', 'module', 'open_close_mix'), '奶油系开放与封闭收纳混搭，适合改善型户型。', 'on_shelf', 50, '0', 'system', NOW()),
    (5001, '顾家 云朵模块沙发', 'BH-S-001', '顾家家居', 'GJ-SF-01', 8, 5999.00, '元/套', 0.85, JSON_ARRAY('foshan', 'chengdu', 'wuhan'), JSON_ARRAY('living_room'), JSON_ARRAY('healing', 'minimalist'), JSON_OBJECT('material', 'fabric', 'seat', '4', 'module', 'free'), '模块自由组合，适合横厅与大客厅场景。', 'on_shelf', 40, '0', 'system', NOW()),
    (5002, '柏厚精选 意式真皮沙发', 'BH-S-002', '柏厚精选', 'BH-ITS-02', 8, 8999.00, '元/套', 0.80, JSON_ARRAY('foshan', 'chengdu'), JSON_ARRAY('living_room'), JSON_ARRAY('minimalist', 'wabi_sabi'), JSON_OBJECT('material', 'leather', 'seat', '3', 'color', 'caramel'), '头层牛皮与低饱和焦糖色组合，适合精装改善客厅。', 'on_shelf', 30, '0', 'system', NOW()),
    (6001, '柏厚亚麻透光纱帘', 'BH-CT-001', '柏厚精选', 'BH-SL-01', 9, 499.00, '元/米', 0.90, JSON_ARRAY('foshan', 'chengdu', 'wuhan'), JSON_ARRAY('living_room', 'bedroom'), JSON_ARRAY('healing', 'wabi_sabi'), JSON_OBJECT('material', 'linen', 'shading', '50%', 'color', 'ivory'), '轻透亚麻质感，适合卧室与客厅柔光方案。', 'on_shelf', 20, '0', 'system', NOW()),
    (6002, '高克重遮光窗帘套系', 'BH-CT-002', '柏厚精选', 'BH-ZG-02', 9, 899.00, '元/米', 0.88, JSON_ARRAY('foshan', 'wuhan'), JSON_ARRAY('bedroom', 'study_room'), JSON_ARRAY('minimalist', 'healing'), JSON_OBJECT('material', 'blended', 'shading', '90%', 'color', 'mist_gray'), '高遮光性能，适合卧室和影音空间。', 'on_shelf', 10, '0', 'system', NOW());

INSERT INTO bh_media (
    media_id, product_id, type, url, thumbnail_url, original_url, file_format, file_size, file_name,
    access_level, asset_role, is_cover, width, height, sort_order, create_time
) VALUES
    (5001, 1001, 'scene', '/profile/products/bh-t-001_scene_01.jpg', '/profile/products/bh-t-001_scene_01.jpg', '/profile/products/bh-t-001_scene_01.jpg', 'jpg', 210000, 'bh-t-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5002, 1001, 'scene', '/profile/products/bh-t-001_scene_02.jpg', '/profile/products/bh-t-001_scene_02.jpg', '/profile/products/bh-t-001_scene_02.jpg', 'jpg', 212000, 'bh-t-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5003, 1001, 'element', '/profile/products/bh-t-001_element_01.jpg', '/profile/products/bh-t-001_element_01.jpg', '/profile/products/bh-t-001_element_01.jpg', 'jpg', 160000, 'bh-t-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5004, 1001, 'scene', '/profile/products/bh-t-001_download_01.jpg', '/profile/products/bh-t-001_download_01.jpg', '/profile/products/bh-t-001_download_01_hd.jpg', 'jpg', 430000, 'bh-t-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5005, 1002, 'scene', '/profile/products/bh-t-002_scene_01.jpg', '/profile/products/bh-t-002_scene_01.jpg', '/profile/products/bh-t-002_scene_01.jpg', 'jpg', 208000, 'bh-t-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5006, 1002, 'scene', '/profile/products/bh-t-002_scene_02.jpg', '/profile/products/bh-t-002_scene_02.jpg', '/profile/products/bh-t-002_scene_02.jpg', 'jpg', 209000, 'bh-t-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5007, 1002, 'spec', '/profile/products/bh-t-002_spec_01.jpg', '/profile/products/bh-t-002_spec_01.jpg', '/profile/products/bh-t-002_spec_01.jpg', 'jpg', 158000, 'bh-t-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5008, 1002, 'scene', '/profile/products/bh-t-002_download_01.jpg', '/profile/products/bh-t-002_download_01.jpg', '/profile/products/bh-t-002_download_01_hd.jpg', 'jpg', 420000, 'bh-t-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5009, 2001, 'scene', '/profile/products/bh-w-001_scene_01.jpg', '/profile/products/bh-w-001_scene_01.jpg', '/profile/products/bh-w-001_scene_01.jpg', 'jpg', 205000, 'bh-w-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5010, 2001, 'scene', '/profile/products/bh-w-001_scene_02.jpg', '/profile/products/bh-w-001_scene_02.jpg', '/profile/products/bh-w-001_scene_02.jpg', 'jpg', 206000, 'bh-w-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5011, 2001, 'element', '/profile/products/bh-w-001_element_01.jpg', '/profile/products/bh-w-001_element_01.jpg', '/profile/products/bh-w-001_element_01.jpg', 'jpg', 155000, 'bh-w-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5012, 2001, 'scene', '/profile/products/bh-w-001_download_01.jpg', '/profile/products/bh-w-001_download_01.jpg', '/profile/products/bh-w-001_download_01_hd.jpg', 'jpg', 410000, 'bh-w-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5013, 2002, 'scene', '/profile/products/bh-w-002_scene_01.jpg', '/profile/products/bh-w-002_scene_01.jpg', '/profile/products/bh-w-002_scene_01.jpg', 'jpg', 205000, 'bh-w-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5014, 2002, 'scene', '/profile/products/bh-w-002_scene_02.jpg', '/profile/products/bh-w-002_scene_02.jpg', '/profile/products/bh-w-002_scene_02.jpg', 'jpg', 205000, 'bh-w-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5015, 2002, 'spec', '/profile/products/bh-w-002_spec_01.jpg', '/profile/products/bh-w-002_spec_01.jpg', '/profile/products/bh-w-002_spec_01.jpg', 'jpg', 154000, 'bh-w-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5016, 2002, 'scene', '/profile/products/bh-w-002_download_01.jpg', '/profile/products/bh-w-002_download_01.jpg', '/profile/products/bh-w-002_download_01_hd.jpg', 'jpg', 408000, 'bh-w-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5017, 3001, 'scene', '/profile/products/bh-c-001_scene_01.jpg', '/profile/products/bh-c-001_scene_01.jpg', '/profile/products/bh-c-001_scene_01.jpg', 'jpg', 205000, 'bh-c-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5018, 3001, 'scene', '/profile/products/bh-c-001_scene_02.jpg', '/profile/products/bh-c-001_scene_02.jpg', '/profile/products/bh-c-001_scene_02.jpg', 'jpg', 205000, 'bh-c-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5019, 3001, 'element', '/profile/products/bh-c-001_element_01.jpg', '/profile/products/bh-c-001_element_01.jpg', '/profile/products/bh-c-001_element_01.jpg', 'jpg', 154000, 'bh-c-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5020, 3001, 'scene', '/profile/products/bh-c-001_download_01.jpg', '/profile/products/bh-c-001_download_01.jpg', '/profile/products/bh-c-001_download_01_hd.jpg', 'jpg', 407000, 'bh-c-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5021, 3002, 'scene', '/profile/products/bh-c-002_scene_01.jpg', '/profile/products/bh-c-002_scene_01.jpg', '/profile/products/bh-c-002_scene_01.jpg', 'jpg', 205000, 'bh-c-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5022, 3002, 'scene', '/profile/products/bh-c-002_scene_02.jpg', '/profile/products/bh-c-002_scene_02.jpg', '/profile/products/bh-c-002_scene_02.jpg', 'jpg', 205000, 'bh-c-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5023, 3002, 'spec', '/profile/products/bh-c-002_spec_01.jpg', '/profile/products/bh-c-002_spec_01.jpg', '/profile/products/bh-c-002_spec_01.jpg', 'jpg', 154000, 'bh-c-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5024, 3002, 'scene', '/profile/products/bh-c-002_download_01.jpg', '/profile/products/bh-c-002_download_01.jpg', '/profile/products/bh-c-002_download_01_hd.jpg', 'jpg', 407000, 'bh-c-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5025, 4001, 'scene', '/profile/products/bh-cw-001_scene_01.jpg', '/profile/products/bh-cw-001_scene_01.jpg', '/profile/products/bh-cw-001_scene_01.jpg', 'jpg', 205000, 'bh-cw-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5026, 4001, 'scene', '/profile/products/bh-cw-001_scene_02.jpg', '/profile/products/bh-cw-001_scene_02.jpg', '/profile/products/bh-cw-001_scene_02.jpg', 'jpg', 205000, 'bh-cw-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5027, 4001, 'element', '/profile/products/bh-cw-001_element_01.jpg', '/profile/products/bh-cw-001_element_01.jpg', '/profile/products/bh-cw-001_element_01.jpg', 'jpg', 154000, 'bh-cw-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5028, 4001, 'scene', '/profile/products/bh-cw-001_download_01.jpg', '/profile/products/bh-cw-001_download_01.jpg', '/profile/products/bh-cw-001_download_01_hd.jpg', 'jpg', 407000, 'bh-cw-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5029, 4002, 'scene', '/profile/products/bh-cw-002_scene_01.jpg', '/profile/products/bh-cw-002_scene_01.jpg', '/profile/products/bh-cw-002_scene_01.jpg', 'jpg', 205000, 'bh-cw-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5030, 4002, 'scene', '/profile/products/bh-cw-002_scene_02.jpg', '/profile/products/bh-cw-002_scene_02.jpg', '/profile/products/bh-cw-002_scene_02.jpg', 'jpg', 205000, 'bh-cw-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5031, 4002, 'spec', '/profile/products/bh-cw-002_spec_01.jpg', '/profile/products/bh-cw-002_spec_01.jpg', '/profile/products/bh-cw-002_spec_01.jpg', 'jpg', 154000, 'bh-cw-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5032, 4002, 'scene', '/profile/products/bh-cw-002_download_01.jpg', '/profile/products/bh-cw-002_download_01.jpg', '/profile/products/bh-cw-002_download_01_hd.jpg', 'jpg', 407000, 'bh-cw-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5033, 5001, 'scene', '/profile/products/bh-s-001_scene_01.jpg', '/profile/products/bh-s-001_scene_01.jpg', '/profile/products/bh-s-001_scene_01.jpg', 'jpg', 205000, 'bh-s-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5034, 5001, 'scene', '/profile/products/bh-s-001_scene_02.jpg', '/profile/products/bh-s-001_scene_02.jpg', '/profile/products/bh-s-001_scene_02.jpg', 'jpg', 205000, 'bh-s-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5035, 5001, 'element', '/profile/products/bh-s-001_element_01.jpg', '/profile/products/bh-s-001_element_01.jpg', '/profile/products/bh-s-001_element_01.jpg', 'jpg', 154000, 'bh-s-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5036, 5001, 'scene', '/profile/products/bh-s-001_download_01.jpg', '/profile/products/bh-s-001_download_01.jpg', '/profile/products/bh-s-001_download_01_hd.jpg', 'jpg', 407000, 'bh-s-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5037, 5002, 'scene', '/profile/products/bh-s-002_scene_01.jpg', '/profile/products/bh-s-002_scene_01.jpg', '/profile/products/bh-s-002_scene_01.jpg', 'jpg', 205000, 'bh-s-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5038, 5002, 'scene', '/profile/products/bh-s-002_scene_02.jpg', '/profile/products/bh-s-002_scene_02.jpg', '/profile/products/bh-s-002_scene_02.jpg', 'jpg', 205000, 'bh-s-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5039, 5002, 'spec', '/profile/products/bh-s-002_spec_01.jpg', '/profile/products/bh-s-002_spec_01.jpg', '/profile/products/bh-s-002_spec_01.jpg', 'jpg', 154000, 'bh-s-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5040, 5002, 'scene', '/profile/products/bh-s-002_download_01.jpg', '/profile/products/bh-s-002_download_01.jpg', '/profile/products/bh-s-002_download_01_hd.jpg', 'jpg', 407000, 'bh-s-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5041, 6001, 'scene', '/profile/products/bh-ct-001_scene_01.jpg', '/profile/products/bh-ct-001_scene_01.jpg', '/profile/products/bh-ct-001_scene_01.jpg', 'jpg', 205000, 'bh-ct-001_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5042, 6001, 'scene', '/profile/products/bh-ct-001_scene_02.jpg', '/profile/products/bh-ct-001_scene_02.jpg', '/profile/products/bh-ct-001_scene_02.jpg', 'jpg', 205000, 'bh-ct-001_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5043, 6001, 'element', '/profile/products/bh-ct-001_element_01.jpg', '/profile/products/bh-ct-001_element_01.jpg', '/profile/products/bh-ct-001_element_01.jpg', 'jpg', 154000, 'bh-ct-001_element_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5044, 6001, 'scene', '/profile/products/bh-ct-001_download_01.jpg', '/profile/products/bh-ct-001_download_01.jpg', '/profile/products/bh-ct-001_download_01_hd.jpg', 'jpg', 407000, 'bh-ct-001_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW()),
    (5045, 6002, 'scene', '/profile/products/bh-ct-002_scene_01.jpg', '/profile/products/bh-ct-002_scene_01.jpg', '/profile/products/bh-ct-002_scene_01.jpg', 'jpg', 205000, 'bh-ct-002_scene_01.jpg', 'public', 'display', 1, 1600, 1200, 10, NOW()),
    (5046, 6002, 'scene', '/profile/products/bh-ct-002_scene_02.jpg', '/profile/products/bh-ct-002_scene_02.jpg', '/profile/products/bh-ct-002_scene_02.jpg', 'jpg', 205000, 'bh-ct-002_scene_02.jpg', 'public', 'display', 0, 1600, 1200, 20, NOW()),
    (5047, 6002, 'spec', '/profile/products/bh-ct-002_spec_01.jpg', '/profile/products/bh-ct-002_spec_01.jpg', '/profile/products/bh-ct-002_spec_01.jpg', 'jpg', 154000, 'bh-ct-002_spec_01.jpg', 'public', 'display', 0, 1200, 1200, 30, NOW()),
    (5048, 6002, 'scene', '/profile/products/bh-ct-002_download_01.jpg', '/profile/products/bh-ct-002_download_01.jpg', '/profile/products/bh-ct-002_download_01_hd.jpg', 'jpg', 407000, 'bh-ct-002_download_01_hd.jpg', 'designer', 'download', 0, 2400, 1800, 40, NOW());

INSERT INTO bh_lead (
    lead_id, user_id, product_id, product_name, category_id, name, phone, intention, region_id, status, assigned_to, source, follow_note
) VALUES
    (1, 1001, 1001, '萨米特 云雾白岩板 1200x2400', 4, '张先生', '13800000001', '想做客厅岩板背景和通铺方案', 'foshan', 'following', 2001, 'product_detail', '已发送样板册'),
    (2, 1002, 2001, '大自然 原木橡木地板', 5, '李女士', '13800000002', '关注卧室木地板与环保等级', 'chengdu', 'new', NULL, 'home_banner', NULL),
    (3, 1003, 5001, '顾家 云朵模块沙发', 8, '王先生', '13800000003', '需要横厅模块拼接建议', 'wuhan', 'following', 2002, 'product_detail', '待约到店体验'),
    (4, 1004, 6001, '柏厚亚麻透光纱帘', 9, '赵女士', '13800000004', '希望先看奶油风窗帘搭配', 'foshan', 'new', NULL, 'product_detail', NULL);

INSERT INTO bh_appointment (
    appointment_id, appointment_no, user_id, customer_name, customer_phone, service_type, preferred_date, preferred_time,
    address, remark, product_id, region_id, status, assigned_to, admin_note, confirmed_at
) VALUES
    (1, 'APT202603150001', 1001, '张先生', '13800000001', 'measure', '2026-03-18', 'morning', '佛山市顺德区示例地址1号', '预约岩板上门量尺', 1001, 'foshan', 'confirmed', 2001, '已确认量尺档期', '2026-03-15 10:00:00'),
    (2, 'APT202603150002', 1002, '李女士', '13800000002', 'install', '2026-03-19', 'afternoon', '成都市高新区示例地址2号', '地板安装前勘测', 2001, 'chengdu', 'pending', NULL, NULL, NULL),
    (3, 'APT202603150003', 1003, '王先生', '13800000003', 'measure', '2026-03-20', 'evening', '武汉市武昌区示例地址3号', '客厅沙发尺寸复尺', 5001, 'wuhan', 'pending', NULL, NULL, NULL),
    (4, 'APT202603150004', 1004, '赵女士', '13800000004', 'install', '2026-03-21', 'morning', '佛山市南海区示例地址4号', '窗帘轨道安装条件确认', 6001, 'foshan', 'confirmed', 2003, '已电话确认', '2026-03-15 11:20:00');

INSERT INTO bh_order (
    order_id, order_no, user_id, region_id, product_id, product_name, unit_price, total_amount, pay_amount, status,
    payment_method, transaction_id, remark, admin_note, tracking_no, paid_at, shipped_at, completed_at, closed_at, expires_at, create_time, update_time
) VALUES
    (1, 'ORD202603150001', 1001, 'foshan', 1001, '萨米特 云雾白岩板 1200x2400', 1299.00, 1299.00, 1299.00, 'paid', 'wechat_pay', 'wx202603150001', '客厅通铺方案', '待安排复尺', NULL, '2026-03-15 09:30:00', NULL, NULL, NULL, '2026-03-15 10:00:00', NOW(), NOW()),
    (2, 'ORD202603150002', 1002, 'chengdu', 2001, '大自然 原木橡木地板', 299.00, 299.00, 299.00, 'pending_pay', NULL, NULL, '卧室地板预定', '待支付', NULL, NULL, NULL, NULL, NULL, '2026-03-15 22:00:00', NOW(), NOW()),
    (3, 'ORD202603150003', 1003, 'wuhan', 5001, '顾家 云朵模块沙发', 5999.00, 5999.00, 5999.00, 'processing', 'wechat_pay', 'wx202603150003', '客厅沙发下单', '安排出库', 'SF20260315003', '2026-03-15 08:20:00', '2026-03-15 14:00:00', NULL, NULL, '2026-03-15 09:00:00', NOW(), NOW()),
    (4, 'ORD202603150004', 1004, 'foshan', 6001, '柏厚亚麻透光纱帘', 499.00, 499.00, 499.00, 'completed', 'wechat_pay', 'wx202603150004', '卧室纱帘方案', '已完成安装', 'CT20260315004', '2026-03-15 07:50:00', '2026-03-15 13:00:00', '2026-03-15 18:00:00', NULL, '2026-03-15 08:30:00', NOW(), NOW());

INSERT INTO bh_order_item (
    item_id, order_id, product_id, product_name, quantity, unit_price, line_amount, create_time
) VALUES
    (1, 1, 1001, '萨米特 云雾白岩板 1200x2400', 1, 1299.00, 1299.00, NOW()),
    (2, 2, 2001, '大自然 原木橡木地板', 1, 299.00, 299.00, NOW()),
    (3, 3, 5001, '顾家 云朵模块沙发', 1, 5999.00, 5999.00, NOW()),
    (4, 4, 6001, '柏厚亚麻透光纱帘', 1, 499.00, 499.00, NOW());
