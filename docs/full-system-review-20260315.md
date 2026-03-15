# 柏厚生活系统全量代码评审报告

**日期：** 2026-03-15
**范围：** 微信小程序前端 + Vue3 管理后台 + Java Spring Boot 后端
**评审方法：** 全量静态分析（controllers/services/mappers/pages/stores/API 层）

---

## 一、系统架构概览

```
frontend/baihou-life-miniprogram/
├── pages/          13 个业务页面
├── services/       7 个服务模块
├── store/          user + region 双 store
└── utils/          request、auth、storage

backend/ruoyi-baihou-life/
├── ruoyi-baihou/   业务层（controller / service / mapper / domain）
└── ruoyi-ui-vue3/  Vue3 后台（9 个管理页面 + api/baihou/ 层）
```

---

## 二、P0 — 影响数据安全，须立即处理

### 1. Service 层无事务注解（高风险）

**范围：** `BaihouProductServiceImpl`、`BaihouOrderServiceImpl`、`BaihouAppointmentServiceImpl` 等全部 impl

**现状：** 全项目检索无任何 `@Transactional` 注解。

**风险场景（商品批量归档为例）：**
```java
// BaihouProductServiceImpl.java
public int batchUpdateProductStatus(List<Long> ids, String action) {
    if ("archive".equals(action)) {
        return productMapper.batchArchiveProducts(ids);  // ← 无事务包裹
    }
    for (Long id : ids) {
        validateBeforeOnShelf(...);  // 验证与更新之间若异常，部分已改、部分未改
    }
    return productMapper.batchUpdateProductStatus(ids, action);
}
```

**建议：** 所有 Service 公共方法加 `@Transactional(rollbackFor = Exception.class)`；只读方法加 `@Transactional(readOnly = true)`。

---

### 2. 分页 pageSize 无上限（防 DoS）

**文件：** `BaihouProductController.java` 及所有带分页的接口

**现状：** pageSize 完全由客户端传入，未在后端做校验。

**风险：** 恶意请求 `pageSize=1000000` 可触发全表扫描，导致数据库 OOM。

**建议：**
```java
private static final int MAX_PAGE_SIZE = 100;

int safePageSize = (pageSize == null) ? 10 : Math.min(pageSize, MAX_PAGE_SIZE);
```

---

## 三、P1 — 影响运营与安全，建议本周处理

### 3. 小程序 Token 自动刷新缺失

**文件：** `src/utils/request.js`

**现状：** 服务端返回 401 时，只展示错误 toast，未尝试刷新 token 或自动重试。用户长会话（超过 Token 有效期）时会被突然踢出，体验差。

**建议：**
```javascript
// request.js 响应处理中
if (statusCode === 401) {
  // 尝试用 refresh_token 换新 token
  return authService.refreshToken().then(newToken => {
    // 重放原始请求
    return doRequest({ ...originalOptions, header: { Authorization: `Bearer ${newToken}` } })
  }).catch(() => {
    userStore.logout()
    wx.navigateTo({ url: '/pages/auth/index' })
  })
}
```

---

### 4. Banner 后端无时间交叉验证

**文件：** `BaihouBannerController.java` / `BaihouBannerServiceImpl.java`

**现状：** 前端（Vue3 `banners/index.vue`）已有 endTime > startTime 的自定义 validator，但后端未做服务端校验，绕过前端可直接 POST 无效数据。

**建议：** 在 Service 层加：
```java
if (banner.getEndTime() != null && banner.getStartTime() != null
    && !banner.getEndTime().after(banner.getStartTime())) {
    throw new ServiceException("结束时间必须晚于开始时间");
}
```

---

### 5. 小程序 API 错误对象不统一

**文件：** `src/utils/request.js`

**现状：** 业务错误（`response.code !== 200`）直接 `reject(response)`，调用侧需要访问 `error.msg`；网络错误直接 `reject(response || { code: statusCode })`，字段名不一致。

**影响：** 已有多处 `.catch(err => wx.showToast({ title: err.msg || '操作失败' }))` 的防御写法，说明调用方已感知到不统一。

**建议：** 统一错误格式：
```javascript
if (response.code !== 200) {
    const error = new Error(response.msg || '操作失败')
    error.code = response.code
    error.data = response.data
    reject(error)
    return
}
```

---

### 6. 小程序商品列表：筛选重置后区域未还原

**文件：** `src/pages/product/list/index.js`

**现状：** `resetFilters()` 重置了 `categoryId`、`spaceTag`、`sceneTag`，但 `region_id` 沿用 store 中的当前区域，用户在页面内手动切换区域后重置不会还原为初始区域。

**建议：** 重置时同步从 `regionStore.getState()` 重新读取区域 ID，保持一致性。

---

## 四、P2 — 代码质量，下次迭代处理

### 7. Service 层缺少输入验证

**现状：** Controller 对入参几乎无 `@Valid` 或手动校验；Service 层验证主要集中在"上架前完整性检查"，其他接口无验证。

**风险举例：**
- `BaihouOrderController.update()` 接收 JSON body，`status` 字段可传任意字符串（如 `"hacked"`），写入数据库后破坏状态机
- `BaihouDesignerController.add()` 无手机号格式校验

**建议：** 为 domain 实体补充 Bean Validation 注解（`@NotBlank`、`@Pattern`、`@Size`），Controller 方法参数加 `@Validated`。

---

### 8. BaihouLeadServiceImpl 导出无分页保护

**文件：** `BaihouLeadServiceImpl.java → exportLeads()`

