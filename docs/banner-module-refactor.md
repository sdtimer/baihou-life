# Banner 管理模块改造方案

> 文档版本：v1.0
> 创建日期：2026-03-15
> 涉及模块：B6 Banner 管理、B3 区域管理

---

## 一、改造背景与目标

当前 Banner 管理中，投放区域字段 `regions` 以纯 JSON 字符串形式手动录入（如 `["foshan"]`），存在以下问题：

| 问题 | 说明 |
|------|------|
| 无约束 | 可以输入任意字符串，region_id 拼错不会报错 |
| 体验差 | 运营人员需要记住区域 ID 的英文写法 |
| 无合法性校验 | 不校验区域是否存在、是否启用 |
| 表格展示原始 | 表格列直接显示 JSON 字符串，不可读 |

**改造目标：**
- 投放区域改为下拉选择器，数据来源为区域管理中的启用区域
- 支持**全选**（投放所有区域）、**多选**（投放指定区域）、**单选**（投放单一区域）
- 支持全选与取消全选的快捷操作
- 表格列区域展示翻译为可读的区域名称

---

## 二、交互设计

### 2.1 选择器形态

使用 Element Plus 的 `el-select` 多选模式，在选择器顶部插入两个操作项：**全部区域**（特殊值）和**快捷操作栏**。

```
┌─────────────────────────────────────────────────┐
│  请选择投放区域                             [▼] │
└─────────────────────────────────────────────────┘

展开后：
┌─────────────────────────────────────────────────┐
│  [搜索区域...]                                  │
│  ─────────────────────────────                  │
│  ☑ 全部区域（ALL）                             │  ← 特殊选项
│  ─────────────────────────────                  │
│  ☐ 成都                                        │
│  ☐ 佛山                                        │
│  ☐ 武汉                                        │
│  ─────────────────────────────                  │
│  [全选]  [清空]                                 │  ← 快捷操作
└─────────────────────────────────────────────────┘
```

### 2.2 三种选择模式的逻辑

| 模式 | 操作方式 | 存储结果 |
|------|---------|---------|
| **全选** | 点击"全部区域"或点击"全选"按钮 | `["ALL"]` |
| **多选** | 勾选多个具体区域 | `["foshan","chengdu"]` |
| **单选** | 只勾选一个具体区域 | `["foshan"]` |

### 2.3 互斥逻辑

`ALL` 与具体区域互斥，确保语义清晰：

| 操作 | 结果 |
|------|------|
| 选中"全部区域" | 自动清除已选的具体区域，只保留 `ALL` |
| 选中任一具体区域（当前已选 ALL） | 自动取消 `ALL`，保留该具体区域 |
| 点击"全选"按钮 | 清空现有选择，改为 `["ALL"]` |
| 点击"清空"按钮 | 清空所有选择 |
| 手动勾选全部具体区域 | **不**自动转为 `ALL`，保留具体列表（可查看哪些区域被选中） |

### 2.4 表格列改造

| 当前 | 改造后 |
|------|--------|
| 直接显示 JSON 字符串 `["foshan"]` | 翻译为 Tag 展示：`佛山` |
| `["ALL"]` 显示为字符串 | 翻译为 `全部区域`（高亮 Tag） |
| `["foshan","chengdu"]` 难以阅读 | 展示为 `成都 佛山` 两个 Tag |

---

## 三、存储格式设计

### 3.1 格式不变，语义明确

`bh_banner.regions` 字段继续存 JSON 数组字符串，无需修改表结构：

```json
// 全部区域
["ALL"]

// 指定多个区域
["foshan", "chengdu"]

// 指定单个区域
["foshan"]
```

### 3.2 为什么用 `["ALL"]` 而不是存所有区域 ID

| 方案 | 说明 | 问题 |
|------|------|------|
| 存 `["ALL"]` | 语义明确，数据简洁 | 无，推荐 |
| 存所有区域 ID | 如 `["foshan","chengdu","wuhan"]` | 新增区域后，已有"全部投放"的 banner 不会自动更新，需手动修改 |

选用 `["ALL"]` 方案，新区域上线后，`["ALL"]` 的 banner 自动覆盖新区域，无需维护。

---

## 四、后端改动

### 4.1 复用区域 options 接口

Banner 模块直接复用商品模块改造中新增的区域选项接口（参见 `product-module-refactor.md` 第2节）：

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

