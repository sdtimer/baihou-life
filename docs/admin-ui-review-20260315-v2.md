# 管理后台 UI 代码评审报告 v2

**日期：** 2026-03-15（第二轮，基于最新代码状态）
**范围：** 9 个前端页面 + 后端 SpecDef 垂直切面
**与 v1 的主要差异：** 后端新增了规格排序接口；leads 手机号脱敏已由后端处理；重新核实了各页面的实际验证状态

---

## 一、变更核查（自 v1 评审后）

| v1 中提到的问题 | 实际现状 | 结论 |
|----------------|---------|------|
| leads 手机号明文 | 前端展示 `phone` 字段，后端返回即为脱敏值 | ✅ 已由后端处理，无需前端改动 |
| 规格排序无接口 | 后端新增 `PUT …/spec-defs/sort`，`updateSpecDefSort` 服务和 mapper 完整 | ✅ 后端已就绪，前端尚未接入 |
| appointments/orders 无表单验证 | 仍无 `:rules`，确认 | ❌ 仍存在 |
| banners 时间交叉验证 | 仍无 validator，确认 | ❌ 仍存在 |
| categories 嵌套 dialog | 结构未变 | ❌ 仍存在 |
| appointments/orders 缺 v-hasPermi | appointments 已有 `baihou:appointment:edit`，orders 已有 `baihou:order:edit` | ✅ 已有权限控制（v1 误判） |

---

## 二、问题清单（按优先级，基于当前代码）

### P0 — 影响数据完整性，建议尽快处理

#### 1. 订单管理：物流单号无强制校验
- **文件：** `orders/index.vue` 更新对话框
- **现状：** `trackingNo` 字段 placeholder 写着"发货时必填"，但 `:rules` 为空对象，实际可空值提交
- **建议：** 当 status 切换为 `shipped` 时，动态要求 `trackingNo` 必填（条件验证）

```javascript
// 建议的验证规则写法
const orderUpdateRules = computed(() => ({
  status: [{ required: true, message: "请选择状态", trigger: "change" }],
  trackingNo: updateForm.status === "shipped"
    ? [{ required: true, message: "发货状态下物流单号必填", trigger: "blur" }]
    : []
}))
```

#### 2. 预约管理：状态字段无验证
- **文件：** `appointments/index.vue` 更新对话框
- **现状：** 状态字段有 `el-select` 但无 required 验证，可提交空状态
- **建议：** 补加 `status: [{ required: true, message: "请选择状态", trigger: "change" }]`

---

### P1 — 影响运营体验，建议本周处理

#### 3. 规格模板排序：后端接口已就绪，前端未接入
- **后端：** `PUT /admin/categories/{categoryId}/spec-defs/sort` 完整实现（controller → service → mapper → SQL）
- **前端：** `categories/index.vue` 规格列表中仅支持单条编辑 sortOrder 字段，无批量排序 UI
- **建议：** 在规格列表对话框中加入排序功能，两个可选方案：

| 方案 | 实现方式 | 复杂度 |
|------|---------|-------|
| A. 拖拽排序 | 使用 `sortablejs` 或 `el-table` + drag event | 高 |
| B. 上移/下移按钮 | 操作列加"↑ ↓"按钮，调整 sortOrder 后批量提交 | 低（推荐） |

**方案 B 核心逻辑示意：**
```javascript
// 点击"上移"：将当前行与上一行 sortOrder 交换，然后调用排序接口
function handleMoveUp(index) {
  if (index === 0) return
  const list = [...specDefList.value]
  ;[list[index - 1].sortOrder, list[index].sortOrder] = [list[index].sortOrder, list[index - 1].sortOrder]
  specDefList.value = list
}

// 提交排序
function submitSort() {
  updateSpecDefSort(specDefCategoryId.value, specDefList.value.map(({ specDefId, sortOrder }) => ({ specDefId, sortOrder })))
    .then(() => proxy.$modal.msgSuccess("排序已保存"))
}
```
需要在 `api/baihou/categories.js` 追加：
```javascript
export function updateSpecDefSort(categoryId, data) {
  return request({ url: `/admin/categories/${categoryId}/spec-defs/sort`, method: "put", data })
}
```

#### 4. Banner 管理：开始/结束时间无交叉验证
- **文件：** `banners/index.vue`
- **建议：** 在 `rules.endTime` 加自定义 validator

```javascript
endTime: [{
  validator: (rule, value, callback) => {
    if (value && form.startTime && value <= form.startTime) {
      callback(new Error("结束时间必须晚于开始时间"))
    } else {
      callback()
    }
  },
  trigger: "change"
}]
```

#### 5. 商品管理：批量归档无二次确认
- **文件：** `products/index.vue`，`handleBatchAction('archive')` 调用处
- **建议：** 归档前插入 `ElMessageBox.confirm`

