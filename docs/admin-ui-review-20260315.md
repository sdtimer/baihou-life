# 管理后台 UI 代码评审报告

**日期：** 2026-03-15
**范围：** `ruoyi-ui-vue3/src/views/baihou/` 全部 9 个页面 + 对应 API 文件
**说明：** 本文档为建议清单，未做任何代码修改，请确认后再执行。

---

## 一、总体评估

| 维度 | 得分 | 说明 |
|------|------|------|
| 功能完整度 | 8/10 | 核心流程完整，部分校验和脱敏缺失 |
| 用户体验 | 7/10 | 缺少部分危险操作确认 |
| 代码一致性 | 5/10 | 模式差异较大，重复逻辑多 |
| 安全 / 合规 | 6/10 | 手机号明文展示、部分权限控制缺失 |

---

## 二、问题清单（按优先级）

### P0 — 必须修复（影响数据安全或数据完整性）

#### 1. 线索管理：手机号明文展示
- **文件：** `leads/index.vue` 表格列
- **现状：** 表格直接展示完整手机号 `phone` 字段
- **风险：** 运营人员截图/导出会暴露用户隐私
- **建议：** 前端脱敏显示（如 `138****8888`），保留完整号码仅用于 CSV 导出（需权限控制）

#### 2. 预约/订单管理：更新表单无验证
- **文件：** `appointments/index.vue`、`orders/index.vue`
- **现状：** 更新对话框缺少 `rules` 和 `formRef.validate()`，空值可以提交
- **订单具体问题：** 备注字段 placeholder 写着"发货时必填物流单号"，但代码无强制校验
- **建议：** 补齐表单验证规则

#### 3. 商品管理：批量归档无二次确认
- **文件：** `products/index.vue`，批量操作区
- **现状：** "批量归档"直接触发，无确认弹窗
- **风险：** 误触一次性归档多条商品
- **建议：** 归档前弹出 `ElMessageBox.confirm` 确认

---

### P1 — 本周处理（影响用户体验或维护成本）

#### 4. Banner 管理：时间范围无交叉验证
- **文件：** `banners/index.vue`
- **现状：** 结束时间可以早于开始时间，无错误提示
- **建议：** 在 `rules` 中添加自定义 validator，`endTime >= startTime`

#### 5. 设计师管理：手机号与哈希字段混乱
- **文件：** `designers/index.vue`
- **现状：** 表格列显示 `phone`（明文），编辑表单 label 写"手机号哈希"但字段是 `phoneHash`
- **两个子问题：**
  - 和线索一样，明文手机号不应直接展示
  - 编辑表单不应要求运营人员手动输入哈希值（哈希应由后端处理）
- **建议：** 统一：表单输入明文手机号，哈希由后端转换，前端展示脱敏格式

#### 6. 品类管理：规格模板嵌套对话框
- **文件：** `categories/index.vue`
- **现状：** 规格定义的编辑对话框嵌套在规格列表对话框内部（Dialog 套 Dialog）
- **已知 Element Plus 问题：** 嵌套 Dialog 在 `append-to-body` 下 z-index 有时会错乱，ESC 键可能同时关闭两层
- **建议：** 将内层对话框改为平级（移出外层 Dialog 的 `<template>`），用 `append-to-body` 独立管理层级

#### 7. 预约/订单管理：缺少按钮权限控制
- **文件：** `appointments/index.vue`、`orders/index.vue`
- **现状：** 操作按钮未使用 `v-hasPermi`，任何登录用户都可以点击更新
- **对比：** products、banners、regions 等均有完整的权限控制
- **建议：** 补加 `v-hasPermi="['baihou:appointment:edit']"` 等

#### 8. 线索管理：CSV 导出转义问题
- **文件：** `leads/index.vue`，`exportLeads` 相关逻辑
- **现状：** 备注字段仅替换了英文逗号为中文逗号，但字段内如有换行符（`\n`）会破坏 CSV 格式
- **建议：** 对 CSV 字段值进行规范转义：包含逗号、换行、双引号的字段用双引号包裹，内部双引号转义为 `""`

