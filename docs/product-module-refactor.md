# 商品管理模块改造方案

> 文档版本：v1.0
> 创建日期：2026-03-15
> 涉及模块：B1 商品管理、B2 品类管理、B3 区域管理

---

## 一、改造背景与目标

当前商品管理中，以下三类字段以纯 JSON 字符串形式录入，交互体验差且无约束：

| 字段 | 现状 | 问题 |
|------|------|------|
| `regions`（可售区域） | JSON 字符串手动填写 | 无下拉约束，容易输错 region_id |
| `space_tags`（空间标签） | JSON 字符串手动填写 | 选项不统一，无法标准化 |
| `scene_tags`（场景标签） | JSON 字符串手动填写 | 选项不统一，无法标准化 |
| `spec_params`（规格参数） | 统一 JSON 对象 | 不同品类规格项完全不同，无结构约束 |

**改造目标：**

1. 区域字段 → 对接区域管理 API，多选下拉展示启用中的区域
2. 空间标签、场景标签 → 使用若依数据字典统一管理选项，多选下拉展示
3. 规格参数 → 引入品类规格模板（子表），实现按品类动态渲染规格表单

---

## 二、改造一：区域字段 → 多选下拉

### 2.1 交互变化

**改造前：** 手动填写 JSON 字符串，如 `["foshan","chengdu"]`

**改造后：** 从区域管理加载启用中的区域，展示为多选下拉（`el-select multiple`）

### 2.2 数据来源

复用已有的区域管理接口，新增一个公共选项接口供商品表单调用：

```
GET /admin/regions/options
```

**响应格式：**
```json
[
  { "value": "chengdu", "label": "成都" },
  { "value": "foshan",  "label": "佛山" },
  { "value": "wuhan",   "label": "武汉" }
]
```

**过滤条件：** `is_active = 1`，按 `sort_order` 升序排列。

### 2.3 存储格式不变

后端存储仍为 JSON 数组字符串 `["foshan","chengdu"]`，无需修改表结构。前端多选组件的值序列化为 JSON 再提交即可。

### 2.4 后端改动

**新增方法（`BaihouRegionController`）：**

```java
@GetMapping("/options")
@PreAuthorize("@ss.hasPermi('baihou:product:list')")
public AjaxResult options() {
    return AjaxResult.success(regionService.listActiveOptions());
}
```

**新增 Service 方法（`BaihouRegionServiceImpl`）：**

```java
public List<Map<String, String>> listActiveOptions() {
    // SELECT region_id, region_name FROM bh_region
    // WHERE is_active = 1 ORDER BY sort_order
}
```

### 2.5 前端改动（`products/index.vue`）

```vue
<!-- 改造前 -->
<el-input v-model="form.regions" placeholder='["foshan","chengdu"]' />

<!-- 改造后 -->
<el-select
  v-model="form.regionsArr"
  multiple
  placeholder="请选择可售区域"
  style="width: 100%"
>
  <el-option
    v-for="r in regionOptions"
    :key="r.value"
    :label="r.label"
    :value="r.value"
  />
</el-select>
```

表单提交时序列化：
```javascript
form.regions = JSON.stringify(form.regionsArr)
```

---

## 三、改造二：空间标签 / 场景标签 → 数据字典多选下拉

### 3.1 交互变化

**改造前：** 手动填写 JSON 字符串，如 `["客厅","餐厅"]`

**改造后：** 从若依数据字典读取选项，展示为多选下拉（`el-select multiple`）

### 3.2 数据字典设计

在若依系统管理 → 字典管理中，新建以下两个字典类型：

#### 字典类型 1：空间标签

| 字段 | 值 |
|------|----|
| 字典类型 | `baihou_space_tag` |
| 字典名称 | 商品空间标签 |
| 备注 | 商品适用的空间场景标签 |

**字典数据（初始值）：**

| 字典标签 | 字典键值 | 排序 |
|----------|----------|------|
| 客厅 | living_room | 1 |
| 餐厅 | dining_room | 2 |
| 卧室 | bedroom | 3 |
| 书房 | study | 4 |
| 厨房 | kitchen | 5 |
| 卫生间 | bathroom | 6 |
| 阳台 | balcony | 7 |
| 玄关 | entrance | 8 |
| 全屋 | whole_house | 9 |

#### 字典类型 2：场景标签

| 字段 | 值 |
|------|----|
| 字典类型 | `baihou_scene_tag` |
| 字典名称 | 商品场景风格标签 |
| 备注 | 商品适配的装修风格与场景标签 |

**字典数据（初始值）：**

