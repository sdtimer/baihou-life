import os
import urllib.request
import time

dest_dir = '/Users/timer/2026开发/生活产品展示/uploadPath/products'
os.makedirs(dest_dir, exist_ok=True)

images = [
    ('tile.jpg', 'https://picsum.photos/seed/tile/800/800.jpg'),
    ('wood.jpg', 'https://picsum.photos/seed/wood/800/800.jpg'),
    ('cabinet.jpg', 'https://picsum.photos/seed/cabinet/800/800.jpg'),
    ('wardrobe.jpg', 'https://picsum.photos/seed/wardrobe/800/800.jpg'),
    ('sofa.jpg', 'https://picsum.photos/seed/sofa/800/800.jpg'),
    ('curtain.jpg', 'https://picsum.photos/seed/curtain/800/800.jpg'),
]

for name, url in images:
    path = os.path.join(dest_dir, name)
    print(f"Downloading {name}...")
    headers = {'User-Agent': 'Mozilla/5.0'}
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req) as response, open(path, 'wb') as out_file:
        data = response.read()
        out_file.write(data)
    time.sleep(1)

print("Pre-download complete!")
