CREATE TABLE IF NOT EXISTS bh_appointment (
    appointment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    appointment_no VARCHAR(32) NOT NULL,
    user_id BIGINT NOT NULL,
    customer_name VARCHAR(64) NOT NULL,
    customer_phone VARCHAR(128) NOT NULL,
    service_type VARCHAR(16) NOT NULL,
    preferred_date DATE NOT NULL,
    preferred_time VARCHAR(16) NULL,
    address VARCHAR(256) NULL,
    remark TEXT NULL,
    product_id BIGINT NULL,
    region_id VARCHAR(32) NOT NULL,
    status VARCHAR(16) NOT NULL DEFAULT 'pending',
    assigned_to BIGINT NULL,
    admin_note TEXT NULL,
    confirmed_at DATETIME NULL,
    completed_at DATETIME NULL,
    cancelled_at DATETIME NULL,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_bh_appointment_no (appointment_no),
    KEY idx_bh_appointment_user_id (user_id),
    KEY idx_bh_appointment_region_status (region_id, status),
    KEY idx_bh_appointment_preferred_date (preferred_date)
);

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
