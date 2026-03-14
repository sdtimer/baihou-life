import os, urllib.request, time

dest_dir = '/Users/timer/2026开发/生活产品展示/uploadPath/products'
os.makedirs(dest_dir, exist_ok=True)

images = [
    # 旧产品 1001 - 瓷砖
    ('tile_1001_scene.jpg',   'https://picsum.photos/seed/ceramic001/800/800.jpg'),
    ('tile_1001_elem.jpg',    'https://picsum.photos/seed/ceramic002/800/800.jpg'),
    ('tile_1001_spec.jpg',    'https://picsum.photos/seed/ceramic003/800/800.jpg'),
    # 旧产品 1002 - 木地板
    ('wood_1002_scene.jpg',   'https://picsum.photos/seed/woodfloor1/800/800.jpg'),
    # 产品 2001 - 岩板
    ('tile_2001_scene.jpg',   'https://picsum.photos/seed/stoneslb01/800/800.jpg'),
    ('tile_2001_elem.jpg',    'https://picsum.photos/seed/stoneslb02/800/800.jpg'),
    # 产品 2002 - 灰砖
    ('tile_2002_scene.jpg',   'https://picsum.photos/seed/greytile01/800/800.jpg'),
    # 产品 2003 - 真皮沙发
    ('sofa_2003_scene1.jpg',  'https://picsum.photos/seed/leathersof/800/800.jpg'),
    ('sofa_2003_scene2.jpg',  'https://picsum.photos/seed/leathersof2/800/800.jpg'),
    # 产品 2004 - 懒人沙发
    ('sofa_2004_scene.jpg',   'https://picsum.photos/seed/sofabeanb1/800/800.jpg'),
]

for name, url in images:
    path = os.path.join(dest_dir, name)
    print(f"Downloading {name} ...")
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req, timeout=15) as r, open(path, 'wb') as f:
        f.write(r.read())
    time.sleep(0.5)

print("All done!")
