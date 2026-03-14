CREATE TABLE IF NOT EXISTS bh_lead (
    lead_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    product_id BIGINT NULL,
    product_name VARCHAR(128) NULL,
    category_id BIGINT NULL,
    name VARCHAR(64) NULL,
    phone VARCHAR(128) NOT NULL,
    intention TEXT NULL,
    region_id VARCHAR(32) NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'new',
    assigned_to BIGINT NULL,
    source VARCHAR(32) NULL,
    follow_note TEXT NULL,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    del_flag CHAR(1) NOT NULL DEFAULT '0',
    KEY idx_bh_lead_user_product (user_id, product_id),
    KEY idx_bh_lead_region_status (region_id, status),
    KEY idx_bh_lead_create_time (create_time)
);

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
