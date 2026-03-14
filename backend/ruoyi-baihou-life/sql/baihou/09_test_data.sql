-- 柏厚生活 测试数据 (瓷砖、软装)
-- 创建日期: 2026-03-13

INSERT INTO bh_product (
    id, name, sku_code, brand, model, category_id, guide_price, price_unit,
    designer_discount, regions, space_tags, scene_tags, spec_params, description,
    status, sort_order, del_flag, create_by, create_time
) VALUES
    (2001, '萨米特 奢石岩板 1200x2400', 'BH-T-001', '萨米特', 'SMT-YS-1224', 4, 1299.00, '元/片',
     0.85, JSON_ARRAY('chengdu', 'foshan', 'wuhan'), JSON_ARRAY('living_room', 'bathroom'), JSON_ARRAY('new_house', 'villa'),
     JSON_OBJECT('size', '1200x2400', 'material', 'sintered_stone', 'thickness', '9mm'), '萨米特奢石系列大规格岩板，质感非凡', 'on_shelf', 10, '0', 'system', NOW()),

    (2002, '马可波罗 现代灰 600x1200', 'BH-T-002', '马可波罗', 'MKL-H-612', 4, 159.00, '元/片',
     0.90, JSON_ARRAY('chengdu', 'foshan'), JSON_ARRAY('living_room', 'kitchen', 'balcony'), JSON_ARRAY('renovation', 'new_house'),
     JSON_OBJECT('size', '600x1200', 'material', 'ceramic', 'finish', 'matte'), '马可波罗现代简约哑光防滑灰砖', 'on_shelf', 20, '0', 'system', NOW()),

    (2003, '米兰极简 意式真皮沙发 3人座', 'BH-S-001', '柏厚精选', 'BH-SF-01', 8, 8999.00, '元/套',
     0.80, JSON_ARRAY('chengdu', 'foshan', 'wuhan'), JSON_ARRAY('living_room'), JSON_ARRAY('new_house'),
     JSON_OBJECT('material', 'leather', 'color', 'caramel', 'seat', '3'), '意式极简头层牛皮沙发，人体工学设计，舒适坐感', 'on_shelf', 30, '0', 'system', NOW()),

    (2004, '北欧风 羊羔绒布艺懒人沙发', 'BH-S-002', '柏厚精选', 'BH-SF-02', 8, 1299.00, '元/件',
     0.85, JSON_ARRAY('chengdu', 'wuhan'), JSON_ARRAY('bedroom', 'study_room'), JSON_ARRAY('renovation'),
     JSON_OBJECT('material', 'fabric', 'color', 'off_white'), '网红款布艺懒人沙发，角落里的松弛感', 'on_shelf', 40, '0', 'system', NOW())
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    brand = VALUES(brand),
    guide_price = VALUES(guide_price),
    description = VALUES(description),
    status = VALUES(status),
    update_time = NOW();

INSERT INTO bh_media (
    media_id, product_id, type, url, thumbnail_url, file_format, file_size,
    file_name, access_level, sort_order, create_time
) VALUES
    -- 萨米特岩板 媒体
    (6001, 2001, 'scene', 'https://images.unsplash.com/photo-1615876234886-fd9a39fda97f?auto=format&fit=crop&q=80&w=800', 'https://images.unsplash.com/photo-1615876234886-fd9a39fda97f?auto=format&fit=crop&q=80&w=200', 'jpg', 150000, 'scene_t001_1.jpg', 'public', 10, NOW()),
    (6002, 2001, 'element', 'https://images.unsplash.com/photo-1618219908412-a29a1bb7b86e?auto=format&fit=crop&q=80&w=800', 'https://images.unsplash.com/photo-1618219908412-a29a1bb7b86e?auto=format&fit=crop&q=80&w=200', 'jpg', 120000, 'element_t001_1.jpg', 'public', 20, NOW()),

    -- 马可波罗灰砖 媒体
    (6003, 2002, 'scene', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=800', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=200', 'jpg', 140000, 'scene_t002_1.jpg', 'public', 10, NOW()),
    
    -- 真皮沙发 媒体
    (6004, 2003, 'scene', 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=800', 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=200', 'jpg', 160000, 'scene_s001_1.jpg', 'public', 10, NOW()),
    (6005, 2003, 'scene', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&q=80&w=800', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&q=80&w=200', 'jpg', 170000, 'scene_s001_2.jpg', 'public', 20, NOW()),

    -- 懒人沙发 媒体
    (6006, 2004, 'scene', 'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&q=80&w=800', 'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&q=80&w=200', 'jpg', 130000, 'scene_s002_1.jpg', 'public', 10, NOW())
ON DUPLICATE KEY UPDATE
    url = VALUES(url),
    thumbnail_url = VALUES(thumbnail_url);
