-- 柏厚生活业务库初始化/测试数据汇总
-- GENERATED FROM: backend/ruoyi-baihou-life/sql/baihou/*.sql
-- GENERATED AT: 2026-03-15

SET NAMES utf8mb4;

-- =====================================================================
-- SOURCE: 01_b2_b3_schema.sql
-- =====================================================================
INSERT INTO bh_region (region_id, region_name, province, center_lat, center_lng, is_active, sort_order, create_by, create_time)
VALUES
    ('chengdu', '成都', '四川', 30.572815, 104.066801, 1, 10, 'system', NOW()),
    ('foshan', '佛山', '广东', 23.021478, 113.121416, 1, 20, 'system', NOW()),
    ('wuhan', '武汉', '湖北', 30.592760, 114.305250, 1, 30, 'system', NOW())
ON DUPLICATE KEY UPDATE
    region_name = VALUES(region_name),
    province = VALUES(province),
    center_lat = VALUES(center_lat),
    center_lng = VALUES(center_lng),
    is_active = VALUES(is_active),
    sort_order = VALUES(sort_order),
    update_time = NOW();

INSERT INTO bh_category (category_id, parent_id, name, sort_order, is_active, create_by, create_time)
VALUES
    (1, 0, '主材', 10, 1, 'system', NOW()),
    (2, 0, '定制', 20, 1, 'system', NOW()),
    (3, 0, '软装', 30, 1, 'system', NOW()),
    (4, 1, '瓷砖', 10, 1, 'system', NOW()),
    (5, 1, '木地板', 20, 1, 'system', NOW()),
    (6, 2, '橱柜', 10, 1, 'system', NOW()),
    (7, 2, '定制衣柜', 20, 1, 'system', NOW()),
    (8, 3, '沙发', 10, 1, 'system', NOW()),
    (9, 3, '窗帘', 20, 1, 'system', NOW())
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    sort_order = VALUES(sort_order),
    is_active = VALUES(is_active),
    update_time = NOW();

-- =====================================================================
-- SOURCE: 02_b1_product_schema.sql
-- =====================================================================
INSERT INTO bh_product (
    id, name, sku_code, brand, model, category_id, guide_price, price_unit,
    designer_discount, regions, space_tags, scene_tags, spec_params, description,
    status, sort_order, del_flag, create_by, create_time
) VALUES
    (1001, '现代瓷砖 800x800', 'BH-001', '柏厚生活', 'CT-800', 4, 299.00, '元/片',
     0.95, JSON_ARRAY('chengdu', 'foshan'), JSON_ARRAY('living_room'), JSON_ARRAY('new_house'),
     JSON_OBJECT('size', '800x800', 'material', 'ceramic'), '一期初始化示例商品', 'draft', 100, '0', 'system', NOW()),
    (1002, '原木木地板', 'BH-002', '柏厚生活', 'WD-1200', 5, 599.00, '元/平方米',
     0.90, JSON_ARRAY('chengdu'), JSON_ARRAY('bedroom'), JSON_ARRAY('renovation'),
     JSON_OBJECT('size', '1200x190', 'material', 'wood'), '一期初始化示例商品', 'off_shelf', 90, '0', 'system', NOW())
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    brand = VALUES(brand),
    model = VALUES(model),
    category_id = VALUES(category_id),
    guide_price = VALUES(guide_price),
    price_unit = VALUES(price_unit),
    designer_discount = VALUES(designer_discount),
    regions = VALUES(regions),
    space_tags = VALUES(space_tags),
    scene_tags = VALUES(scene_tags),
    spec_params = VALUES(spec_params),
    description = VALUES(description),
    status = VALUES(status),
    sort_order = VALUES(sort_order),
    del_flag = VALUES(del_flag),
    update_time = NOW();

INSERT INTO bh_media (
    media_id, product_id, type, url, thumbnail_url, file_format, file_size,
    file_name, access_level, sort_order, create_time
) VALUES
    (5001, 1001, 'scene', 'https://cdn.example.com/product/1001/scene_01.webp', 'https://cdn.example.com/product/1001/scene_01_thumb.webp', 'webp', 102400, 'scene_01.webp', 'public', 10, NOW()),
    (5002, 1001, 'element', 'https://cdn.example.com/product/1001/element_01.webp', 'https://cdn.example.com/product/1001/element_01_thumb.webp', 'webp', 87322, 'element_01.webp', 'public', 20, NOW()),
    (5003, 1001, 'spec', 'https://cdn.example.com/product/1001/spec_01.webp', 'https://cdn.example.com/product/1001/spec_01_thumb.webp', 'webp', 76420, 'spec_01.webp', 'public', 30, NOW()),
    (5004, 1001, 'source', NULL, NULL, 'skp', 15728640, 'BH-001.skp', 'designer', 40, NOW()),
    (5005, 1002, 'scene', 'https://cdn.example.com/product/1002/scene_01.webp', 'https://cdn.example.com/product/1002/scene_01_thumb.webp', 'webp', 95421, 'scene_01.webp', 'public', 10, NOW())
ON DUPLICATE KEY UPDATE
    product_id = VALUES(product_id),
    type = VALUES(type),
    url = VALUES(url),
    thumbnail_url = VALUES(thumbnail_url),
    file_format = VALUES(file_format),
    file_size = VALUES(file_size),
    file_name = VALUES(file_name),
    access_level = VALUES(access_level),
    sort_order = VALUES(sort_order);

-- =====================================================================
-- SOURCE: 03_b6_banner_schema.sql
-- =====================================================================
INSERT INTO bh_banner (banner_id, title, image_url, link_type, link_value, regions, start_time, end_time, sort_order, is_active, create_time, update_time)
VALUES
    (1, '首页推荐', 'https://cdn.example.com/banner-home.jpg', 'url', 'https://baihou-life.example.com', JSON_ARRAY('ALL'), NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 100, 1, NOW(), NOW()),
    (2, '佛山专区', 'https://cdn.example.com/banner-foshan.jpg', 'category', '4', JSON_ARRAY('foshan'), NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 90, 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE
    title = VALUES(title),
    image_url = VALUES(image_url),
    link_type = VALUES(link_type),
    link_value = VALUES(link_value),
    regions = VALUES(regions),
    start_time = VALUES(start_time),
    end_time = VALUES(end_time),
    sort_order = VALUES(sort_order),
    is_active = VALUES(is_active),
    update_time = NOW();

-- =====================================================================
-- SOURCE: 04_b4_designer_schema.sql
-- =====================================================================
INSERT INTO bh_designer_group (group_id, group_name, default_discount, create_time, update_time)
VALUES
    (1, '核心设计师', 0.90, NOW(), NOW()),
    (2, '合作设计师', 0.95, NOW(), NOW())
ON DUPLICATE KEY UPDATE
    group_name = VALUES(group_name),
    default_discount = VALUES(default_discount),
    update_time = NOW();

INSERT INTO bh_wx_user (uid, openid, phone, phone_hash, nickname, role, status, create_time, update_time)
VALUES
    (1001, 'wx-openid-1001', 'AES:13900005678', 'hash-13900005678', '设计师候选用户', 1, 'active', NOW(), NOW())
ON DUPLICATE KEY UPDATE
    phone = VALUES(phone),
    phone_hash = VALUES(phone_hash),
    nickname = VALUES(nickname),
    role = VALUES(role),
    status = VALUES(status),
    update_time = NOW();

INSERT INTO bh_designer (designer_id, user_id, name, phone, phone_hash, company, group_id, discount, status, download_count, create_by, create_time, update_by, update_time)
VALUES
    (1, 1001, '张三', 'AES:13900005678', 'hash-13900005678', '柏厚设计', 1, 0.88, 'active', 0, 'system', NOW(), 'system', NOW())
ON DUPLICATE KEY UPDATE
    user_id = VALUES(user_id),
    name = VALUES(name),
    phone = VALUES(phone),
    phone_hash = VALUES(phone_hash),
    company = VALUES(company),
    group_id = VALUES(group_id),
    discount = VALUES(discount),
    status = VALUES(status),
    update_time = NOW();

-- =====================================================================
-- SOURCE: 05_b5_lead_schema.sql
-- =====================================================================
INSERT INTO bh_lead (lead_id, user_id, product_id, product_name, category_id, name, phone, intention, region_id, status, assigned_to, source, follow_note)
VALUES
    (1, 1001, 1, '云幕沙发', 10, '张先生', '13800000001', '偏现代客厅方案', 'foshan', 'new', NULL, 'product_detail', NULL),
    (2, 1002, 2, '山影茶几', 20, '李女士', '13800000002', '希望三天内上门沟通', 'guangzhou', 'following', 2001, 'home_banner', '已联系客户')
ON DUPLICATE KEY UPDATE
    product_name = VALUES(product_name),
    category_id = VALUES(category_id),
    status = VALUES(status),
    assigned_to = VALUES(assigned_to),
    source = VALUES(source),
    follow_note = VALUES(follow_note),
    update_time = CURRENT_TIMESTAMP;

-- =====================================================================
-- SOURCE: 06_b7_appointment_schema.sql
-- =====================================================================
INSERT INTO bh_appointment (
    appointment_id, appointment_no, user_id, customer_name, customer_phone, service_type, preferred_date,
    preferred_time, address, remark, product_id, region_id, status, assigned_to, admin_note
) VALUES
    (1, 'APT202603100001', 1001, '张先生', '13800000001', 'measure', '2026-03-12', 'morning', '佛山市顺德区示例地址1号', '上门量尺', 1, 'foshan', 'pending', NULL, NULL),
    (2, 'APT202603100002', 1002, '李女士', '13800000002', 'install', '2026-03-13', 'afternoon', '广州市天河区示例地址2号', '安装服务', 2, 'guangzhou', 'confirmed', 3001, '已电话确认')
ON DUPLICATE KEY UPDATE
    status = VALUES(status),
    assigned_to = VALUES(assigned_to),
    admin_note = VALUES(admin_note),
    update_time = CURRENT_TIMESTAMP;

-- =====================================================================
-- SOURCE: 07_b8_order_schema.sql
-- =====================================================================
INSERT INTO bh_order (
    order_id, order_no, user_id, region_id, total_amount, pay_amount, status,
    payment_method, transaction_id, remark, admin_note, tracking_no, paid_at, shipped_at, completed_at, closed_at, expires_at
) VALUES
    (1, 'ORD202603100001', 1001, 'foshan', 1280.00, 1280.00, 'paid', 'wechat_pay', 'wx202603100001', '客厅套装', '待确认处理', NULL, '2026-03-10 09:30:00', NULL, NULL, NULL, '2026-03-10 10:00:00'),
    (2, 'ORD202603100002', 1002, 'guangzhou', 860.00, 860.00, 'processing', 'wechat_pay', 'wx202603100002', '餐厅单品', '安排出库', NULL, '2026-03-10 08:30:00', NULL, NULL, NULL, '2026-03-10 09:00:00')
ON DUPLICATE KEY UPDATE
    status = VALUES(status),
    admin_note = VALUES(admin_note),
    tracking_no = VALUES(tracking_no),
    update_time = CURRENT_TIMESTAMP;

-- =====================================================================
-- SOURCE: 09_test_data.sql
-- =====================================================================
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

-- =====================================================================
-- SOURCE: 10_more_test_data.sql
-- =====================================================================
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

-- =====================================================================
-- SOURCE: 12_spec_dict_init.sql
-- =====================================================================
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