| 字典标签 | 字典键值 | 排序 |
|----------|----------|------|
| 现代简约 | modern | 1 |
| 北欧 | nordic | 2 |
| 奶油风 | creamy | 3 |
| 侘寂 | wabi_sabi | 4 |
| 轻奢 | light_luxury | 5 |
| 新中式 | new_chinese | 6 |
| 美式 | american | 7 |
| 法式 | french | 8 |
| 工业风 | industrial | 9 |

> **注：** 字典键值（dictValue）使用英文 slug，以便在 JSON 存储时简洁，同时前端根据字典数据翻译展示。运营人员可在数据字典管理页面随时增删选项，无需修改代码。

### 3.3 存储格式不变

后端存储仍为 JSON 数组字符串（存字典键值），如 `["living_room","bedroom"]`。

### 3.4 前端改动（`products/index.vue`）

若依 Vue3 前端提供 `useDictStore` 获取字典数据：

```javascript
import { useDictStore } from '@/store/modules/dict'

// 在 setup() 中
const dictStore = useDictStore()
const spaceTagOptions = ref([])
const sceneTagOptions = ref([])

onMounted(async () => {
  spaceTagOptions.value = await dictStore.loadDictData('baihou_space_tag')
  sceneTagOptions.value = await dictStore.loadDictData('baihou_scene_tag')
})
```

```vue
<!-- 空间标签 -->
<el-select v-model="form.spaceTagsArr" multiple placeholder="请选择空间标签">
  <el-option
    v-for="d in spaceTagOptions"
    :key="d.dictValue"
    :label="d.dictLabel"
    :value="d.dictValue"
  />
</el-select>

<!-- 场景标签 -->
<el-select v-model="form.sceneTagsArr" multiple placeholder="请选择场景标签">
  <el-option
    v-for="d in sceneTagOptions"
    :key="d.dictValue"
    :label="d.dictLabel"
    :value="d.dictValue"
  />
</el-select>
```

### 3.5 SQL 初始化脚本

```sql
-- 空间标签字典类型
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark)
VALUES ('商品空间标签', 'baihou_space_tag', '0', 'admin', NOW(), '商品适用的空间场景标签');

-- 场景风格字典类型
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark)
VALUES ('商品场景风格标签', 'baihou_scene_tag', '0', 'admin', NOW(), '商品适配的装修风格与场景标签');

-- 空间标签字典数据
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, status, create_by, create_time)
VALUES
(1,  '客厅',   'living_room',  'baihou_space_tag', '0', 'admin', NOW()),
(2,  '餐厅',   'dining_room',  'baihou_space_tag', '0', 'admin', NOW()),
(3,  '卧室',   'bedroom',      'baihou_space_tag', '0', 'admin', NOW()),
(4,  '书房',   'study',        'baihou_space_tag', '0', 'admin', NOW()),
(5,  '厨房',   'kitchen',      'baihou_space_tag', '0', 'admin', NOW()),
(6,  '卫生间', 'bathroom',     'baihou_space_tag', '0', 'admin', NOW()),
(7,  '阳台',   'balcony',      'baihou_space_tag', '0', 'admin', NOW()),
(8,  '玄关',   'entrance',     'baihou_space_tag', '0', 'admin', NOW()),
(9,  '全屋',   'whole_house',  'baihou_space_tag', '0', 'admin', NOW());

-- 场景标签字典数据
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, status, create_by, create_time)
VALUES
(1,  '现代简约', 'modern',       'baihou_scene_tag', '0', 'admin', NOW()),
(2,  '北欧',     'nordic',       'baihou_scene_tag', '0', 'admin', NOW()),
(3,  '奶油风',   'creamy',       'baihou_scene_tag', '0', 'admin', NOW()),
(4,  '侘寂',     'wabi_sabi',    'baihou_scene_tag', '0', 'admin', NOW()),
(5,  '轻奢',     'light_luxury', 'baihou_scene_tag', '0', 'admin', NOW()),
(6,  '新中式',   'new_chinese',  'baihou_scene_tag', '0', 'admin', NOW()),
(7,  '美式',     'american',     'baihou_scene_tag', '0', 'admin', NOW()),
(8,  '法式',     'french',       'baihou_scene_tag', '0', 'admin', NOW()),
(9,  '工业风',   'industrial',   'baihou_scene_tag', '0', 'admin', NOW());
```

---

## 四、改造三：规格参数 → 品类规格模板 + 动态表单

### 4.1 方案选型

#### 备选方案对比