**现状：** 导出查询不带分页，若线索数量过大（数万条）会全量加载到内存。

**建议：** 导出加 `pageSize = 5000` 分批流式写入 CSV，或限制最大导出条数并提示用户。

---

### 9. 小程序 parseArray 暗示后端数据不统一

**文件：** `src/services/product.js`

```javascript
function parseArray(value) {
    if (Array.isArray(value)) return value          // 有时返回数组
    try {
        const parsed = JSON.parse(value)
        return Array.isArray(parsed) ? parsed : []  // 有时返回 JSON 字符串
    } catch {
        return value.split(",").map(s => s.trim())  // 有时返回逗号分隔
    }
}
```

**现状：** 同一字段（`regions`、`spaceTags`、`sceneTags`）在不同接口/版本中可能返回三种格式。

**建议：** 后端统一序列化为 JSON 数组字符串；小程序端 service 层只做一次 `JSON.parse`，不需要多态处理。

---

### 10. 管理后台：敏感删除操作无二次确认

**文件：** `regions/index.vue`、`designer-groups/index.vue`

**现状：** 区域删除、分组删除按钮点击后直接调用 API，无 `ElMessageBox.confirm`（商品归档已加，但以上两处未加）。

**建议：** 所有删除操作统一加确认弹框。

---

### 11. 区域管理：筛选栏 regionId 字段体验问题

**文件：** `orders/index.vue`、`appointments/index.vue`

**现状：** 筛选区域输入框为 `el-input` 文本框，要求运营手动输入区域 ID（数字），与其他页面已改为下拉选择的体验不一致。

**建议：** 将这两个页面的区域筛选改为与 products/banners 一致的 `el-select`（调用 `getRegionOptions()`）。

---

## 五、各系统安全性汇总

| 项目 | 状态 | 说明 |
|------|------|------|
| SQL 注入 | ✅ 安全 | 全量使用 `#{}` 参数化，无 `${}` 拼接 |
| XSS 防护 | ✅ 安全 | URL encode/decode 规范，小程序原生 API 无 innerHTML |
| CSRF 防护 | ✅ 安全 | Spring Security 默认启用 |
| 后端权限控制 | ✅ 完整 | 全部 51 处接口均有 `@PreAuthorize` |
| 前端权限控制 | ✅ 完整 | 全部 23 处操作按钮均有 `v-hasPermi` |
| 手机号脱敏 | ✅ 已处理 | 后端返回即为脱敏值，前端无明文 |
| 事务一致性 | ❌ 缺失 | 全项目无 `@Transactional` |
| 分页防护 | ❌ 缺失 | pageSize 无后端上限 |
| Token 刷新 | ⚠️ 缺失 | 401 未自动重试 |

---

## 六、各页面当前状态表

### 管理后台（9 个页面）

| 页面 | 表单验证 | 权限控制 | 危险操作确认 | 本次新增待办 |
|------|---------|---------|-----------|------------|
| 商品管理 | ✅ | ✅ | ✅（归档已加） | P2-10（区域筛选下拉化） |
| Banner 管理 | ✅（时间校验已加） | ✅ | ✅ | P1-4（后端服务端校验） |
| 品类管理 | ✅ | ✅ | ✅ | 无 |
| 区域管理 | ✅ | ✅ | ⚠️ 删除缺确认 | P2-10 |
| 设计师管理 | ✅ | ✅ | ⚠️ 状态切换缺确认 | P2-7（后端 @Valid） |
| 设计师分组 | ✅ | ✅ | ⚠️ 删除缺确认 | P2-10 |
| 线索管理 | ✅ | ✅ | ✅ | P2-8（导出限量） |
| 预约管理 | ✅（状态验证已加） | ✅ | ✅ | P2-11（区域筛选下拉化） |
| 订单管理 | ✅（物流单号验证已加） | ✅ | ✅ | P2-11（区域筛选下拉化） |

### 小程序（主要页面）

| 页面 | 表单验证 | 认证保护 | 主要待办 |
|------|---------|---------|---------|
| 商品列表 | — | — | P2-6（重置时区域还原） |
| 商品详情 | — | — | 无 |
| 留资表单 | ✅ | — | 无 |
| 预约创建 | ✅（含协议确认） | ✅ | 无 |
| 订单列表/详情 | — | ✅ | 无 |
| 设计师素材 | — | ✅ role=2 | 无 |

---

## 七、建议执行顺序

```
第一批（P0，数据安全）
├── Service 层全量补 @Transactional
└── pageSize 后端上限（MAX=100）

第二批（P1，运营安全）
├── Banner 后端加时间交叉验证
├── 小程序 Token 自动刷新机制
└── 统一 request.js 错误对象格式

第三批（P2，代码质量）
├── Controller 层补 @Valid + Bean Validation 注解
├── 删除操作统一加确认弹框（区域、分组）
├── 订单/预约区域筛选改为下拉
├── leads 导出加分批/限量保护
└── 后端 JSON 字段序列化统一（消除 parseArray 多态）
```

---

## 八、本次不建议改动的内容

- **代码重复（statusOptions、resetFormState 等）**：重构收益与风险比低，保持现状
- **getCurrentInstance() 替换**：项目内统一用法，不做局部替换
- **Vue 2 ruoyi-ui 目录**：上游参考代码，禁止修改
- **Mock 数据结构**：miniapp mock 已与真实接口对齐，不做调整

---

*文件路径：`docs/full-system-review-20260315.md`*