```javascript
async function handleBatchAction(action) {
  if (action === "archive") {
    await ElMessageBox.confirm(
      `确认归档选中的 ${selectionIds.value.length} 件商品？归档后不可撤销。`,
      "批量归档确认",
      { type: "warning" }
    )
  }
  batchProductAction({ ids: selectionIds.value, action }).then(...)
}
```

#### 6. 设计师管理：手机号字段体验问题
- **文件：** `designers/index.vue`
- **现状：** 表单 label 写"手机号哈希"，并设为必填，要求运营人员手动输入哈希字符串
- **建议：** 改为输入明文手机号，`phoneHash` 由后端计算；或者至少在 label 旁加说明文案，避免运营困惑

---

### P2 — 代码优化，下次迭代处理

#### 7. Categories 嵌套 Dialog
- **现状：** 规格编辑表单 Dialog 嵌套在规格列表 Dialog 内部
- **已知问题：** Element Plus 嵌套 Dialog 在某些版本下 ESC 键会同时关闭两层、遮罩 z-index 偶发错乱
- **建议：** 将内层 Dialog 移到外层 Dialog 之外（平级），用 `append-to-body` 分别挂载

```html
<!-- 当前（嵌套）-->
<el-dialog v-model="specDefOpen">
  ...
  <el-dialog v-model="specDefFormOpen">  <!-- 嵌套 -->
  </el-dialog>
</el-dialog>

<!-- 建议（平级）-->
<el-dialog v-model="specDefOpen" append-to-body>...</el-dialog>
<el-dialog v-model="specDefFormOpen" append-to-body>...</el-dialog>  <!-- 平级 -->
```

#### 8. 商品管理：规格参数切换品类后数据丢失
- **文件：** `products/index.vue`，`loadSpecDefs()` 函数
- **场景：** 编辑商品 → 修改品类 → 改回原品类 → 原规格参数已清空
- **建议：** 用 Map 按 `categoryId` 缓存 `specParamsObj` 快照

```javascript
const specParamCache = new Map()

watch(() => form.categoryId, (newVal, oldVal) => {
  if (oldVal) specParamCache.set(oldVal, { ...specParamsObj.value })
  specParamsObj.value = specParamCache.get(newVal) ?? {}
  loadSpecDefs(newVal)
})
```

#### 9. leads 日期范围同步
- **文件：** `leads/index.vue`
- **现状：** `dateRange` 需手动调用 `syncDateRange()` 同步到 `queryParams`，调用时机分散，容易遗漏
- **建议：** 改为 watch 自动同步

```javascript
watch(dateRange, (val) => {
  queryParams.startDate = val?.[0] || ""
  queryParams.endDate = val?.[1] || ""
})
```

---

## 三、各页面当前状态表

| 页面 | 表单验证 | 权限控制 | 危险操作确认 | 主要待办 |
|------|---------|---------|-----------|---------|
| 商品管理 | ✅ | ✅ | ⚠️ 批量归档缺 | P1-5 |
| Banner 管理 | ⚠️ 缺时间校验 | ✅ | ✅ | P1-4 |
| 品类管理 | ✅ | ✅ | ✅ | P1-3（排序UI）、P2-7（嵌套dialog） |
| 区域管理 | ✅ | ✅ | ✅ | 无 |
| 设计师管理 | ✅ | ✅ | ⚠️ 状态切换缺 | P1-6 |
| 设计师分组 | ✅ | ✅ | ✅ | 无 |
| 线索管理 | ⚠️ 更新无验证 | ✅ | ✅ | 轻微（可补充） |
| 预约管理 | ❌ 无验证 | ✅ | ✅ | P0-2 |
| 订单管理 | ❌ 无验证 | ✅ | ✅ | P0-1 |

---

## 四、建议执行顺序

```
第一批（P0，影响数据正确性）
├── 订单：发货时物流单号条件必填
└── 预约：状态字段 required 验证

第二批（P1，体验优化）
├── 品类：规格排序 UI（上移/下移按钮 + 提交接口）
├── Banner：时间交叉验证
├── 商品：批量归档确认弹窗
└── 设计师：手机号字段说明文案或输入方式优化

第三批（P2，代码质量）
├── categories 规格 dialog 改为平级
├── 商品规格参数按品类缓存
└── leads 日期 watch 自动同步
```

---

## 五、本次不建议改动的内容

- **代码重复（statusOptions、resetFormState 等）**：重构收益与风险比低，当前阶段保持现状
- **API PUT/PATCH 统一化**：前后端接口契约已稳定，强行统一代价高
- **getCurrentInstance() 替换**：项目范围内统一用法，不做局部替换
- **leads 手机号**：后端已处理脱敏，前端无需改动

---

*文件路径：`docs/admin-ui-review-20260315-v2.md`*
