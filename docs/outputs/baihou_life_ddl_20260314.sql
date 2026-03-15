-- 柏厚生活业务库 DDL 汇总
-- GENERATED FROM: backend/ruoyi-baihou-life/sql/baihou/*.sql
-- GENERATED AT: 2026-03-15

SET NAMES utf8mb4;

-- =====================================================================
-- SOURCE: 01_b2_b3_schema.sql
-- =====================================================================
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

-- =====================================================================
-- SOURCE: 02_b1_product_schema.sql
-- =====================================================================
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
    file_format    VARCHAR(16)    DEFAULT NULL COMMENT '文件格式',
    file_size      BIGINT         DEFAULT NULL COMMENT '文件大小(字节)',
    file_name      VARCHAR(256)   DEFAULT NULL COMMENT '原始文件名',
    access_level   VARCHAR(16)    NOT NULL DEFAULT 'public' COMMENT '访问级别(public/designer)',
    sort_order     INT            NOT NULL DEFAULT 0 COMMENT '排序',
    create_time    DATETIME       DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (media_id),
    KEY idx_product_type (product_id, type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='媒体资源表';

-- =====================================================================
-- SOURCE: 03_b6_banner_schema.sql
-- =====================================================================
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

-- =====================================================================
-- SOURCE: 04_b4_designer_schema.sql
-- =====================================================================
CREATE TABLE IF NOT EXISTS bh_wx_user (
    uid              BIGINT         NOT NULL AUTO_INCREMENT COMMENT '用户主键',
    openid           VARCHAR(64)    NOT NULL COMMENT '微信openid',
    unionid          VARCHAR(64)    DEFAULT NULL COMMENT '微信unionid',
    phone            VARCHAR(128)   DEFAULT NULL COMMENT '手机号(AES加密)',
    phone_hash       VARCHAR(64)    DEFAULT NULL COMMENT '手机号哈希(用于查询匹配)',
    nickname         VARCHAR(64)    DEFAULT NULL COMMENT '微信昵称',
    avatar_url       VARCHAR(512)   DEFAULT NULL COMMENT '头像URL',
    role             TINYINT        NOT NULL DEFAULT 1 COMMENT '角色(0游客/1客户/2设计师/99管理员)',
    region_id        VARCHAR(32)    DEFAULT NULL COMMENT '默认区域',
    status           VARCHAR(16)    NOT NULL DEFAULT 'active' COMMENT '状态(active/disabled)',
    last_login_time  DATETIME       DEFAULT NULL COMMENT '最近登录时间',
    create_time      DATETIME       DEFAULT NULL COMMENT '注册时间',
    update_time      DATETIME       DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (uid),
    UNIQUE KEY uk_openid (openid),
    KEY idx_phone_hash (phone_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信用户表';

CREATE TABLE IF NOT EXISTS bh_designer_group (
    group_id          BIGINT         NOT NULL AUTO_INCREMENT COMMENT '分组主键',
    group_name        VARCHAR(64)    NOT NULL COMMENT '分组名称',
    default_discount  DECIMAL(3,2)   NOT NULL DEFAULT 1.00 COMMENT '默认折扣率',
    create_time       DATETIME       DEFAULT NULL COMMENT '创建时间',
    update_time       DATETIME       DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='设计师分组表';

CREATE TABLE IF NOT EXISTS bh_designer (
    designer_id     BIGINT         NOT NULL AUTO_INCREMENT COMMENT '设计师主键',
    user_id         BIGINT         DEFAULT NULL COMMENT '关联微信用户ID',
    name            VARCHAR(64)    NOT NULL COMMENT '姓名',
    phone           VARCHAR(128)   NOT NULL COMMENT '手机号(AES加密)',
    phone_hash      VARCHAR(64)    NOT NULL COMMENT '手机号哈希',
    company         VARCHAR(128)   DEFAULT NULL COMMENT '所属公司',
    group_id        BIGINT         DEFAULT NULL COMMENT '所属分组ID',
    discount        DECIMAL(3,2)   DEFAULT NULL COMMENT '专属折扣率',
    status          VARCHAR(16)    NOT NULL DEFAULT 'active' COMMENT '状态(active/disabled)',
    download_count  INT            NOT NULL DEFAULT 0 COMMENT '累计下载次数',
    last_active_at  DATETIME       DEFAULT NULL COMMENT '最近活跃时间',
    create_by       VARCHAR(64)    DEFAULT '' COMMENT '创建者',
    create_time     DATETIME       DEFAULT NULL COMMENT '创建时间',
    update_by       VARCHAR(64)    DEFAULT '' COMMENT '更新者',
    update_time     DATETIME       DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (designer_id),
    UNIQUE KEY uk_phone_hash (phone_hash),
    KEY idx_user_id (user_id),
    KEY idx_group_id (group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='设计师表';

-- =====================================================================
-- SOURCE: 05_b5_lead_schema.sql
-- =====================================================================
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

-- =====================================================================
-- SOURCE: 06_b7_appointment_schema.sql
-- =====================================================================
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

-- =====================================================================
-- SOURCE: 07_b8_order_schema.sql
-- =====================================================================
CREATE TABLE IF NOT EXISTS bh_order (
    order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_no VARCHAR(32) NOT NULL,
    user_id BIGINT NOT NULL,
    region_id VARCHAR(32) NOT NULL,
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

-- =====================================================================
-- SOURCE: 12_spec_dict_init.sql
-- =====================================================================
CREATE TABLE IF NOT EXISTS `bh_category_spec_def` (
  `spec_def_id`  bigint       NOT NULL AUTO_INCREMENT COMMENT '规格定义ID',
  `category_id`  bigint       NOT NULL                COMMENT '品类ID',
  `spec_key`     varchar(64)  NOT NULL                COMMENT '字段Key（英文）',
  `spec_label`   varchar(64)  NOT NULL                COMMENT '显示名称',
  `input_type`   varchar(20)  NOT NULL DEFAULT 'text' COMMENT '输入类型：text/number/select',
  `options`      varchar(500)          DEFAULT NULL   COMMENT '选项 JSON（select类型用）',
  `unit`         varchar(32)           DEFAULT NULL   COMMENT '单位',
  `is_required`  tinyint      NOT NULL DEFAULT 0      COMMENT '是否必填：0否 1是',
  `sort_order`   int          NOT NULL DEFAULT 10     COMMENT '排序',
  `create_by`    varchar(64)           DEFAULT ''     COMMENT '创建者',
  `create_time`  datetime              DEFAULT NULL   COMMENT '创建时间',
  `update_by`    varchar(64)           DEFAULT ''     COMMENT '更新者',
  `update_time`  datetime              DEFAULT NULL   COMMENT '更新时间',
  `remark`       varchar(500)          DEFAULT NULL   COMMENT '备注',
  PRIMARY KEY (`spec_def_id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品类规格定义';