| 方案 | 描述 | 优点 | 缺点 | 结论 |
|------|------|------|------|------|
| **A. 品类模板子表 + 商品规格值子表** | 两张新表，规格项和值都结构化存储 | 完全关系化，可按规格筛商品 | 表多，查询复杂，管理成本高 | 过重，当前阶段不推荐 |
| **B. 品类模板子表 + 商品 JSON 值（推荐）** | 一张新表定义规格模板，商品值仍 JSON 存储 | 模板结构化可管理，商品值灵活，开发量适中 | 不能直接按规格值做 SQL 筛选 | **推荐** |
| **C. 品类表增加 JSON 模板字段** | 在 `bh_category` 加 `spec_template` 字段 | 无新表，最简单 | 模板管理无专属 UI，字段定义藏在 JSON 里 | 简单但可维护性差 |

**选定方案 B：品类规格模板子表 + 商品规格 JSON 值**

### 4.2 新增数据库表

#### `bh_category_spec_def` — 品类规格定义模板

```sql
CREATE TABLE bh_category_spec_def (
    spec_def_id  BIGINT       NOT NULL AUTO_INCREMENT COMMENT '规格定义ID',
    category_id  BIGINT       NOT NULL                COMMENT '关联品类ID（叶子品类）',
    spec_key     VARCHAR(64)  NOT NULL                COMMENT '规格键名（英文，用于 JSON 存储）',
    spec_label   VARCHAR(64)  NOT NULL                COMMENT '规格展示名称（中文）',
    input_type   VARCHAR(16)  NOT NULL DEFAULT 'text' COMMENT '输入类型：text / number / select',
    options      JSON                                  COMMENT '当 input_type=select 时的选项列表，如 ["哑光","亮光"]',
    unit         VARCHAR(16)                           COMMENT '单位，如 mm、㎡（可选）',
    is_required  TINYINT(1)   NOT NULL DEFAULT 0      COMMENT '是否必填（0=否，1=是）',
    sort_order   INT          NOT NULL DEFAULT 0      COMMENT '同品类内排序',
    create_by    VARCHAR(64)           DEFAULT ''      COMMENT '创建者',
    create_time  DATETIME                              COMMENT '创建时间',
    update_by    VARCHAR(64)           DEFAULT ''      COMMENT '更新者',
    update_time  DATETIME                              COMMENT '更新时间',
    PRIMARY KEY (spec_def_id),
    INDEX idx_category_id (category_id),
    CONSTRAINT fk_spec_def_category FOREIGN KEY (category_id) REFERENCES bh_category (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品类规格定义模板';
```

**字段说明：**

| 字段 | 说明 |
|------|------|
| `spec_key` | 英文键名，如 `material`、`size`、`surface`，对应 `bh_product.spec_params` 中的 JSON key |
| `spec_label` | 展示名，如 `材质`、`尺寸（mm）`、`表面处理` |
| `input_type` | 决定前端渲染什么控件：`text`=文本框，`number`=数字框，`select`=下拉选择 |
| `options` | 仅 `input_type=select` 时有效，存字符串数组，如 `["哑光","亮光","磨砂"]` |
| `unit` | 展示在输入框右侧，如 `mm`、`㎡` |
| `is_required` | 前端表单校验是否必填 |

#### `bh_product.spec_params` 存储格式（不变，但结构化）

商品的 `spec_params` 字段继续存 JSON 对象，但 key 必须与品类规格模板的 `spec_key` 对应：

```json
{
  "material": "胡桃木实木",
  "size": "1800×900",
  "surface": "哑光",
  "thickness": 18
}
```

### 4.3 规格模板示例数据

```sql
-- 示例：瓷砖品类（category_id = 对应瓷砖的ID）
INSERT INTO bh_category_spec_def (category_id, spec_key, spec_label, input_type, unit, is_required, sort_order)
VALUES
(@tile_cat_id, 'size',        '规格尺寸',   'text',   'mm',  1, 1),
(@tile_cat_id, 'thickness',   '厚度',       'number', 'mm',  0, 2),
(@tile_cat_id, 'surface',     '表面处理',   'select', NULL,  0, 3),
(@tile_cat_id, 'material',    '材质工艺',   'text',   NULL,  0, 4);

UPDATE bh_category_spec_def SET options = '["哑光","亮光","磨砂","微水泥"]'
WHERE category_id = @tile_cat_id AND spec_key = 'surface';

-- 示例：木地板品类
INSERT INTO bh_category_spec_def (category_id, spec_key, spec_label, input_type, unit, is_required, sort_order)
VALUES
(@floor_cat_id, 'material',    '基材',       'select', NULL,  1, 1),
(@floor_cat_id, 'size',        '规格',       'text',   'mm',  1, 2),
(@floor_cat_id, 'thickness',   '厚度',       'number', 'mm',  1, 3),
(@floor_cat_id, 'surface',     '表面工艺',   'select', NULL,  0, 4),
(@floor_cat_id, 'wear_grade',  '耐磨等级',   'text',   NULL,  0, 5);

UPDATE bh_category_spec_def SET options = '["纯实木","实木多层","强化复合","SPC石塑"]'
WHERE category_id = @floor_cat_id AND spec_key = 'material';

UPDATE bh_category_spec_def SET options = '["拉丝","浮雕","镜面","原木"]'
WHERE category_id = @floor_cat_id AND spec_key = 'surface';
```

