-- 柏厚生活 B1 商品管理基础表
-- 创建日期: 2026-03-10

CREATE TABLE IF NOT EXISTS bh_product (
    id                  BIGINT         NOT NULL AUTO_INCREMENT COMMENT '商品主键',
    name                VARCHAR(128)   NOT NULL COMMENT '商品名称',
    sku_code            VARCHAR(64)    NOT NULL COMMENT 'SKU编码',
    brand               VARCHAR(64)    DEFAULT NULL COMMENT '品牌',
    model               VARCHAR(64)    DEFAULT NULL COMMENT '型号',
    category_id         BIGINT         NOT NULL COMMENT '品类ID',
    guide_price         DECIMAL(10,2)  DEFAULT NULL COMMENT '指导价(元)',
    price_unit          VARCHAR(16)    DEFAULT NULL COMMENT '计价单位',
    designer_discount   DECIMAL(3,2)   NOT NULL DEFAULT 1.00 COMMENT '设计师折扣率',
    regions             JSON           DEFAULT NULL COMMENT '可售区域JSON数组',
    space_tags          JSON           DEFAULT NULL COMMENT '空间标签JSON数组',
    scene_tags          JSON           DEFAULT NULL COMMENT '场景标签JSON数组',
    spec_params         JSON           DEFAULT NULL COMMENT '规格参数JSON',
    description         TEXT           DEFAULT NULL COMMENT '商品描述',
    status              VARCHAR(16)    NOT NULL DEFAULT 'draft' COMMENT '状态(draft/on_shelf/off_shelf/archived)',
    sort_order          INT            NOT NULL DEFAULT 0 COMMENT '排序权重',
    del_flag            CHAR(1)        NOT NULL DEFAULT '0' COMMENT '删除标志(0正常 1删除)',
    create_by           VARCHAR(64)    DEFAULT '' COMMENT '创建者',
    create_time         DATETIME       DEFAULT NULL COMMENT '创建时间',
    update_by           VARCHAR(64)    DEFAULT '' COMMENT '更新者',
    update_time         DATETIME       DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_sku_code (sku_code),
    KEY idx_category_status (category_id, status),
    KEY idx_status_sort (status, sort_order, create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

CREATE TABLE IF NOT EXISTS bh_media (
    media_id       BIGINT         NOT NULL AUTO_INCREMENT COMMENT '媒体主键',
    product_id     BIGINT         NOT NULL COMMENT '关联商品ID',
    type           VARCHAR(16)    NOT NULL COMMENT '类型(scene/element/spec/source)',
    url            VARCHAR(512)   DEFAULT NULL COMMENT 'CDN地址',
    thumbnail_url  VARCHAR(512)   DEFAULT NULL COMMENT '缩略图地址',
    original_url   VARCHAR(512)   DEFAULT NULL COMMENT '高清原图地址',
    file_format    VARCHAR(16)    DEFAULT NULL COMMENT '文件格式',
    file_size      BIGINT         DEFAULT NULL COMMENT '文件大小(字节)',
    file_name      VARCHAR(256)   DEFAULT NULL COMMENT '原始文件名',
    access_level   VARCHAR(16)    NOT NULL DEFAULT 'public' COMMENT '访问级别(public/designer)',
    asset_role     VARCHAR(16)    NOT NULL DEFAULT 'display' COMMENT '资源角色(display/download)',
    is_cover       TINYINT(1)     NOT NULL DEFAULT 0 COMMENT '是否主图',
    width          INT            DEFAULT NULL COMMENT '图片宽度',
    height         INT            DEFAULT NULL COMMENT '图片高度',
    sort_order     INT            NOT NULL DEFAULT 0 COMMENT '排序',
    create_time    DATETIME       DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (media_id),
    KEY idx_product_type (product_id, type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='媒体资源表';

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
