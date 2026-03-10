# Baihou Life Admin Bootstrap Notes

This workspace is the Baihou Life admin-system baseline built on top of two official RuoYi sources:

- Backend baseline: `RuoYi-Vue`
- Admin frontend baseline: `RuoYi-Vue3`

The directory layout is intentionally kept as:

```text
ruoyi-baihou-life/
├── ruoyi-admin
├── ruoyi-common
├── ruoyi-framework
├── ruoyi-generator
├── ruoyi-quartz
├── ruoyi-system
├── ruoyi-ui
└── ruoyi-ui-vue3
```

Notes:

- `ruoyi-ui` is preserved as the upstream Vue2 frontend reference from the backend repository.
- `ruoyi-ui-vue3` is the active admin frontend baseline for Baihou Life.
- Future Baihou business code should be added as a new backend module named `ruoyi-baihou`.

Current verification status:

- `ruoyi-ui-vue3` dependencies installed successfully after forcing `npm` to use `--script-shell=/bin/sh`.
- `ruoyi-ui-vue3` production build passed with `npm run build:prod`.
- Backend build has not run because the local machine currently has no Java runtime and no Maven installation.

Recommended next steps:

1. Install JDK 8 and Maven for the backend baseline.
2. Add `ruoyi-baihou` to the root Maven modules.
3. Scaffold Baihou admin controllers, services, mappers, enums, and resources under `com.ruoyi.baihou`.
4. Implement backend modules in this order: categories, regions, products, banners, designers, leads, appointments, orders.