### 4.4 后端改动

#### 新增实体类 `BaihouCategorySpecDef.java`

```java
package com.ruoyi.baihou.domain;

public class BaihouCategorySpecDef extends BaseEntity {
    private Long specDefId;
    private Long categoryId;
    private String specKey;
    private String specLabel;
    private String inputType;   // text / number / select
    private String options;     // JSON 字符串，仅 select 类型有值
    private String unit;
    private Integer isRequired;
    private Integer sortOrder;
}
```

#### 新增 API（`BaihouCategoryController` 中追加，或独立子路由）

```
GET /admin/categories/{categoryId}/spec-defs
    → 返回该品类的规格模板列表，按 sort_order 排序

POST   /admin/categories/{categoryId}/spec-defs          → 新增规格定义
PUT    /admin/categories/{categoryId}/spec-defs/{id}     → 编辑规格定义
DELETE /admin/categories/{categoryId}/spec-defs/{id}     → 删除规格定义
PUT    /admin/categories/{categoryId}/spec-defs/sort      → 批量更新排序
```

#### `BaihouProductServiceImpl` 改动

- `getProduct(id)` 时，根据商品的 `categoryId` 查询规格模板，将模板和当前 `spec_params` JSON 合并，返回给前端（前端用于渲染动态表单）
- `createProduct / updateProduct` 时，校验提交的 `spec_params` 中 `is_required=1` 的字段是否有值

### 4.5 前端改动（`products/index.vue`）

#### 动态规格表单渲染逻辑

```javascript
// 切换品类时，加载该品类的规格模板
watch(() => form.value.categoryId, async (newCategoryId) => {
  if (!newCategoryId) {
    specDefs.value = []
    return
  }
  const res = await getCategorySpecDefs(newCategoryId)
  specDefs.value = res.data
  // 初始化 specParamsObj，保留已填写的值
  const obj = {}
  specDefs.value.forEach(def => {
    obj[def.specKey] = specParamsObj.value[def.specKey] ?? ''
  })
  specParamsObj.value = obj
})
```

```vue
<!-- 动态规格参数表单 -->
<template v-if="specDefs.length > 0">
  <el-divider content-position="left">规格参数</el-divider>
  <template v-for="def in specDefs" :key="def.specKey">
    <el-form-item
      :label="def.specLabel + (def.unit ? `（${def.unit}）` : '')"
      :prop="`specParams.${def.specKey}`"
      :rules="def.isRequired ? [{ required: true, message: `请填写${def.specLabel}` }] : []"
    >
      <!-- 文本输入 -->
      <el-input
        v-if="def.inputType === 'text'"
        v-model="specParamsObj[def.specKey]"
        :placeholder="`请输入${def.specLabel}`"
      />
      <!-- 数字输入 -->
      <el-input-number
        v-else-if="def.inputType === 'number'"
        v-model="specParamsObj[def.specKey]"
        :placeholder="`请输入${def.specLabel}`"
        style="width: 200px"
      />
      <!-- 下拉选择 -->
      <el-select
        v-else-if="def.inputType === 'select'"
        v-model="specParamsObj[def.specKey]"
        :placeholder="`请选择${def.specLabel}`"
      >
        <el-option
          v-for="opt in JSON.parse(def.options || '[]')"
          :key="opt"
          :label="opt"
          :value="opt"
        />
      </el-select>
    </el-form-item>
  </template>
</template>
```

提交时序列化：
```javascript
form.specParams = JSON.stringify(specParamsObj.value)
```

### 4.6 品类管理页面增加规格模板管理

在 `categories/index.vue` 的操作列增加「规格模板」按钮，点击后进入该品类的规格定义管理子页面（或对话框）：

```
表格操作列：[编辑] [规格模板] [启/停]
```

