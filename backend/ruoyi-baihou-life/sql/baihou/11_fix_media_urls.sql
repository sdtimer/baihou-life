-- 修复所有产品图片路径，统一使用本地 /profile/products/ 格式
-- 创建日期: 2026-03-13

-- 更新产品 1001 (现代瓷砖 800x800) 的图片
UPDATE bh_media SET
    url = '/profile/products/tile_1001_scene.jpg',
    thumbnail_url = '/profile/products/tile_1001_scene.jpg'
WHERE media_id = 5001;

UPDATE bh_media SET
    url = '/profile/products/tile_1001_elem.jpg',
    thumbnail_url = '/profile/products/tile_1001_elem.jpg'
WHERE media_id = 5002;

UPDATE bh_media SET
    url = '/profile/products/tile_1001_spec.jpg',
    thumbnail_url = '/profile/products/tile_1001_spec.jpg'
WHERE media_id = 5003;

-- 更新产品 1002 (原木木地板) 的图片
UPDATE bh_media SET
    url = '/profile/products/wood_1002_scene.jpg',
    thumbnail_url = '/profile/products/wood_1002_scene.jpg'
WHERE media_id = 5005;

-- 更新产品 2001 (萨米特岩板) 的图片
UPDATE bh_media SET
    url = '/profile/products/tile_2001_scene.jpg',
    thumbnail_url = '/profile/products/tile_2001_scene.jpg'
WHERE media_id = 6001;

UPDATE bh_media SET
    url = '/profile/products/tile_2001_elem.jpg',
    thumbnail_url = '/profile/products/tile_2001_elem.jpg'
WHERE media_id = 6002;

-- 更新产品 2002 (马可波罗灰砖) 的图片
UPDATE bh_media SET
    url = '/profile/products/tile_2002_scene.jpg',
    thumbnail_url = '/profile/products/tile_2002_scene.jpg'
WHERE media_id = 6003;

-- 更新产品 2003 (意式真皮沙发) 的图片
UPDATE bh_media SET
    url = '/profile/products/sofa_2003_scene1.jpg',
    thumbnail_url = '/profile/products/sofa_2003_scene1.jpg'
WHERE media_id = 6004;

UPDATE bh_media SET
    url = '/profile/products/sofa_2003_scene2.jpg',
    thumbnail_url = '/profile/products/sofa_2003_scene2.jpg'
WHERE media_id = 6005;

-- 更新产品 2004 (羊羔绒懒人沙发) 的图片
UPDATE bh_media SET
    url = '/profile/products/sofa_2004_scene.jpg',
    thumbnail_url = '/profile/products/sofa_2004_scene.jpg'
WHERE media_id = 6006;

-- 验证结果
SELECT p.id, p.name, m.media_id, m.type, m.url
FROM bh_product p
JOIN bh_media m ON p.id = m.product_id
ORDER BY p.id, m.sort_order;
