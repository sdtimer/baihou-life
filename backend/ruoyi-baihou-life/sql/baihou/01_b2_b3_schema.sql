-- 柏厚生活 B2/B3 基础主数据表
-- 创建日期: 2026-03-10

CREATE TABLE IF NOT EXISTS bh_region (
    region_id     VARCHAR(32)    NOT NULL COMMENT '区域标识',
    region_name   VARCHAR(64)    NOT NULL COMMENT '展示名称',
    province      VARCHAR(32)    NOT NULL COMMENT '省份',
    center_lat    DECIMAL(10,6)  DEFAULT NULL COMMENT '中心纬度',
    center_lng    DECIMAL(10,6)  DEFAULT NULL COMMENT '中心经度',
    is_active     TINYINT(1)     NOT NULL DEFAULT 1 COMMENT '是否启用',
    sort_order    INT            NOT NULL DEFAULT 0 COMMENT '排序',
    create_by     VARCHAR(64)    DEFAULT '' COMMENT '创建者',
    create_time   DATETIME       DEFAULT NULL COMMENT '创建时间',
    update_by     VARCHAR(64)    DEFAULT '' COMMENT '更新者',
    update_time   DATETIME       DEFAULT NULL COMMENT '更新时间',
    remark        VARCHAR(500)   DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (region_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='区域表';

CREATE TABLE IF NOT EXISTS bh_category (
    category_id   BIGINT         NOT NULL AUTO_INCREMENT COMMENT '品类主键',
    parent_id     BIGINT         NOT NULL DEFAULT 0 COMMENT '父级ID(0=一级分类)',
    name          VARCHAR(64)    NOT NULL COMMENT '品类名称',
    icon_url      VARCHAR(256)   DEFAULT NULL COMMENT '图标URL',
    sort_order    INT            NOT NULL DEFAULT 0 COMMENT '同级排序',
    is_active     TINYINT(1)     NOT NULL DEFAULT 1 COMMENT '是否启用',
    create_by     VARCHAR(64)    DEFAULT '' COMMENT '创建者',
    create_time   DATETIME       DEFAULT NULL COMMENT '创建时间',
    update_by     VARCHAR(64)    DEFAULT '' COMMENT '更新者',
    update_time   DATETIME       DEFAULT NULL COMMENT '更新时间',
    remark        VARCHAR(500)   DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (category_id),
    KEY idx_parent_id (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品类表';

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
