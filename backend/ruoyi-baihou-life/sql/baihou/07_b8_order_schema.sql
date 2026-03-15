CREATE TABLE IF NOT EXISTS bh_order (
    order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_no VARCHAR(32) NOT NULL,
    user_id BIGINT NOT NULL,
    region_id VARCHAR(32) NOT NULL,
    product_id BIGINT NOT NULL,
    product_name VARCHAR(128) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    pay_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(16) NOT NULL DEFAULT 'pending_pay',
    payment_method VARCHAR(16) NULL,
    transaction_id VARCHAR(64) NULL,
    remark TEXT NULL,
    admin_note TEXT NULL,
    tracking_no VARCHAR(64) NULL,
    paid_at DATETIME NULL,
    shipped_at DATETIME NULL,
    completed_at DATETIME NULL,
    closed_at DATETIME NULL,
    expires_at DATETIME NULL,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_bh_order_no (order_no),
    KEY idx_bh_order_user_id (user_id),
    KEY idx_bh_order_status (status),
    KEY idx_bh_order_status_expires (status, expires_at),
    KEY idx_bh_order_create_time (create_time)
);

INSERT INTO bh_order (
    order_id, order_no, user_id, region_id, product_id, product_name, unit_price, total_amount, pay_amount, status,
    payment_method, transaction_id, remark, admin_note, tracking_no, paid_at, shipped_at, completed_at, closed_at, expires_at
) VALUES
    (1, 'ORD202603100001', 1001, 'foshan', 10001, '客厅套装', 1280.00, 1280.00, 1280.00, 'paid', 'wechat_pay', 'wx202603100001', '客厅套装', '待确认处理', NULL, '2026-03-10 09:30:00', NULL, NULL, NULL, '2026-03-10 10:00:00'),
    (2, 'ORD202603100002', 1002, 'guangzhou', 10002, '餐厅单品', 860.00, 860.00, 860.00, 'processing', 'wechat_pay', 'wx202603100002', '餐厅单品', '安排出库', NULL, '2026-03-10 08:30:00', NULL, NULL, NULL, '2026-03-10 09:00:00')
ON DUPLICATE KEY UPDATE
    product_id = VALUES(product_id),
    product_name = VALUES(product_name),
    unit_price = VALUES(unit_price),
    status = VALUES(status),
    admin_note = VALUES(admin_note),
    tracking_no = VALUES(tracking_no),
    update_time = CURRENT_TIMESTAMP;
