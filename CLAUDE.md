# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

柏厚生活 (Baihou Life) — Phase 1 monorepo. Covers a WeChat miniprogram (customer-facing) and a RuoYi-based admin system (operations).

## Naming Conventions

| Context | Convention | Example |
|---------|-----------|---------|
| Brand display | `Baihou Life` | docs, UI copy |
| Directories / repos | `baihou-life` | `baihou-life-miniprogram` |
| Java module / package | `baihou` | `com.ruoyi.baihou` |
| DB table prefix | `bh_` | `bh_product` |
| Admin permissions | `baihou:*` | `baihou:product:list` |

## Repository Structure

```
生活产品展示/
├── docs/                              # Design, DB, API, test docs
├── frontend/baihou-life-miniprogram/  # WeChat native miniprogram
└── backend/ruoyi-baihou-life/         # RuoYi-based backend + Vue3 admin
```

## Frontend — WeChat Miniprogram

**Location:** `frontend/baihou-life-miniprogram/`
**Runtime:** WeChat DevTools (open `project.config.json`)

### Key directories

- `src/config/env.js` — toggle `useMock` and set `baseURL`
- `src/services/` — one file per domain (product, order, appointment, etc.)
- `src/pages/` — page modules: home, product, designer, auth, lead, appointment, order, profile
- `src/store/` — global state
- `src/utils/` — shared utilities

### Mock vs real backend

`src/config/env.js` defaults to `useMock: true`. To connect to a real backend, set `useMock: false` and update `baseURL`.

## Backend — RuoYi Admin System

**Location:** `backend/ruoyi-baihou-life/`
**Stack:** Java 8, Maven, Spring Boot, Spring Security + JWT, MyBatis, MySQL, Redis, Quartz

### Key modules

| Module | Purpose |
|--------|---------|
| `ruoyi-admin` | Boot entry point, test suite |
| `ruoyi-baihou` | All Baihou business logic |
| `ruoyi-ui-vue3` | Active Vue3 admin frontend |
| `ruoyi-ui` | Vue2 upstream reference (do not modify) |
| `sql/baihou/` | Schema and menu SQL scripts |

### Business code layout (inside `ruoyi-baihou`)

```
src/main/java/com/ruoyi/baihou/
├── controller/admin   # REST controllers with @PreAuthorize
├── domain             # Entities
├── dto                # Request/response DTOs
├── mapper             # MyBatis mappers
├── service / impl     # Service interfaces + implementations
└── job                # Quartz scheduled jobs
```

### Admin frontend views

Vue3 pages live under `ruoyi-ui-vue3/src/views/baihou/`. Button permissions use `v-hasPermi`.

## Commands

### Backend

```bash
# Build and run
mvn clean package
mvn -pl ruoyi-admin -am spring-boot:run

# Run Baihou tests (100 tests)
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' \
  -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false \
  -pl ruoyi-admin -am \
  -Dtest=BaihouAdminPermissionAnnotationTest,BaihouOrderJobTest,BaihouOrderControllerTest,BaihouOrderServiceImplTest,BaihouAppointmentControllerTest,BaihouAppointmentServiceImplTest,BaihouLeadControllerTest,BaihouLeadServiceImplTest,BaihouDesignerControllerTest,BaihouDesignerGroupControllerTest,BaihouDesignerServiceImplTest,BaihouDesignerGroupServiceImplTest,BaihouProductControllerTest,BaihouProductServiceImplTest,BaihouBannerControllerTest,BaihouBannerServiceImplTest,BaihouAdminControllerTest,BaihouServiceImplTest,BaihouModuleIntegrationTest,BaihouModuleStructureTest test
```

### Admin Vue3 frontend

```bash
cd backend/ruoyi-baihou-life/ruoyi-ui-vue3
npm install
npm run dev          # local dev
npm run build:prod   # production build
```

## Database Initialization

Run scripts in order from `backend/ruoyi-baihou-life/sql/baihou/`:

1. Standard RuoYi base schema
2. `01_b2_b3_schema.sql` through `07_b8_order_schema.sql`
3. `08_admin_menu_init.sql` — menus and permissions

## Phase 1 Modules

| ID | Name | Backend status | Frontend status |
|----|------|---------------|-----------------|
| B1 | Product Management | Done | Done |
| B2 | Category Tree | Done | Done |
| B3 | Region Management | Done | Done |
| B4 | Designer Accounts | Done | Done |
| B5 | Lead Management | Done | Done |
| B6 | Homepage Banners | Done | Done |
| B7 | Appointment Management | Done | Done |
| B8 | Order Management | Done | Done |

## Next Steps

1. Initialize DB and import menu SQL
2. Set miniprogram `useMock: false` and point to backend
3. Validate dynamic menus, button permissions, 403 handling, and state transitions
4. Full-chain testing: login → browse → lead → appointment → order