规格模板管理界面（内嵌对话框或跳转子页面）需支持：
- 查看该品类的规格定义列表
- 新增 / 编辑 / 删除规格定义
- 拖拽排序（可选，初期用 sort_order 数字排序即可）

---

## 五、改动文件清单

### 数据库

| 操作 | 对象 | 说明 |
|------|------|------|
| 新建表 | `bh_category_spec_def` | 品类规格定义模板 |
| 新增字典 | `baihou_space_tag` | 空间标签字典类型及数据 |
| 新增字典 | `baihou_scene_tag` | 场景风格标签字典类型及数据 |
| 无变化 | `bh_product` | `spec_params`、`space_tags`、`scene_tags`、`regions` 字段存储格式不变 |

### 后端

| 文件 | 变化类型 | 说明 |
|------|---------|------|
| `BaihouCategorySpecDef.java`（新建） | 新增 | 规格定义实体 |
| `BaihouCategorySpecDefMapper.java`（新建） | 新增 | MyBatis Mapper |
| `BaihouCategorySpecDefMapper.xml`（新建） | 新增 | SQL 映射 |
| `BaihouCategorySpecDefService.java`（新建） | 新增 | 服务接口 |
| `BaihouCategorySpecDefServiceImpl.java`（新建） | 新增 | 服务实现 |
| `BaihouCategoryController.java` | 追加方法 | 增加规格模板 CRUD 路由 |
| `BaihouRegionController.java` | 追加方法 | 增加 `/options` 接口 |
| `BaihouProductServiceImpl.java` | 修改 | 查询时附加规格模板；保存时校验必填规格 |

### 前端

| 文件 | 变化类型 | 说明 |
|------|---------|------|
| `views/baihou/products/index.vue` | 修改 | 区域多选下拉、标签多选下拉、规格动态表单 |
| `views/baihou/categories/index.vue` | 修改 | 操作列增加「规格模板」入口 |
| `views/baihou/categories/SpecDefDialog.vue`（新建） | 新增 | 规格模板管理对话框 |
| `api/baihou/product.js` | 修改 | 无接口变化，序列化逻辑调整 |
| `api/baihou/category.js` | 追加 | 增加规格模板 CRUD 及获取选项的 API 函数 |
| `api/baihou/region.js` | 追加 | 增加 `getRegionOptions()` 函数 |

---

## 六、实施建议

### 6.1 执行顺序

```
Step 1  执行字典 SQL → 在若依系统管理验证字典数据是否正确
Step 2  执行 bh_category_spec_def 建表 SQL
Step 3  后端开发：区域 options 接口 + 规格模板 CRUD 接口
Step 4  后端开发：ProductService 查询附加模板 + 保存校验
Step 5  前端：区域和标签改为多选下拉（不涉及结构变化，风险低）
Step 6  前端：商品表单规格动态渲染
Step 7  前端：品类管理增加规格模板管理对话框
Step 8  录入初始规格模板数据（各品类）
Step 9  测试：全流程 - 新建商品 → 选品类 → 填规格 → 上架
```

### 6.2 兼容性说明

- 存量商品的 `spec_params`、`space_tags`、`scene_tags`、`regions` 字段值无需迁移，JSON 格式不变
- 前端展示时，对于无规格模板的品类（尚未配置），规格区域可折叠隐藏或显示提示「该品类暂未配置规格模板」
- 标签字段：若存量值（如中文 `"客厅"`）与新字典键值（`"living_room"`）不一致，需在初始化字典时统一用中文 label 作为 dictValue，或执行数据迁移脚本

### 6.3 数据迁移建议（空间/场景标签）

若决定字典键值用英文 slug，需同步迁移存量 `space_tags` / `scene_tags`：

```sql
-- 示例：将 "客厅" 替换为 "living_room"
UPDATE bh_product
SET space_tags = REPLACE(space_tags, '"客厅"', '"living_room"')
WHERE space_tags LIKE '%"客厅"%';
-- 其他标签类似处理
```

> **最简替代方案：** 字典键值直接用中文（dictValue = `"客厅"`），则无需数据迁移，代价是 JSON 中文字符略冗余。建议初期直接用中文 dictValue，等系统稳定后再统一规范。

---

## 七、权限设计

规格模板管理复用品类管理的权限：

| 操作 | 权限标识 |
|------|---------|
| 查看规格模板 | `baihou:category:list` |
| 新增规格定义 | `baihou:category:add` |
| 编辑规格定义 | `baihou:category:edit` |
| 删除规格定义 | `baihou:category:remove` |

无需新增权限标识，复用品类管理权限即可。
