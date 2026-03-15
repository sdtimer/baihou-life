# Baihou Life 项目

## 项目概述

柏厚生活一期项目，包含小程序前端和后台管理系统。

## 技术栈

- **小程序**: 微信原生小程序
- **后端**: Spring Boot + 若依框架
- **管理端**: Vue3

## 项目结构

```text
生活产品展示/
├── docs/                           # 项目文档
├── frontend/
│   └── baihou-life-miniprogram/    # 微信原生小程序
└── backend/
    └── ruoyi-baihou-life/          # 若依二开后台系统
```

## 开发环境要求

- Node.js (用于小程序开发)
- Java 8+ (后端)
- Maven 3.6+
- 微信开发者工具

## 快速开始

### 小程序开发

1. 用微信开发者工具打开 `frontend/baihou-life-miniprogram`
2. 默认使用 mock 数据，可在 `src/config/env.js` 中切换

### 后端开发

1. 进入 `backend/ruoyi-baihou-life`
2. 执行 `mvn clean install -DskipTests` 构建项目
3. 启动后端服务

## 重要文档

- [开发目录结构](../docs/00-开发目录结构.md)
- [概要设计](../docs/01-概要设计.md)
- [数据库设计](../docs/02-数据库设计.md)
- [接口设计](../docs/03-接口与状态机设计.md)