若该接口已在商品模块改造中实现，Banner 无需额外开发后端接口。若商品模块改造尚未完成，Banner 改造时一并实现该接口。

### 4.2 BaihouBannerController — 无接口变化

区域字段的存储格式不变（仍为 JSON 字符串），后端接口无需改动：

```java
// 现有接口保持不变
POST /admin/banners       → 创建 Banner，regions 字段接受 JSON 字符串
PUT  /admin/banners/{id}  → 更新 Banner，regions 字段接受 JSON 字符串
```

### 4.3 BaihouBannerServiceImpl — 可选：增加区域合法性校验

可选增加校验逻辑（非强制，取决于对数据质量的要求）：

```java
@Override
public int insertBanner(BaihouBanner banner) {
    if (banner.getIsActive() == null) {
        banner.setIsActive(1);
    }
    // 可选：校验 regions 中的非 ALL 值是否在 bh_region 中存在
    validateRegions(banner.getRegions());
    return bannerMapper.insertBanner(banner);
}

private void validateRegions(String regionsJson) {
    if (regionsJson == null || regionsJson.isBlank()) return;
    // 解析 JSON，若包含 "ALL" 则跳过，否则校验每个 region_id 是否存在且 is_active=1
    // 不合法时抛出 ServiceException("区域 [xxx] 不存在或已停用")
}
```

> 初期可不实现此校验，前端下拉已限制选项范围，非法值基本不会出现。

---

## 五、前端改动

### 5.1 新增 API 函数（`api/baihou/banners.js`）

```javascript
import { getRegionOptions } from '@/api/baihou/regions'

// 复用 regions 模块的 options 接口，无需在 banners.js 中重复定义
export { getRegionOptions }
```

或在 `api/baihou/regions.js` 中确认存在：

```javascript
// api/baihou/regions.js
export function getRegionOptions() {
  return request({ url: '/admin/regions/options', method: 'get' })
}
```

### 5.2 `banners/index.vue` 完整改动

#### 5.2.1 新增响应式变量

```javascript
// 区域选项列表（从后端加载）
const regionOptions = ref([])

// 表单中区域的临时数组（用于 el-select v-model）
const regionsArr = ref([])

// 加载区域选项
async function loadRegionOptions() {
  const res = await getRegionOptions()
  regionOptions.value = res.data || []
}

onMounted(() => {
  getList()
  loadRegionOptions()
})
```

#### 5.2.2 表单字段替换

```vue
<!-- 改造前 -->
<el-form-item label="投放区域">
  <el-input v-model="form.regions" placeholder='如 ["foshan","chengdu"]' />
</el-form-item>

<!-- 改造后 -->
<el-form-item label="投放区域">
  <el-select
    v-model="regionsArr"
    multiple
    filterable
    collapse-tags
    collapse-tags-tooltip
    placeholder="请选择投放区域（不选则全部区域）"
    style="width: 100%"
    @change="handleRegionChange"
  >
    <!-- 全部区域选项（特殊） -->
    <el-option value="ALL" label="全部区域">
      <span style="font-weight: bold; color: #409EFF">全部区域</span>
    </el-option>

    <el-divider style="margin: 4px 0" />

    <!-- 具体区域选项 -->
    <el-option
      v-for="r in regionOptions"
      :key="r.value"
      :label="r.label"
      :value="r.value"
    />

    <!-- 底部快捷操作 -->
    <template #footer>
      <div style="padding: 6px 12px; border-top: 1px solid #eee; display: flex; gap: 8px">
        <el-button size="small" @click="selectAllRegions">全选</el-button>
        <el-button size="small" @click="clearRegions">清空</el-button>
      </div>
    </template>
  </el-select>
</el-form-item>
```

#### 5.2.3 互斥处理函数

```javascript
// 选中变化时的互斥处理
function handleRegionChange(val) {
  if (!val || val.length === 0) return

  const hasAll = val.includes('ALL')
  const prevHasAll = regionsArr.value.slice(0, -1).includes('ALL')

  if (hasAll && val.length > 1) {
    if (prevHasAll) {
      // 之前有 ALL，现在又选了具体区域 → 去掉 ALL，保留具体区域
      regionsArr.value = val.filter(v => v !== 'ALL')
    } else {
      // 之前没有 ALL，现在选了 ALL → 清除具体区域，只保留 ALL
      regionsArr.value = ['ALL']
    }
  }
}

// 全选按钮：改为投放所有区域（存 ALL）
function selectAllRegions() {
  regionsArr.value = ['ALL']
}

// 清空按钮
function clearRegions() {
  regionsArr.value = []
}
```

