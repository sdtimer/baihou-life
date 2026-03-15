# Review Fixes Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 修复全量代码评审（full-system-review-20260315.md）识别的 P0+P1+P2 问题，共 7 项任务。

**Architecture:**
- P0 后端（Java）：在 Service 层加 @Transactional；在控制器加 pageSize 上限
- P1 后端（Java）：Banner 时间校验加入 BaihouBannerServiceImpl
- P1 小程序（JS）：统一 request.js 错误对象；request.js 加 401 自动重新登录
- P2 后端（Java）：Controller 加 @Validated + domain 加 Bean Validation 注解
- P2 前端（Vue3）：订单/预约区域筛选改为下拉选择

**Tech Stack:**
- Java 17 / Spring Boot / `org.springframework.transaction.annotation.@Transactional` / `jakarta.validation.constraints.*`
- JUnit 5 + Mockito（纯单元测试，无 Spring 上下文，用 `ReflectionTestUtils.setField`）
- Vue 3 + Element Plus
- 微信小程序原生 JS

**测试运行命令（后端）：**
```bash
cd backend/ruoyi-baihou-life
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' \
  -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false \
  -pl ruoyi-admin -am \
  -Dtest=<TestClassName> test
```

---

## Task 1：Service 层全量补 @Transactional（P0）

**背景：** 11 个 Service impl 文件无任何 `@Transactional` 注解。`batchUpdateProductStatus` 在验证循环和批量更新之间若抛出异常，会导致部分记录已改、部分未改。

**Files:**
- Test: `backend/ruoyi-baihou-life/ruoyi-admin/src/test/java/com/ruoyi/BaihouTransactionalAnnotationTest.java` — 新建
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouProductServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouBannerServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouCategoryServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouCategorySpecDefServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouRegionServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouDesignerServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouDesignerGroupServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouLeadServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouAppointmentServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouOrderServiceImpl.java`
- Modify: `backend/ruoyi-baihou-life/ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouWxUserServiceImpl.java`

### Step 1：写 failing 测试

新建 `BaihouTransactionalAnnotationTest.java`，用反射断言每个 impl 类上有 `@Transactional`：

```java
package com.ruoyi;

import com.ruoyi.baihou.service.impl.*;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.assertNotNull;

class BaihouTransactionalAnnotationTest {

