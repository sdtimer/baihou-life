# Windsurf 开发环境配置

## 概述
本目录包含了 Baihou Life 项目的 Windsurf 开发环境配置文件。

## 配置文件说明

### 📁 核心配置
- `project.md` - 项目概述和快速开始指南
- `settings.json` - 编辑器设置和配置
- `extensions.json` - 推荐扩展列表

### 🚀 运行配置
- `tasks.json` - 构建和启动任务
- `launch.json` - 调试配置

### 🔧 其他
- `.gitignore` - 忽略文件配置

## 快速开始

### 1. 安装推荐扩展
打开 Windsurf 后，会自动提示安装 `extensions.json` 中推荐的扩展。

### 2. 构建后端项目
按 `Cmd+Shift+P` 打开命令面板，运行：
```
Tasks: Run Task
```
选择 "构建后端项目"

### 3. 启动后端服务
构建完成后，运行任务：
```
启动后端服务
```

### 4. 启动Vue3管理端（可选）
```
启动Vue3管理端
```

## 项目结构导航

- 📱 **小程序**: `frontend/baihou-life-miniprogram/`
  - 使用微信开发者工具打开
  - 默认使用 mock 数据

- 🖥️ **后端**: `backend/ruoyi-baihou-life/`
  - Spring Boot + 若依框架
  - 主启动类: `com.ruoyi.RuoYiApplication`

- 🎨 **管理端**: `backend/ruoyi-baihou-life/ruoyi-ui-vue3/`
  - Vue3 后台管理系统

## 常用命令

### Maven 命令
```bash
# 构建项目
mvn clean install -DskipTests

# 启动后端
mvn spring-boot:run
```

### 小程序开发
1. 用微信开发者工具打开 `frontend/baihou-life-miniprogram`
2. 修改 `src/config/env.js` 切换 mock/真实数据

## 文档链接
详细项目文档请查看根目录 `docs/` 文件夹：
- [开发目录结构](../../docs/00-开发目录结构.md)
- [概要设计](../../docs/01-概要设计.md)
- [接口设计](../../docs/03-接口与状态机设计.md)