#### 5.2.4 表单打开时回填 & 提交时序列化

```javascript
// 打开编辑弹窗时，将 JSON 字符串解析到 regionsArr
function handleEdit(row) {
  form.value = { ...row }
  try {
    regionsArr.value = JSON.parse(row.regions || '[]')
  } catch {
    regionsArr.value = []
  }
  dialogVisible.value = true
}

// 打开新增弹窗时，重置 regionsArr
function handleAdd() {
  resetForm()
  regionsArr.value = []
  dialogVisible.value = true
}

// 提交表单时，将 regionsArr 序列化为 JSON 字符串
function submitForm() {
  formRef.value.validate(async (valid) => {
    if (!valid) return
    form.value.regions = JSON.stringify(regionsArr.value)
    // ... 调用 addBanner / updateBanner
  })
}
```

#### 5.2.5 表格列改造

```vue
<!-- 改造前 -->
<el-table-column label="区域" prop="regions" width="160" show-overflow-tooltip />

<!-- 改造后 -->
<el-table-column label="投放区域" width="200">
  <template #default="{ row }">
    <RegionTags :regions="row.regions" :region-options="regionOptions" />
  </template>
</el-table-column>
```

```vue
<!-- RegionTags 内联组件（也可拆为独立文件）-->
<!-- 解析 regions JSON，渲染为 el-tag 列表 -->
<script setup>
const props = defineProps({
  regions: String,
  regionOptions: Array
})

const tags = computed(() => {
  try {
    const arr = JSON.parse(props.regions || '[]')
    if (arr.includes('ALL')) return [{ label: '全部区域', type: 'primary' }]
    return arr.map(id => {
      const found = props.regionOptions.find(r => r.value === id)
      return { label: found ? found.label : id, type: 'info' }
    })
  } catch {
    return []
  }
})
</script>

<template>
  <span v-if="tags.length === 0" style="color: #ccc">—</span>
  <el-tag
    v-for="tag in tags"
    :key="tag.label"
    :type="tag.type"
    size="small"
    style="margin: 2px"
  >
    {{ tag.label }}
  </el-tag>
</template>
```

---

## 六、改动文件清单

### 数据库

| 操作 | 对象 | 说明 |
|------|------|------|
| 无变化 | `bh_banner` | `regions` 字段存储格式不变 |
| 依赖 | `bh_region` | 读取启用中的区域数据 |

### 后端

| 文件 | 变化类型 | 说明 |
|------|---------|------|
| `BaihouRegionController.java` | 追加方法 | 新增 `GET /admin/regions/options`（与商品模块共用，若已实现则忽略） |
| `BaihouBannerServiceImpl.java` | 可选修改 | 可选增加区域合法性校验 |
| 其余 banner 相关文件 | 无变化 | — |

### 前端

| 文件 | 变化类型 | 说明 |
|------|---------|------|
| `views/baihou/banners/index.vue` | 修改 | 区域多选下拉、互斥逻辑、表格 Tag 展示 |
| `api/baihou/regions.js` | 追加 | 确认存在 `getRegionOptions()` 函数（与商品模块共用） |

---

## 七、边界情况处理

| 情况 | 处理方式 |
|------|---------|
| `regions` 为 `null` 或空字符串 | 视为未设置，解析为空数组，表格列显示 `—` |
| `regions` 包含已停用区域的 ID | 下拉中不展示该区域（仅显示启用中的区域），但已有数据中的停用区域 ID 仍保留在存储中，表格展示原始 ID（找不到翻译则原样显示） |
| 区域选项接口加载失败 | 降级展示空列表，表单仍可提交（regions 字段允许为空） |
| 全部区域选项 `["ALL"]` | 表格显示蓝色 Tag "全部区域"；编辑时回填选中"全部区域"选项 |

---

## 八、实施顺序

```
Step 1  确认 GET /admin/regions/options 接口已实现（商品模块改造若同期进行则合并）
Step 2  前端：banners/index.vue 改造区域字段为多选下拉
Step 3  前端：改造表格区域列为 Tag 展示
Step 4  测试：新增/编辑 Banner，验证全选、多选、单选场景
Step 5  测试：区域 options 接口只返回 is_active=1 的区域
Step 6  测试：存量 banner 数据（含 ALL 和具体区域）的展示与回填是否正确
```
