# 柏厚生活后台管理系统

English version: [README-BAIHOU.md](./README-BAIHOU.md)

## 项目简介

柏厚生活后台管理系统是 `Baihou Life` 小程序一期的运营中台，基于若依前后端分离方案二次开发：

- 后端基线：`RuoYi-Vue`
- 管理端基线：`RuoYi-Vue3`
- 业务模块：`ruoyi-baihou`
- Java 包名：`com.ruoyi.baihou`
- 后台路由前缀：`/admin/`
- 数据表前缀：`bh_`

本仓库已完成若依基线整合、柏厚生活业务模块接入、Vue3 管理端业务页面接入，以及一期后台核心模块的首版实现。

## 一期范围

一期后台覆盖以下 8 个模块：

- `B1` 商品管理
- `B2` 品类树管理
- `B3` 区域管理
- `B4` 设计师账号管理
- `B5` 线索管理
- `B6` 首页推荐位管理
- `B7` 预约管理
- `B8` 订单管理

当前实现包含：

- 后端 `controller/service/mapper/xml/sql` 基线
- Vue3 管理端页面、API 封装与权限指令
- 菜单初始化 SQL
- Quartz 订单超时关闭、自动收货任务
- 控制器、服务、权限契约等自动化测试

## 目录结构

```text
ruoyi-baihou-life/
├── ruoyi-admin/                 # 启动模块与测试
├── ruoyi-common/                # 若依公共模块
├── ruoyi-framework/             # 若依安全与框架配置
├── ruoyi-generator/             # 若依代码生成
├── ruoyi-quartz/                # 定时任务模块
├── ruoyi-system/                # 若依系统模块
├── ruoyi-ui/                    # 若依 Vue2 前端基线，保留参考
├── ruoyi-ui-vue3/               # 柏厚生活实际使用的 Vue3 管理端
├── ruoyi-baihou/                # 柏厚生活业务模块
└── sql/baihou/                  # 柏厚生活业务表与菜单脚本
```

`ruoyi-baihou` 内的业务代码统一落位：

```text
src/main/java/com/ruoyi/baihou/
├── controller/admin
├── domain
├── dto
├── mapper
├── service
├── service/impl
└── job
```

## 技术栈

- Java 8
- Maven 3.x
- Spring Boot
- Spring Security + JWT
- MyBatis
- MySQL
- Redis
- Quartz
- Vue 3
- Element Plus
- Vite

## 已实现模块

### 后端

- 品类、区域：列表、详情、新增、编辑、启停
- 商品：列表筛选、详情、新增、编辑、软删除、批量状态更新、上架前校验
- Banner：列表、新增、编辑、删除
- 设计师、设计师分组：列表、新增、编辑、启停
- 线索：列表、更新、导出
- 预约：列表、状态流转
- 订单：列表、详情、状态流转、定时任务

### 前端

`ruoyi-ui-vue3/src/views/baihou` 已接入以下页面：

- 商品管理
- 品类管理
- 区域管理
- Banner 管理
- 设计师管理
- 设计师分组
- 线索管理
- 预约管理
- 订单管理

页面样式按柏厚生活设计系统调整，使用暖中性色、轻卡片和高可读表格风格，按钮权限已与后端权限码对齐。

## 数据库脚本

业务 SQL 位于 `sql/baihou/`：

- `01_b2_b3_schema.sql`
- `02_b1_product_schema.sql`
- `03_b6_banner_schema.sql`
- `04_b4_designer_schema.sql`
- `05_b5_lead_schema.sql`
- `06_b7_appointment_schema.sql`
- `07_b8_order_schema.sql`
- `08_admin_menu_init.sql`

建议初始化顺序：

1. 执行若依基础库脚本
2. 执行 `sql/baihou/01-07` 业务脚本
3. 执行 `sql/baihou/08_admin_menu_init.sql` 初始化菜单权限

## 本地启动

### 1. 启动后端

```bash
mvn clean package
mvn -pl ruoyi-admin -am spring-boot:run
```

默认启动模块为 `ruoyi-admin`。

### 2. 启动 Vue3 管理端

```bash
cd ruoyi-ui-vue3
npm install
npm run dev
```

生产构建：

```bash
cd ruoyi-ui-vue3
npm run build:prod
```

## 权限与菜单

柏厚生活后台权限码统一使用 `baihou:*` 体系，例如：

- `baihou:product:list`
- `baihou:product:add`
- `baihou:product:edit`
- `baihou:lead:export`
- `baihou:order:edit`

后端控制器已补齐 `@PreAuthorize`，前端页面也已使用 `v-hasPermi` 做按钮级控制。

## 验证情况

当前仓库已完成两类验证：

- 前端：`ruoyi-ui-vue3` 已通过 `npm run build:prod`
- 后端：Baihou 模块相关测试已通过，共 `100` 个测试

示例验证命令：

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' \
  -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false \
  -pl ruoyi-admin -am \
  -Dtest=BaihouAdminPermissionAnnotationTest,BaihouOrderJobTest,BaihouOrderControllerTest,BaihouOrderServiceImplTest,BaihouAppointmentControllerTest,BaihouAppointmentServiceImplTest,BaihouLeadControllerTest,BaihouLeadServiceImplTest,BaihouDesignerControllerTest,BaihouDesignerGroupControllerTest,BaihouDesignerServiceImplTest,BaihouDesignerGroupServiceImplTest,BaihouProductControllerTest,BaihouProductServiceImplTest,BaihouBannerControllerTest,BaihouBannerServiceImplTest,BaihouAdminControllerTest,BaihouServiceImplTest,BaihouModuleIntegrationTest,BaihouModuleStructureTest test
```

## 后续工作

当前代码基线已具备继续联调的条件，下一步建议：

1. 初始化数据库并导入菜单 SQL
2. 启动后端与 Vue3 管理端做真实联调
3. 校验动态菜单、按钮权限、403 与状态流转
4. 补充预发环境配置与初始化数据

## 品牌与命名约定

- 中文品牌名：柏厚生活
- 英文品牌名：`Baihou Life`
- 业务模块：`ruoyi-baihou`
- Java 包名：`com.ruoyi.baihou`
- 仓库目录：`ruoyi-baihou-life`

项目以品牌名称和业务命名为准，不再保留默认若依项目说明作为主 README 内容。
