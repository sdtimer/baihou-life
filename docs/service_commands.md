# 服务启动与管理命令

本文档记录了柏厚生活项目后端服务及管理端的启动和管理命令。

## 1. 后端服务 (Spring Boot)

**目录**: `backend/ruoyi-baihou-life/`

### 启动命令
使用本地 Maven 仓库和自定义设置文件启动：
```bash
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' -pl ruoyi-admin spring-boot:run
```

### 编译/安装命令
如果需要重新编译或安装模块：
```bash
mvn -s '../maven-central-settings.xml' -Dmaven.repo.local='../.m2/repository' install -DskipTests
```

### 验证
- 后端 API 地址: `http://localhost:8080`
- 出现 `(♥◠‿◠)ﾉﾞ 若依启动成功 ლ(´ڡ`ლ)ﾞ` 表示启动成功。

---

## 2. 管理端前端 (Vue3 + Vite)

**目录**: `backend/ruoyi-baihou-life/ruoyi-ui-vue3/`

### 启动命令
```bash
npm run dev
```

### 验证
- 访问地址: [http://localhost:80](http://localhost:80)

---

## 3. 环境要求
- **Java**: OpenJDK 17
- **Node.js**: 建议 Lts 版本
- **数据库**: MySQL 8.0+ (需处于运行状态)
- **缓存**: Redis (需处于运行状态)

---

## 4. 停止服务
在终端中使用 `Ctrl+C` 终止进程即可。
