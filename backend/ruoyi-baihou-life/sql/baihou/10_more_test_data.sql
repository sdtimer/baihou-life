-- 柏厚生活 测试数据 (补充佛山相关所有品类)
-- 包含：瓷砖、木地板、橱柜、定制衣柜、沙发、窗帘

INSERT INTO bh_product (
    id, name, sku_code, brand, model, category_id, guide_price, price_unit,
    designer_discount, regions, space_tags, scene_tags, spec_params, description,
    status, sort_order, del_flag, create_by, create_time
) VALUES
    (3001, '蒙娜丽莎 抗菌薄板瓷砖 600x1200', 'BH-T-003', '蒙娜丽莎', 'MN-6120', 4, 129.00, '元/片',
     0.90, JSON_ARRAY('chengdu', 'foshan'), JSON_ARRAY('living_room', 'bathroom'), JSON_ARRAY('minimalist', 'wabi_sabi'),
     JSON_OBJECT('size', '600x1200', 'material', 'ceramic'), '抗菌自洁釉面，适用于极简风设计', 'on_shelf', 10, '0', 'system', NOW()),

    (3002, '大自然 橡木实木复合地板', 'BH-W-001', '大自然', 'DZR-X-1200', 5, 299.00, '元/平米',
     0.85, JSON_ARRAY('chengdu', 'foshan'), JSON_ARRAY('bedroom', 'living_room'), JSON_ARRAY('healing', 'minimalist'),
     JSON_OBJECT('size', '1200x150', 'material', 'wood'), '环保等级ENF级，治愈系原木色', 'on_shelf', 20, '0', 'system', NOW()),

    (3003, '欧派 极简一字型橱柜', 'BH-C-001', '欧派', 'OP-K-001', 6, 9999.00, '元/套',
     0.80, JSON_ARRAY('chengdu', 'foshan', 'wuhan'), JSON_ARRAY('kitchen'), JSON_ARRAY('minimalist'),
     JSON_OBJECT('material', 'quartz_stone', 'style', 'straight'), '极简高柜内嵌电器，防污门板', 'on_shelf', 30, '0', 'system', NOW()),

    (3004, '索菲亚 铝框玻璃对开门衣柜', 'BH-CW-001', '索菲亚', 'SFY-W-001', 7, 7999.00, '元/套',
     0.80, JSON_ARRAY('chengdu', 'foshan', 'wuhan'), JSON_ARRAY('bedroom'), JSON_ARRAY('minimalist', 'healing'),
     JSON_OBJECT('material', 'glass', 'style', 'aluminum'), '窄边铝框，茶色玻璃，自带智能感应灯', 'on_shelf', 40, '0', 'system', NOW()),
     
    (3005, '顾家家居 豆腐块模块沙发', 'BH-S-003', '顾家家居', 'GJ-SF-03', 8, 4599.00, '元/套',
     0.85, JSON_ARRAY('chengdu', 'foshan', 'wuhan'), JSON_ARRAY('living_room'), JSON_ARRAY('wabi_sabi', 'healing'),
     JSON_OBJECT('material', 'fabric', 'seats', '4'), '科技布防猫抓系列，自由模块拼合', 'on_shelf', 50, '0', 'system', NOW()),

    (3006, '日式 亚麻透光遮纱窗帘', 'BH-CT-001', '柏厚精选', 'BH-CT-001', 9, 499.00, '元/米',
     0.90, JSON_ARRAY('chengdu', 'foshan', 'wuhan'), JSON_ARRAY('living_room', 'bedroom'), JSON_ARRAY('wabi_sabi', 'healing'),
     JSON_OBJECT('material', 'linen', 'shading', '50%'), '日式侘寂风，自然垂坠感强', 'on_shelf', 60, '0', 'system', NOW())
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    brand = VALUES(brand),
    guide_price = VALUES(guide_price),
    description = VALUES(description),
    status = VALUES(status);

INSERT INTO bh_media (
    media_id, product_id, type, url, thumbnail_url, file_format, file_size,
    file_name, access_level, sort_order, create_time
) VALUES
    (7001, 3001, 'scene', '/profile/products/tile.jpg', '/profile/products/tile.jpg', 'jpg', 150000, 'tile.jpg', 'public', 10, NOW()),
    (7002, 3002, 'scene', '/profile/products/wood.jpg', '/profile/products/wood.jpg', 'jpg', 150000, 'wood.jpg', 'public', 10, NOW()),
    (7003, 3003, 'scene', '/profile/products/cabinet.jpg', '/profile/products/cabinet.jpg', 'jpg', 150000, 'cabinet.jpg', 'public', 10, NOW()),
    (7004, 3004, 'scene', '/profile/products/wardrobe.jpg', '/profile/products/wardrobe.jpg', 'jpg', 150000, 'wardrobe.jpg', 'public', 10, NOW()),
    (7005, 3005, 'scene', '/profile/products/sofa.jpg', '/profile/products/sofa.jpg', 'jpg', 150000, 'sofa.jpg', 'public', 10, NOW()),
    (7006, 3006, 'scene', '/profile/products/curtain.jpg', '/profile/products/curtain.jpg', 'jpg', 150000, 'curtain.jpg', 'public', 10, NOW())
ON DUPLICATE KEY UPDATE
    url = VALUES(url),
    thumbnail_url = VALUES(thumbnail_url);
