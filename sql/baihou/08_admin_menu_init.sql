-- 柏厚生活后台管理菜单初始化
-- 执行前请确认 sys_menu / sys_role_menu 已按若依默认结构创建

DELETE FROM sys_role_menu WHERE menu_id BETWEEN 2000 AND 2099;
DELETE FROM sys_menu WHERE menu_id BETWEEN 2000 AND 2099;

INSERT INTO sys_menu VALUES ('2000', '柏厚生活', '0', '6', 'baihou', '', '', '', 1, 0, 'M', '0', '0', '', 'guide', 'admin', sysdate(), '', NULL, '柏厚生活业务目录');

INSERT INTO sys_menu VALUES ('2001', '商品管理', '2000', '1', 'products', 'baihou/products/index', '', '', 1, 0, 'C', '0', '0', 'baihou:product:list', 'shopping', 'admin', sysdate(), '', NULL, '柏厚生活商品管理');
INSERT INTO sys_menu VALUES ('2002', '品类管理', '2000', '2', 'categories', 'baihou/categories/index', '', '', 1, 0, 'C', '0', '0', 'baihou:category:list', 'tree-table', 'admin', sysdate(), '', NULL, '柏厚生活品类管理');
INSERT INTO sys_menu VALUES ('2003', '区域管理', '2000', '3', 'regions', 'baihou/regions/index', '', '', 1, 0, 'C', '0', '0', 'baihou:region:list', 'guide', 'admin', sysdate(), '', NULL, '柏厚生活区域管理');
INSERT INTO sys_menu VALUES ('2004', 'Banner管理', '2000', '4', 'banners', 'baihou/banners/index', '', '', 1, 0, 'C', '0', '0', 'baihou:banner:list', 'build', 'admin', sysdate(), '', NULL, '柏厚生活Banner管理');
INSERT INTO sys_menu VALUES ('2005', '设计师管理', '2000', '5', 'designers', 'baihou/designers/index', '', '', 1, 0, 'C', '0', '0', 'baihou:designer:list', 'peoples', 'admin', sysdate(), '', NULL, '柏厚生活设计师管理');
INSERT INTO sys_menu VALUES ('2006', '设计师分组', '2000', '6', 'designer-groups', 'baihou/designer-groups/index', '', '', 1, 0, 'C', '0', '0', 'baihou:designerGroup:list', 'tree', 'admin', sysdate(), '', NULL, '柏厚生活设计师分组');
INSERT INTO sys_menu VALUES ('2007', '线索管理', '2000', '7', 'leads', 'baihou/leads/index', '', '', 1, 0, 'C', '0', '0', 'baihou:lead:list', 'message', 'admin', sysdate(), '', NULL, '柏厚生活线索管理');
INSERT INTO sys_menu VALUES ('2008', '预约管理', '2000', '8', 'appointments', 'baihou/appointments/index', '', '', 1, 0, 'C', '0', '0', 'baihou:appointment:list', 'date', 'admin', sysdate(), '', NULL, '柏厚生活预约管理');
INSERT INTO sys_menu VALUES ('2009', '订单管理', '2000', '9', 'orders', 'baihou/orders/index', '', '', 1, 0, 'C', '0', '0', 'baihou:order:list', 'money', 'admin', sysdate(), '', NULL, '柏厚生活订单管理');

INSERT INTO sys_menu VALUES ('2010', '商品查询', '2001', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:product:query', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2011', '商品新增', '2001', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:product:add', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2012', '商品修改', '2001', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:product:edit', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2013', '商品归档', '2001', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:product:remove', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu VALUES ('2014', '品类新增', '2002', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:category:add', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2015', '品类修改', '2002', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:category:edit', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu VALUES ('2016', '区域新增', '2003', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:region:add', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2017', '区域修改', '2003', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:region:edit', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu VALUES ('2018', 'Banner新增', '2004', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:banner:add', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2019', 'Banner修改', '2004', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:banner:edit', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2020', 'Banner删除', '2004', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:banner:remove', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu VALUES ('2021', '设计师新增', '2005', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:designer:add', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2022', '设计师修改', '2005', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:designer:edit', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu VALUES ('2023', '分组新增', '2006', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:designerGroup:add', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2024', '分组修改', '2006', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:designerGroup:edit', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu VALUES ('2025', '线索更新', '2007', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:lead:edit', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2026', '线索导出', '2007', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:lead:export', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu VALUES ('2027', '预约更新', '2008', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:appointment:edit', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES ('2028', '订单更新', '2009', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'baihou:order:edit', '#', 'admin', sysdate(), '', NULL, '');

-- 管理员角色默认授权
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 1, menu_id
FROM sys_menu
WHERE menu_id BETWEEN 2000 AND 2028;
