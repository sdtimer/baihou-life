# 柏厚生活一期项目

## 项目简介

本仓库是 `Baihou Life` 一期项目的主仓，当前已整合：

- 小程序前端工程
- 后台管理系统前后端工程
- 项目设计、接口、测试与实施文档

项目目标是围绕“空间、场景、全案、交付”完成一期线上展示与转化闭环，覆盖区域化选品、设计师素材赋能、客户留资、预约、订单与后台运营配置。

## 当前仓库结构

```text
生活产品展示/
├── docs/                           # 项目文档
├── frontend/
│   └── baihou-life-miniprogram/    # 微信原生小程序
└── backend/
    └── ruoyi-baihou-life/          # 若依二开后台系统
```

主要目录说明：

- `docs/`：统一存放开发目录结构、概要设计、数据库设计、接口与状态机、测试设计、后台实施方案、小程序实施方案、设计系统
- `frontend/baihou-life-miniprogram/`：微信原生小程序工程，按小程序实施方案搭建
- `backend/ruoyi-baihou-life/`：若依后台与 `ruoyi-baihou` 业务模块，包含后台管理端 Vue3 工程

## 品牌与命名约定

- 中文品牌名：柏厚生活
- 英文品牌名：`Baihou Life`
- 小程序工程目录：`baihou-life-miniprogram`
- 后端工程目录：`ruoyi-baihou-life`
- 后端业务模块：`ruoyi-baihou`
- Java 包名：`com.ruoyi.baihou`
- 数据表前缀：`bh_`

## 文档索引

项目核心文档位于 [docs](/Users/timer/2026开发/生活产品展示/docs)：

- [00-开发目录结构.md](/Users/timer/2026开发/生活产品展示/docs/00-开发目录结构.md)
- [01-概要设计.md](/Users/timer/2026开发/生活产品展示/docs/01-概要设计.md)
- [02-数据库设计.md](/Users/timer/2026开发/生活产品展示/docs/02-数据库设计.md)
- [03-接口与状态机设计.md](/Users/timer/2026开发/生活产品展示/docs/03-接口与状态机设计.md)
- [04-测试设计.md](/Users/timer/2026开发/生活产品展示/docs/04-测试设计.md)
- [05-后台管理系统开发计划与实施方案.md](/Users/timer/2026开发/生活产品展示/docs/05-后台管理系统开发计划与实施方案.md)
- [06-设计系统.md](/Users/timer/2026开发/生活产品展示/docs/06-设计系统.md)
- [07-小程序开发计划与实施方案.md](/Users/timer/2026开发/生活产品展示/docs/07-小程序开发计划与实施方案.md)

## 小程序现状

小程序工程位于 [frontend/baihou-life-miniprogram](/Users/timer/2026开发/生活产品展示/frontend/baihou-life-miniprogram)，当前已完成：

- 微信原生工程骨架
- 全局设计 token 与页面壳层
- 公共请求、缓存、鉴权、区域与 mock 运行时
- 首页、登录、选品列表、商品详情、设计师素材、留资、预约、订单、个人中心页面
- 符合设计系统要求的暖中性 UI 风格

当前默认使用 mock 数据：

- 配置文件： [src/config/env.js](/Users/timer/2026开发/生活产品展示/frontend/baihou-life-miniprogram/src/config/env.js)
- `useMock = true`

联调时将其改为真实后端地址并关闭 mock。

## 后台现状

后台工程位于 [backend/ruoyi-baihou-life](/Users/timer/2026开发/生活产品展示/backend/ruoyi-baihou-life)，当前已完成：

- 若依后端基线整合
- `ruoyi-baihou` 业务模块接入
- B1-B8 后台模块后端基础实现
- Vue3 后台管理端业务页面
- 菜单初始化 SQL
- 相关自动化测试

后台仓内说明可参考：

- [backend/ruoyi-baihou-life/README.md](/Users/timer/2026开发/生活产品展示/backend/ruoyi-baihou-life/README.md)
- [backend/ruoyi-baihou-life/README-BAIHOU.md](/Users/timer/2026开发/生活产品展示/backend/ruoyi-baihou-life/README-BAIHOU.md)

## 启动说明

### 小程序

1. 用微信开发者工具打开：
   - [frontend/baihou-life-miniprogram](/Users/timer/2026开发/生活产品展示/frontend/baihou-life-miniprogram)
2. 读取工程配置：
   - `project.config.json`
3. 默认可直接用 mock 数据预览页面流程

### 后台

后端启动与构建说明见：

- [backend/ruoyi-baihou-life/README.md](/Users/timer/2026开发/生活产品展示/backend/ruoyi-baihou-life/README.md)

管理端 Vue3 工程位于：

- [backend/ruoyi-baihou-life/ruoyi-ui-vue3](/Users/timer/2026开发/生活产品展示/backend/ruoyi-baihou-life/ruoyi-ui-vue3)

## 推荐开发顺序

建议继续按以下顺序推进：

1. 小程序与后端真实接口联调
2. 微信开发者工具运行校验与真机测试
3. 数据初始化与菜单权限导入
4. 预约、订单、素材下载和登录链路全链路验证
5. 提审准备与预发环境验证

## 仓库说明

当前仓库已经是单仓结构，包含：

- 文档
- 后台
- 小程序

后续如需新增部署脚本、环境变量模板、运维配置，可继续在根目录新增：

- `ops/`
- `database/`
- `assets/`

以保持与开发目录结构文档一致。
