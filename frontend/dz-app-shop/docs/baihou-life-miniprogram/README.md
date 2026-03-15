# Baihou Life Miniprogram

微信原生小程序工程，按 `docs/07-小程序开发计划与实施方案.md` 实现。

## 目录

```text
baihou-life-miniprogram/
├── project.config.json
└── src/
    ├── app.js
    ├── app.json
    ├── app.wxss
    ├── components/
    ├── pages/
    ├── services/
    ├── store/
    ├── styles/
    └── utils/
```

## 说明

- 当前默认 `useMock = true`，方便在后端未联通时直接预览页面流程。
- 联调时将 `src/config/env.js` 中的 `useMock` 切为 `false`，并配置 `baseURL`。
