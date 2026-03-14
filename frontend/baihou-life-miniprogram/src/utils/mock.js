const regions = [
  { region_id: "foshan", region_name: "佛山", province: "广东", is_active: true, sort_order: 1 },
  { region_id: "chengdu", region_name: "成都", province: "四川", is_active: true, sort_order: 2 },
  { region_id: "wuhan", region_name: "武汉", province: "湖北", is_active: true, sort_order: 3 }
];

const categories = [
  {
    category_id: 1,
    category_name: "主材馆",
    children: [
      { category_id: 11, category_name: "瓷砖" },
      { category_id: 12, category_name: "洁具" }
    ]
  },
  {
    category_id: 2,
    category_name: "定制馆",
    children: [
      { category_id: 21, category_name: "橱柜" },
      { category_id: 22, category_name: "衣柜" }
    ]
  }
];

const spaces = [
  { label: "客厅", value: "living_room" },
  { label: "厨卫", value: "kitchen_bath" },
  { label: "卧室", value: "bedroom" }
];

const scenes = [
  { label: "极简", value: "minimalist" },
  { label: "治愈", value: "healing" },
  { label: "侘寂", value: "wabi_sabi" }
];

const products = [
  {
    id: 10001,
    name: "TOTO 浴室柜 800mm",
    sku_code: "TOTO-YSG-800",
    brand: "TOTO",
    category_id: 12,
    category_name: "洁具",
    guide_price: 1280,
    designer_price: 1088,
    price_unit: "元/套",
    cover_image: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80",
    banner_image: "https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=1200&q=80",
    space_tags: ["kitchen_bath"],
    scene_tags: ["minimalist", "healing"],
    regions: ["ALL"],
    description: "暖木色与石材结合的浴室空间主角，适用于现代全案场景。",
    specs: [
      { label: "材质", value: "岩板台面 + 实木柜体" },
      { label: "尺寸", value: "800 x 520 x 860 mm" },
      { label: "交付周期", value: "15-20 天" }
    ],
    gallery: [
      "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=1200&q=80",
      "https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=1200&q=80"
    ],
    source_files: [
      { media_id: 1, name: "场景图原文件", access_level: "designer" }
    ]
  },
  {
    id: 10002,
    name: "岩板岛台组合",
    sku_code: "BH-YBDT-001",
    brand: "Baihou Select",
    category_id: 21,
    category_name: "橱柜",
    guide_price: 16800,
    designer_price: 14280,
    price_unit: "元/组",
    cover_image: "https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=800&q=80",
    banner_image: "https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=1200&q=80",
    space_tags: ["kitchen_bath"],
    scene_tags: ["minimalist", "wabi_sabi"],
    regions: ["foshan", "chengdu"],
    description: "兼顾储物与社交场景的一体式岛台方案，适合高颜值厨居空间。",
    specs: [
      { label: "台面", value: "进口岩板" },
      { label: "柜体", value: "多层实木板" },
      { label: "交付周期", value: "20-30 天" }
    ],
    gallery: [
      "https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=1200&q=80"
    ],
    source_files: [
      { media_id: 2, name: "橱柜节点图", access_level: "designer" }
    ]
  }
];

const appointments = [
  { appointment_id: 1, appointment_no: "APT202603100001", service_type: "measure", preferred_date: "2026-03-15", status: "pending", region_name: "佛山" },
  { appointment_id: 2, appointment_no: "APT202603100002", service_type: "install", preferred_date: "2026-03-18", status: "confirmed", region_name: "成都" }
];

const orders = [
  { order_id: 1, order_no: "ORD202603100001", product_name: "TOTO 浴室柜 800mm", pay_amount: 1280, status: "pending_pay", region_name: "佛山", created_at: "2026-03-10 10:00" },
  { order_id: 2, order_no: "ORD202603100002", product_name: "岩板岛台组合", pay_amount: 16800, status: "processing", region_name: "成都", created_at: "2026-03-10 12:00" }
];

function delay(data) {
  return new Promise((resolve) => {
    setTimeout(() => resolve(data), 180);
  });
}

module.exports = {
  regions,
  categories,
  spaces,
  scenes,
  products,
  appointments,
  orders,
  delay
};
