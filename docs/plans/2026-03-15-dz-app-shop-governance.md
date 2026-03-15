# `frontend/dz-app-shop` 仓库治理执行单

## 目标

将 `frontend/dz-app-shop` 从当前主交付仓中剥离，避免后续开发、测试、review 与交付继续误扫该目录。

## 当前结论

- 截至 2026-03-15，仓内未检索到主 README、文档、脚本、构建配置、CI 配置对 `frontend/dz-app-shop` 的显式引用
- 当前唯一有效的小程序主工程为 `frontend/baihou-life-miniprogram`
- `frontend/dz-app-shop` 更接近遗留目录或历史副本，而非正在使用的交付工程

## 建议执行顺序

1. 复核运行依赖
   - 再次检查部署脚本、私有 CI、团队本地启动说明是否仍引用该目录
   - 向项目负责人确认该目录无需继续保留在主仓

2. 选择保留方式
   - 若无需继续保留：直接移出 Git 跟踪
   - 若需保留历史：迁移到 `archive/` 或外部备份仓

3. 执行移除
   - 将目录迁出主交付路径
   - 删除 Git 跟踪
   - 避免与业务功能修复合并到同一个提交

4. 同步文档
   - 根 README 明确唯一有效小程序工程
   - 开发目录结构文档明确 `dz-app-shop` 为遗留目录
   - 如有团队内部 Wiki，同步更新工程入口

5. 交付后检查
   - 再次全仓检索 `dz-app-shop`
   - 确认 review、测试、脚本说明不再包含该目录

## 建议命令

以下命令仅作为后续独立治理任务参考，本轮未执行：

```bash
rg -n "dz-app-shop|frontend/dz-app-shop" . --glob '!node_modules/**'
git rm -r frontend/dz-app-shop
```

若需先保留历史，可改为先迁移到归档目录后再提交。
