-- 柏厚生活 B4 设计师管理基础表
-- 创建日期: 2026-03-10

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