    @Test
    void productServiceImplShouldBeTransactional() {
        assertNotNull(BaihouProductServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouProductServiceImpl missing @Transactional");
    }

    @Test
    void bannerServiceImplShouldBeTransactional() {
        assertNotNull(BaihouBannerServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouBannerServiceImpl missing @Transactional");
    }

    @Test
    void categoryServiceImplShouldBeTransactional() {
        assertNotNull(BaihouCategoryServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouCategoryServiceImpl missing @Transactional");
    }

    @Test
    void categorySpecDefServiceImplShouldBeTransactional() {
        assertNotNull(BaihouCategorySpecDefServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouCategorySpecDefServiceImpl missing @Transactional");
    }

    @Test
    void regionServiceImplShouldBeTransactional() {
        assertNotNull(BaihouRegionServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouRegionServiceImpl missing @Transactional");
    }

    @Test
    void designerServiceImplShouldBeTransactional() {
        assertNotNull(BaihouDesignerServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouDesignerServiceImpl missing @Transactional");
    }

    @Test
    void designerGroupServiceImplShouldBeTransactional() {
        assertNotNull(BaihouDesignerGroupServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouDesignerGroupServiceImpl missing @Transactional");
    }

    @Test
    void leadServiceImplShouldBeTransactional() {
        assertNotNull(BaihouLeadServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouLeadServiceImpl missing @Transactional");
    }

    @Test
    void appointmentServiceImplShouldBeTransactional() {
        assertNotNull(BaihouAppointmentServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouAppointmentServiceImpl missing @Transactional");
    }

    @Test
    void orderServiceImplShouldBeTransactional() {
        assertNotNull(BaihouOrderServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouOrderServiceImpl missing @Transactional");
    }

    @Test
    void wxUserServiceImplShouldBeTransactional() {
        assertNotNull(BaihouWxUserServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouWxUserServiceImpl missing @Transactional");
    }
}
```

### Step 2：运行测试确认 FAIL

```bash
cd backend/ruoyi-baihou-life
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouTransactionalAnnotationTest test
```
预期：11 个测试全部 FAIL，"missing @Transactional"

### Step 3：给所有 Service impl 加 @Transactional

在每个 impl 类的 `@Service` 注解正下方加两行（先加 import，再加注解）。

> **重要提示：** `rollbackFor = Exception.class` 表示所有受检异常也回滚，而 Spring 默认只回滚 RuntimeException。

对 `BaihouProductServiceImpl.java`：
```java
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class)
public class BaihouProductServiceImpl implements IBaihouProductService
```

对其余 10 个 impl 文件（BaihouBannerServiceImpl、BaihouCategoryServiceImpl、BaihouCategorySpecDefServiceImpl、BaihouRegionServiceImpl、BaihouDesignerServiceImpl、BaihouDesignerGroupServiceImpl、BaihouLeadServiceImpl、BaihouAppointmentServiceImpl、BaihouOrderServiceImpl、BaihouWxUserServiceImpl）施加完全相同的改动：

```java
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class)
public class Baihou<Xxx>ServiceImpl ...
```

> **只读优化（可选，本次不做）：** 对纯 select 方法可加方法级 `@Transactional(readOnly = true)` 覆盖类级别注解——但这属于性能优化，不在本 P0 范围内。

### Step 4：运行测试确认 PASS

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouTransactionalAnnotationTest test
```
预期：11 个测试全部 PASS

### Step 5：运行全量测试确认无回归

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouAdminPermissionAnnotationTest,BaihouOrderJobTest,BaihouOrderControllerTest,BaihouOrderServiceImplTest,BaihouAppointmentControllerTest,BaihouAppointmentServiceImplTest,BaihouLeadControllerTest,BaihouLeadServiceImplTest,BaihouDesignerControllerTest,BaihouDesignerGroupControllerTest,BaihouDesignerServiceImplTest,BaihouDesignerGroupServiceImplTest,BaihouProductControllerTest,BaihouProductServiceImplTest,BaihouBannerControllerTest,BaihouBannerServiceImplTest,BaihouAdminControllerTest,BaihouServiceImplTest,BaihouModuleIntegrationTest,BaihouModuleStructureTest,BaihouTransactionalAnnotationTest test
```
预期：全部 PASS

### Step 6：Commit

```bash
cd backend/ruoyi-baihou-life
git add ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/
git add ruoyi-admin/src/test/java/com/ruoyi/BaihouTransactionalAnnotationTest.java
git commit -m "feat(backend): add @Transactional to all service impls for data consistency"
```

---

## Task 2：pageSize 后端上限（P0）

**背景：** `BaihouProduct` domain 带有 `pageSize` 字段，controller 直接透传到 service，无上限保护。其他 domain（如 BaihouLead）也有同样问题。

**Files:**
- Test: `backend/.../ruoyi-admin/src/test/java/com/ruoyi/BaihouPageSizeLimitTest.java` — 新建
- Modify: `backend/.../ruoyi-baihou/src/main/java/com/ruoyi/baihou/domain/BaihouProduct.java`
- Modify: `backend/.../ruoyi-baihou/src/main/java/com/ruoyi/baihou/domain/BaihouLead.java`

> **策略：** 在 domain 的 `setPageSize()` setter 中截断，这样无论从哪里设置都生效，无需改多个地方。

### Step 1：写 failing 测试

```java
package com.ruoyi;

import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.domain.BaihouLead;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class BaihouPageSizeLimitTest {

    @Test
    void productPageSizeShouldBeCapAt100() {
        BaihouProduct product = new BaihouProduct();
        product.setPageSize(999999);
        assertEquals(100, product.getPageSize(), "pageSize should be capped at 100");
    }

    @Test
    void productPageSizeShouldKeepSmallValue() {
        BaihouProduct product = new BaihouProduct();
        product.setPageSize(20);
        assertEquals(20, product.getPageSize());
    }

    @Test
    void productPageSizeNullShouldStayNull() {
        BaihouProduct product = new BaihouProduct();
        product.setPageSize(null);
        assertEquals(null, product.getPageSize());
    }

    @Test
    void leadPageSizeShouldBeCapAt100() {
        BaihouLead lead = new BaihouLead();
        lead.setPageSize(500);
        assertEquals(100, lead.getPageSize(), "pageSize should be capped at 100");
    }
}
```

### Step 2：运行测试确认 FAIL

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouPageSizeLimitTest test
```
预期：`productPageSizeShouldBeCapAt100` 和 `leadPageSizeShouldBeCapAt100` FAIL，其余 PASS

### Step 3：修改 `BaihouProduct.java` 的 setter

找到 `setPageSize` 方法，改为：

```java
private static final int MAX_PAGE_SIZE = 100;

public void setPageSize(Integer pageSize) {
    if (pageSize != null && pageSize > MAX_PAGE_SIZE) {
        this.pageSize = MAX_PAGE_SIZE;
    } else {
        this.pageSize = pageSize;
    }
}
```

### Step 4：在 `BaihouLead.java` 做同样修改

先确认 BaihouLead 有 `pageSize` 字段（它继承 BaseEntity，BaseEntity 中可能有 pageNum/pageSize）。

> **注意：** 如果 pageNum/pageSize 定义在 `BaseEntity` 而非 `BaihouProduct` 本身（需要检查），则只需修改 `BaseEntity` 的 setter 即可，所有子类自动生效，BaihouLead 不需要单独改。打开 `BaseEntity.java` 查看：若有 `setPageSize`，只改那一处；否则逐 domain 改。

路径：`backend/ruoyi-baihou-life/ruoyi-common/src/main/java/com/ruoyi/common/core/domain/BaseEntity.java`

### Step 5：运行测试确认 PASS

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouPageSizeLimitTest test
```
预期：4 个测试全部 PASS

### Step 6：Commit

```bash
git add ruoyi-baihou/src/main/java/com/ruoyi/baihou/domain/BaihouProduct.java
git add ruoyi-baihou/src/main/java/com/ruoyi/baihou/domain/BaihouLead.java
git add ruoyi-admin/src/test/java/com/ruoyi/BaihouPageSizeLimitTest.java
git commit -m "fix(backend): cap pageSize at 100 to prevent DoS via large queries"
```

---

## Task 3：Banner 后端时间交叉校验（P1）

**背景：** `BaihouBannerServiceImpl` 已有 `validateRegions()`，但 `insertBanner`/`updateBanner` 未校验 `endTime > startTime`，可绕过前端验证直接 POST 无效数据。

**Files:**
- Test: `backend/.../ruoyi-admin/src/test/java/com/ruoyi/BaihouBannerServiceImplTest.java` — 追加 2 个测试用例
- Modify: `backend/.../ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouBannerServiceImpl.java`

### Step 1：在 `BaihouBannerServiceImplTest.java` 末尾追加测试

打开文件，在最后一个 `@Test` 方法之后（`}` 类结尾之前）加入：

```java
@Test
void bannerInsertShouldRejectEndTimeBeforeStartTime() {
    BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
    BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
    ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

    BaihouBanner banner = new BaihouBanner(null, "测试", "https://cdn.example.com/a.jpg");
    banner.setStartTime(new java.util.Date(System.currentTimeMillis() + 3600_000)); // 1 hour later
    banner.setEndTime(new java.util.Date(System.currentTimeMillis()));              // now (BEFORE start)

    assertThrows(com.ruoyi.common.exception.ServiceException.class,
        () -> service.insertBanner(banner),
        "end before start should throw ServiceException");
}

@Test
void bannerUpdateShouldRejectEndTimeEqualToStartTime() {
    BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
    BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
    ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

    long now = System.currentTimeMillis();
    BaihouBanner banner = new BaihouBanner(1L, "测试", "https://cdn.example.com/a.jpg");
    banner.setStartTime(new java.util.Date(now));
    banner.setEndTime(new java.util.Date(now));  // equal → should also fail

    assertThrows(com.ruoyi.common.exception.ServiceException.class,
        () -> service.updateBanner(banner),
        "end equal to start should throw ServiceException");
}

@Test
void bannerInsertShouldAllowNullTimes() {
    BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
    Mockito.when(bannerMapper.insertBanner(Mockito.any())).thenReturn(1);
    BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
    ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

    BaihouBanner banner = new BaihouBanner(null, "测试", "https://cdn.example.com/a.jpg");
    // startTime and endTime both null → should pass without exception
    assertEquals(1, service.insertBanner(banner));
}
```

### Step 2：运行 BaihouBannerServiceImplTest 确认新用例 FAIL

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouBannerServiceImplTest test
```
预期：已有测试 PASS；新增的 `bannerInsertShouldRejectEndTimeBeforeStartTime` 和 `bannerUpdateShouldRejectEndTimeEqualToStartTime` FAIL

### Step 3：在 `BaihouBannerServiceImpl.java` 中加 `validateTime` 并调用

找到 `validateRegions(BaihouBanner banner)` 方法，在其下方添加：

```java
private void validateTime(BaihouBanner banner) {
    if (banner == null || banner.getStartTime() == null || banner.getEndTime() == null) {
        return;
    }
    if (!banner.getEndTime().after(banner.getStartTime())) {
        throw new ServiceException("结束时间必须晚于开始时间");
    }
}
```

然后在 `insertBanner` 和 `updateBanner` 方法体内已有 `validateRegions(banner)` 一行之后，各追加一行：

```java
validateTime(banner);
```

### Step 4：运行测试确认全部 PASS

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouBannerServiceImplTest test
```
预期：全部 PASS（含新增 3 个）

### Step 5：Commit

```bash
git add ruoyi-baihou/src/main/java/com/ruoyi/baihou/service/impl/BaihouBannerServiceImpl.java
git add ruoyi-admin/src/test/java/com/ruoyi/BaihouBannerServiceImplTest.java
git commit -m "fix(backend): validate banner endTime > startTime in service layer"
```

---

## Task 4：小程序 request.js 错误对象格式统一（P1）

**背景：** 业务错误（`response.code !== 200`）执行 `reject(response)`，调用方收到的是裸对象；网络错误执行 `reject(response || { code: statusCode, msg: '请求失败' })`，字段名不一致。统一改为 `Error` 对象，通过 `error.code` 和 `error.message` 访问。

**Files:**
- Modify: `frontend/baihou-life-miniprogram/src/utils/request.js`

> **注意：** 微信小程序环境无法写自动化单元测试（wx.request 无法脱离真机运行）。需手动验证改动后所有 `.catch(err => ...)` 调用侧仍可正常访问错误信息。

### Step 1：修改 `request.js` 的 success/fail 处理

当前代码中找到：

```javascript
if (response.code === 200) {
  resolve(response);
  return;
}
reject(response);
return;
```

改为：

```javascript
if (response.code === 200) {
  resolve(response);
  return;
}
const bizError = new Error(response.msg || '操作失败');
bizError.code = response.code;
bizError.data = response.data;
reject(bizError);
return;
```

同时找到：

```javascript
reject(response || { code: statusCode, msg: "请求失败" });
```

改为：

```javascript
const httpError = new Error((response && response.msg) || `请求失败（${statusCode}）`);
httpError.code = statusCode;
reject(httpError);
```

以及：

```javascript
fail: reject
```

改为：

```javascript
fail: (err) => {
  const netError = new Error(err.errMsg || '网络错误');
  netError.code = 'NETWORK_ERROR';
  reject(netError);
}
```

### Step 2：检查调用侧兼容性

搜索所有 `.catch` 调用：

```bash
grep -rn "\.catch\|reject\b" frontend/baihou-life-miniprogram/src/pages/ \
  frontend/baihou-life-miniprogram/src/services/
```

每个 `.catch(err => ...)` 中：
- 原来访问 `err.msg` → 改为 `err.message`（`Error` 对象用 `.message`）
- 原来访问 `err.code` → 不变（我们已挂载 `.code`）

> **常见模式：**  `wx.showToast({ title: err.msg || '操作失败' })` 改为 `wx.showToast({ title: err.message || '操作失败' })`

### Step 3：手动验证（无自动化测试）

在微信开发者工具中：
1. 触发一个会失败的业务操作（如提交表单到不存在的接口），确认 Toast 仍正常显示
2. 断开网络，确认网络错误 Toast 正常显示
3. 正常操作，确认 resolve 路径不受影响

### Step 4：Commit

```bash
git add frontend/baihou-life-miniprogram/src/utils/request.js
git add frontend/baihou-life-miniprogram/src/pages/
git add frontend/baihou-life-miniprogram/src/services/
git commit -m "fix(miniapp): standardize request error objects to Error class"
```

---

## Task 5：小程序 Token 401 自动重新登录（P1）

**背景：** 后端 JWT 过期返回 401 时，小程序只展示 toast，用户被踢出。需在 401 时自动重新调用 `wx.login()` 换取新 token，然后重放原始请求。

**微信小程序特殊性：** 没有 `refresh_token` 概念，重新登录直接走 `wx.login()` → 服务端 `/v1/auth/wechat-login`。

**Files:**
- Modify: `frontend/baihou-life-miniprogram/src/utils/request.js`
- Modify: `frontend/baihou-life-miniprogram/src/services/auth.js`（暴露 `silentLogin` 函数）
- Modify: `frontend/baihou-life-miniprogram/src/utils/auth.js`（暴露 `setAuth` 供 silentLogin 调用）
- Modify: `frontend/baihou-life-miniprogram/src/store/user.js`（确认 setAuth 已导出）

### Step 1：在 `user.js` 确认 `setAuth` 已导出

打开 `frontend/baihou-life-miniprogram/src/store/user.js`，确认 `module.exports` 包含 `setAuth`。若无则添加。

### Step 2：在 `services/auth.js` 添加 `silentLogin`

在文件末尾追加：

```javascript
/**
 * 静默重新登录（用于 401 自动重试场景）。
 * 调用 wx.login 换取新 token 并保存到 store。
 * @returns {Promise<string>} 新 token
 */
async function silentLogin() {
  const result = await login();          // 复用已有的 login()
  const userStore = require('../store/user');
  userStore.setAuth({ token: result.data.token, user: result.data.user });
  return result.data.token;
}

module.exports = {
  login,
  silentLogin
};
```

### Step 3：在 `request.js` 加 401 拦截与重试

`request.js` 顶部已有：
```javascript
const auth = require('./auth');
```

修改 success 回调，在 HTTP 状态码判断前加：

```javascript
success: ({ statusCode, data: response }) => {
  // 401：尝试静默重新登录后重放
  if (statusCode === 401) {
    const authService = require('../services/auth');
    authService.silentLogin()
      .then(() => {
        // 重建 header（新 token 已写入 store，auth.getToken() 会返回最新值）
        request({ url, method, data, header }).then(resolve).catch(reject);
      })
      .catch(() => {
        // 重新登录失败，跳转到登录页
        const userStore = require('../store/user');
        userStore.logout();
        wx.navigateTo({ url: '/pages/auth/index' });
        const authError = new Error('登录已过期，请重新登录');
        authError.code = 401;
        reject(authError);
      });
    return;
  }
  // ...其余原有逻辑不变
```

> **防止无限循环：** 若 silentLogin 本身返回 401（服务端有问题），会在 `.catch()` 中捕获并跳转到登录页，不会再次重试。

### Step 4：手动验证

1. 后端修改 JWT 有效期为 1 秒（临时），登录后等待过期，再操作 → 应自动重新登录并成功完成操作
2. 后端下线，所有请求失败 → 应弹 toast 说明网络错误，不循环

### Step 5：Commit

```bash
git add frontend/baihou-life-miniprogram/src/utils/request.js
git add frontend/baihou-life-miniprogram/src/services/auth.js
git add frontend/baihou-life-miniprogram/src/store/user.js
git commit -m "feat(miniapp): auto silent re-login on 401 and retry original request"
```

---

## Task 6：Controller 层加 @Validated 与 Bean Validation（P2）

**背景：** Controller `@RequestBody BaihouProduct product` 等接收 JSON 但无 `@Validated`，`status` 字段可传任意字符串破坏状态机；BaihouDesigner 无手机号格式校验。

**Strategy:** 仅给最高风险字段加校验（不给全量 domain 加，避免过度工程）：
- `BaihouProduct.status` — 允许枚举值之一
- `BaihouDesigner.phone` — 中国手机号格式

**Files:**
- Test: `backend/.../ruoyi-admin/src/test/java/com/ruoyi/BaihouBeanValidationTest.java` — 新建
- Modify: `backend/.../ruoyi-baihou/src/main/java/com/ruoyi/baihou/domain/BaihouProduct.java`
- Modify: `backend/.../ruoyi-baihou/src/main/java/com/ruoyi/baihou/domain/BaihouDesigner.java`
- Modify: `backend/.../ruoyi-baihou/src/main/java/com/ruoyi/baihou/controller/admin/BaihouProductController.java`
- Modify: `backend/.../ruoyi-baihou/src/main/java/com/ruoyi/baihou/controller/admin/BaihouDesignerController.java`

### Step 1：写 failing 测试

```java
package com.ruoyi;

import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.domain.BaihouDesigner;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class BaihouBeanValidationTest {

    private static final Validator validator =
        Validation.buildDefaultValidatorFactory().getValidator();

    @Test
    void productStatusShouldRejectArbitraryString() {
        BaihouProduct p = new BaihouProduct();
        p.setStatus("hacked");
        Set<ConstraintViolation<BaihouProduct>> violations = validator.validateProperty(p, "status");
        assertFalse(violations.isEmpty(), "arbitrary status should fail validation");
    }

    @Test
    void productStatusShouldAllowOnShelf() {
        BaihouProduct p = new BaihouProduct();
        p.setStatus("on_shelf");
        Set<ConstraintViolation<BaihouProduct>> violations = validator.validateProperty(p, "status");
        assertTrue(violations.isEmpty(), "on_shelf is valid status");
    }

    @Test
    void designerPhoneShouldRejectInvalidFormat() {
        BaihouDesigner d = new BaihouDesigner();
        d.setPhone("12345");
        Set<ConstraintViolation<BaihouDesigner>> violations = validator.validateProperty(d, "phone");
        assertFalse(violations.isEmpty(), "short phone should fail validation");
    }

    @Test
    void designerPhoneShouldAllowValidPhone() {
        BaihouDesigner d = new BaihouDesigner();
        d.setPhone("13800138000");
        Set<ConstraintViolation<BaihouDesigner>> violations = validator.validateProperty(d, "phone");
        assertTrue(violations.isEmpty(), "valid phone should pass");
    }

    @Test
    void designerPhoneShouldAllowNull() {
        BaihouDesigner d = new BaihouDesigner();
        d.setPhone(null);
        Set<ConstraintViolation<BaihouDesigner>> violations = validator.validateProperty(d, "phone");
        assertTrue(violations.isEmpty(), "null phone is allowed (optional field)");
    }
}
```

### Step 2：运行测试确认 FAIL

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouBeanValidationTest test
```
预期：`productStatusShouldRejectArbitraryString` 和 `designerPhoneShouldRejectInvalidFormat` FAIL

### Step 3：给 `BaihouProduct.status` 字段加注解

在 `BaihouProduct.java` 中，找到 `private String status;`，在其上加：

```java
import jakarta.validation.constraints.Pattern;

@Pattern(
    regexp = "^(draft|on_shelf|off_shelf|archived)$",
    message = "商品状态只能是 draft、on_shelf、off_shelf、archived 之一"
)
private String status;
```

### Step 4：给 `BaihouDesigner.phone` 字段加注解

找到 `BaihouDesigner.java` 的 `private String phone;`，加：

```java
import jakarta.validation.constraints.Pattern;

@Pattern(
    regexp = "^1\\d{10}$",
    message = "手机号格式不正确"
)
private String phone;
```

> `@Pattern` 允许 null，无需 `@NotNull`（手机号是可选的）。

### Step 5：给 Controller 方法加 `@Validated`

`BaihouProductController.java` 中的 `add` 和 `edit` 方法改为：

```java
import org.springframework.validation.annotation.Validated;

@PostMapping
public AjaxResult add(@Validated @RequestBody BaihouProduct product) { ... }

@PutMapping("/{id}")
public AjaxResult edit(@PathVariable Long id, @Validated @RequestBody BaihouProduct product) { ... }
```

`BaihouDesignerController.java` 中的 `add` 和 `edit` 同样加 `@Validated`：

```java
@PostMapping
public AjaxResult add(@Validated @RequestBody BaihouDesigner designer) { ... }

@PutMapping("/{id}")
public AjaxResult edit(@PathVariable Long id, @Validated @RequestBody BaihouDesigner designer) { ... }
```

### Step 6：运行测试确认 PASS

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouBeanValidationTest test
```
预期：5 个测试全部 PASS

### Step 7：Commit

```bash
git add ruoyi-baihou/src/main/java/com/ruoyi/baihou/domain/BaihouProduct.java
git add ruoyi-baihou/src/main/java/com/ruoyi/baihou/domain/BaihouDesigner.java
git add ruoyi-baihou/src/main/java/com/ruoyi/baihou/controller/admin/BaihouProductController.java
git add ruoyi-baihou/src/main/java/com/ruoyi/baihou/controller/admin/BaihouDesignerController.java
git add ruoyi-admin/src/test/java/com/ruoyi/BaihouBeanValidationTest.java
git commit -m "fix(backend): add @Validated and Bean Validation to Product/Designer controllers"
```

---

## Task 7：订单/预约 区域筛选改为下拉选择（P2）

**背景：** `orders/index.vue` 和 `appointments/index.vue` 的区域筛选是 `el-input` 文本框（要求手动填 ID），与其他页面已改为 `el-select` 下拉的体验不一致。

**Files:**
- Modify: `backend/ruoyi-baihou-life/ruoyi-ui-vue3/src/views/baihou/orders/index.vue`
- Modify: `backend/ruoyi-baihou-life/ruoyi-ui-vue3/src/views/baihou/appointments/index.vue`

> 无自动化测试，操作验证方式：开发者工具打开页面，确认筛选区域下拉有选项并可筛选。

### Step 1：修改 `orders/index.vue`

**script 部分：**

在 `import` 行追加 `getRegionOptions` 导入：
```javascript
import { getOrder, listOrders, updateOrder } from "@/api/baihou/orders"
import { getRegionOptions } from "@/api/baihou/regions"
```

在 `const loading = ref(false)` 附近加：
```javascript
const regionOptions = ref([])
```

在 `onMounted` 里加：
```javascript
getRegionOptions().then((res) => {
  regionOptions.value = res.data || []
})
```

**template 部分：**

找到：
```html
<el-input v-model="queryParams.regionId" placeholder="区域 ID" clearable />
```

改为：
```html
<el-select v-model="queryParams.regionId" placeholder="区域" clearable>
  <el-option v-for="item in regionOptions" :key="item.value" :label="item.label" :value="item.value" />
</el-select>
```

### Step 2：修改 `appointments/index.vue`

施加与 Step 1 完全相同的改动（import、ref、onMounted、template 四处）。

### Step 3：验证

1. 打开订单管理页，点击区域下拉，应显示 options 列表
2. 选择某区域，点搜索，列表按区域过滤
3. 点重置，区域下拉清空，列表恢复全量

### Step 4：Commit

```bash
git add backend/ruoyi-baihou-life/ruoyi-ui-vue3/src/views/baihou/orders/index.vue
git add backend/ruoyi-baihou-life/ruoyi-ui-vue3/src/views/baihou/appointments/index.vue
git commit -m "fix(admin-ui): change region filter from text input to dropdown in orders/appointments"
```

---

## 验证全量测试（所有任务完成后）

```bash
cd backend/ruoyi-baihou-life
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false -pl ruoyi-admin -am \
  -Dtest=BaihouAdminPermissionAnnotationTest,BaihouOrderJobTest,BaihouOrderControllerTest,BaihouOrderServiceImplTest,BaihouAppointmentControllerTest,BaihouAppointmentServiceImplTest,BaihouLeadControllerTest,BaihouLeadServiceImplTest,BaihouDesignerControllerTest,BaihouDesignerGroupControllerTest,BaihouDesignerServiceImplTest,BaihouDesignerGroupServiceImplTest,BaihouProductControllerTest,BaihouProductServiceImplTest,BaihouBannerControllerTest,BaihouBannerServiceImplTest,BaihouAdminControllerTest,BaihouServiceImplTest,BaihouModuleIntegrationTest,BaihouModuleStructureTest,BaihouTransactionalAnnotationTest,BaihouPageSizeLimitTest,BaihouBeanValidationTest test
```

预期：全部 PASS（原有 100 个 + 新增 ~20 个）

---

## 任务顺序总结

| # | 任务 | 优先级 | 测试 | 预计改动量 |
|---|------|--------|------|-----------|
| 1 | @Transactional 全量 | P0 | 11 个注解断言 | 11 个 impl 文件各加 2 行 |
| 2 | pageSize 上限 | P0 | 4 个用例 | 1-2 个 domain setter |
| 3 | Banner 时间校验 | P1 | 3 个用例追加 | 1 个 service impl + 1 个方法 |
| 4 | request.js 错误格式 | P1 | 手动验证 | 1 个文件 ~10 行 |
| 5 | Token 401 重试 | P1 | 手动验证 | 2 个文件 ~20 行 |
| 6 | @Validated + Bean Validation | P2 | 5 个用例 | 2 个 domain + 2 个 controller |
| 7 | 区域筛选下拉化 | P2 | 手动验证 | 2 个 Vue 文件各 ~10 行 |
