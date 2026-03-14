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

- 当前工程支持两种运行口径：
- `useMock = true`：直接走本地 mock 数据，方便页面联调和视觉预览。
- `useMock = false`：走本地后端联调，当前仓库默认采用这一模式。
- 登录采用“测试态登录”：前端调用 `wx.login()`，后端按测试映射返回 token 和角色，不接真实 `code2session`。
- 支付采用“测试态模拟支付”：前端先调用预支付接口，再通过模拟支付适配层覆盖成功、取消、失败三条路径，不接真实微信商户支付。
- 联调前请确认 `src/config/env.js` 中的 `baseURL` 指向本地后端，并保证后端已启动 miniapp 接口。
