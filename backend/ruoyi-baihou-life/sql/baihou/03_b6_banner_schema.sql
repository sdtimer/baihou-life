-- 柏厚生活 B6 Banner 管理基础表
-- 创建日期: 2026-03-10

CREATE TABLE IF NOT EXISTS bh_banner (
    banner_id    BIGINT         NOT NULL AUTO_INCREMENT COMMENT 'Banner主键',
    title        VARCHAR(128)   NOT NULL COMMENT '标题',
    image_url    VARCHAR(512)   NOT NULL COMMENT '图片地址',
    link_type    VARCHAR(16)    NOT NULL COMMENT '跳转类型(product/category/url/none)',
    link_value   VARCHAR(256)   DEFAULT NULL COMMENT '跳转目标',
    regions      JSON           DEFAULT NULL COMMENT '展示区域JSON',
    start_time   DATETIME       DEFAULT NULL COMMENT '展示开始时间',
    end_time     DATETIME       DEFAULT NULL COMMENT '展示结束时间',
    sort_order   INT            NOT NULL DEFAULT 0 COMMENT '排序',
    is_active    TINYINT(1)     NOT NULL DEFAULT 1 COMMENT '是否启用',
    create_time  DATETIME       DEFAULT NULL COMMENT '创建时间',
    update_time  DATETIME       DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (banner_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Banner推荐位表';

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
