SET @add_product_id = (
    SELECT IF(
        EXISTS(
            SELECT 1
            FROM information_schema.columns
            WHERE table_schema = DATABASE()
              AND table_name = 'bh_order'
              AND column_name = 'product_id'
        ),
        'SELECT 1',
        'ALTER TABLE bh_order ADD COLUMN product_id BIGINT NOT NULL DEFAULT 0 AFTER region_id'
    )
);
PREPARE stmt FROM @add_product_id;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @add_product_name = (
    SELECT IF(
        EXISTS(
            SELECT 1
            FROM information_schema.columns
            WHERE table_schema = DATABASE()
              AND table_name = 'bh_order'
              AND column_name = 'product_name'
        ),
        'SELECT 1',
        CONCAT(
            'ALTER TABLE bh_order ADD COLUMN product_name VARCHAR(128) NOT NULL DEFAULT ',
            CHAR(39),
            CHAR(39),
            ' AFTER product_id'
        )
    )
);
PREPARE stmt FROM @add_product_name;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @add_unit_price = (
    SELECT IF(
        EXISTS(
            SELECT 1
            FROM information_schema.columns
            WHERE table_schema = DATABASE()
              AND table_name = 'bh_order'
              AND column_name = 'unit_price'
        ),
        'SELECT 1',
        'ALTER TABLE bh_order ADD COLUMN unit_price DECIMAL(10,2) NOT NULL DEFAULT 0.00 AFTER product_name'
    )
);
PREPARE stmt FROM @add_unit_price;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE bh_order
SET product_name = CASE
        WHEN product_name IS NULL OR product_name = '' THEN COALESCE(NULLIF(remark, ''), '历史订单')
        ELSE product_name
    END,
    unit_price = CASE
        WHEN unit_price IS NULL OR unit_price = 0 THEN COALESCE(pay_amount, total_amount, 0)
        ELSE unit_price
    END,
    product_id = COALESCE(product_id, 0);

CREATE TABLE IF NOT EXISTS bh_order_item (
    item_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    product_name VARCHAR(128) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    line_amount DECIMAL(10,2) NOT NULL,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_bh_order_item_order_id (order_id),
    KEY idx_bh_order_item_product_id (product_id)
);

INSERT INTO bh_order_item (
    order_id, product_id, product_name, quantity, unit_price, line_amount, create_time
)
SELECT o.order_id,
       COALESCE(o.product_id, 0),
       COALESCE(NULLIF(o.product_name, ''), '历史订单'),
       1,
       COALESCE(o.unit_price, o.pay_amount, 0),
       COALESCE(o.pay_amount, o.unit_price, 0),
       o.create_time
FROM bh_order o
WHERE NOT EXISTS (
    SELECT 1
    FROM bh_order_item i
    WHERE i.order_id = o.order_id
);