---

### P2 — 下个迭代处理（代码质量，不影响当前功能）

#### 9. 重复代码 — 建议提取 composable

以下逻辑在 9 个页面中重复出现，建议提取：

| 重复内容 | 出现次数 | 建议提取为 |
|----------|---------|-----------|
| `const { proxy } = getCurrentInstance()` | 9 次 | 改用 `ElMessage`、`ElMessageBox` 直接导入 |
| `resetFormState()` 的 `Object.assign + proxy.resetForm` 模式 | 9 次 | `useFormReset(form, defaults, formRef)` composable |
| `statusLabel() + statusClass()` 映射函数 | 4 次 | `src/utils/baihou/statusHelper.js` 公共工具 |
| 各模块 `statusOptions` 常量定义 | 7 次 | 集中到 `src/constants/baihouStatus.js` |

#### 10. leads 日期范围同步方式

- **文件：** `leads/index.vue`
- **现状：** `dateRange` 和 `queryParams.startDate/endDate` 需要手动调用 `syncDateRange()` 同步，容易漏掉
- **建议：** 改用 `watch(dateRange, ...)` 自动同步，或用 `computed` 拦截

#### 11. 商品规格参数：品类切换后丢失已填数据

- **文件：** `products/index.vue`，`loadSpecDefs()` 函数
- **现状：** 当用户切换品类时，`specParamsObj` 被重置为 `{}`，即使之后切回原品类，已填的规格参数也丢失
- **建议：** 按 `categoryId` 缓存 `specParamsObj`，切回原品类时恢复

---

## 三、各页面状态一览

| 页面 | 表单验证 | 权限控制 | 危险操作确认 | 整体状态 |
|------|---------|---------|-----------|---------|
| 商品管理 | ✅ | ✅ | ⚠️ 批量归档缺 | 良好，需补确认 |
| Banner 管理 | ⚠️ 缺时间校验 | ✅ | ✅ | 良好，需补时间验证 |
| 品类管理 | ✅ | ✅ | ✅ | 良好，对话框嵌套建议优化 |
| 区域管理 | ✅ | ✅ | ✅ | 良好 |
| 设计师管理 | ✅ | ✅ | ⚠️ 状态切换缺 | 需处理手机号问题 |
| 设计师分组 | ✅ | ✅ | ✅ | 良好 |
| 线索管理 | ⚠️ 更新无验证 | ✅ 部分 | ✅ | **手机号脱敏 P0** |
| 预约管理 | ❌ 无验证 | ❌ 无权限 | ✅ | **P0+P1 均需处理** |
| 订单管理 | ❌ 无验证 | ❌ 无权限 | ✅ | **P0+P1 均需处理** |

---

## 四、建议执行顺序

```
第一批（P0，立即执行）
├── leads 手机号脱敏
├── appointments/orders 补表单验证
└── products 批量归档确认弹窗

第二批（P1，本周）
├── banners 时间交叉验证
├── appointments/orders 补权限控制
├── designers 手机号 / 哈希统一
├── categories 规格模板对话框解耦
└── leads CSV 导出转义修复

第三批（P2，下个迭代）
├── 提取 statusHelper.js 公共常量
├── leads 日期范围改用 watch 自动同步
└── 商品规格参数按品类缓存
```

---

## 五、不建议做的事

- **不要重构为 composables** — 目前业务逻辑都在页面内，项目阶段不适合大规模重构，会引入风险且收益有限
- **不要统一 API 风格（PUT vs PATCH）** — 后端已稳定，动 API 契约需要前后端同步，当前阶段风险大于收益
- **不要替换 `getCurrentInstance()`** — 整个项目都在用，统一替换影响面太大，在新页面改用直接导入即可

---

*本文档待确认后执行，文件路径：`docs/admin-ui-review-20260315.md`*
