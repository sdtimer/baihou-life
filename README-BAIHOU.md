# Baihou Life Admin System

中文版: [README.md](./README.md)

## Overview

This repository contains the Phase 1 admin system for `Baihou Life`, built on top of the RuoYi separated frontend/backend stack:

- Backend baseline: `RuoYi-Vue`
- Admin frontend baseline: `RuoYi-Vue3`
- Business module: `ruoyi-baihou`
- Java package: `com.ruoyi.baihou`
- Admin route prefix: `/admin/`
- Table prefix: `bh_`

The repository already includes the integrated baseline, Baihou business modules, Vue3 admin pages, menu SQL, and automated tests for the first delivery phase.

## Phase 1 Scope

Phase 1 covers the following 8 admin modules:

- `B1` Product Management
- `B2` Category Tree Management
- `B3` Region Management
- `B4` Designer Account Management
- `B5` Lead Management
- `B6` Homepage Banner Management
- `B7` Appointment Management
- `B8` Order Management

## Repository Layout

```text
ruoyi-baihou-life/
├── ruoyi-admin/
├── ruoyi-common/
├── ruoyi-framework/
├── ruoyi-generator/
├── ruoyi-quartz/
├── ruoyi-system/
├── ruoyi-ui/                    # preserved Vue2 upstream reference
├── ruoyi-ui-vue3/               # active Baihou admin frontend
├── ruoyi-baihou/                # Baihou business module
└── sql/baihou/                  # Baihou schema and menu scripts
```

Business code inside `ruoyi-baihou` is organized under:

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

## Tech Stack

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

## Implemented Modules

### Backend

- Categories and regions: list, detail, create, update, enable/disable
- Products: filtered list, detail, create, update, soft delete, batch status updates, on-shelf validation
- Banners: list, create, update, delete
- Designers and designer groups: list, create, update, enable/disable
- Leads: list, update, export
- Appointments: list and state transitions
- Orders: list, detail, state transitions, scheduled jobs

### Frontend

The Vue3 admin frontend already includes these Baihou pages under `ruoyi-ui-vue3/src/views/baihou`:

- Products
- Categories
- Regions
- Banners
- Designers
- Designer Groups
- Leads
- Appointments
- Orders

The UI follows the Baihou design-system direction: warm neutral colors, light cards, and high-readability data tables. Button-level permissions are aligned with backend permission codes.

## Database Scripts

Business SQL scripts are located in `sql/baihou/`:

- `01_b2_b3_schema.sql`
- `02_b1_product_schema.sql`
- `03_b6_banner_schema.sql`
- `04_b4_designer_schema.sql`
- `05_b5_lead_schema.sql`
- `06_b7_appointment_schema.sql`
- `07_b8_order_schema.sql`
- `08_admin_menu_init.sql`

Recommended setup order:

1. Import the standard RuoYi database schema
2. Run Baihou business scripts `01-07`
3. Run `08_admin_menu_init.sql` to initialize menus and permissions

## Local Development

### Start the backend

```bash
mvn clean package
mvn -pl ruoyi-admin -am spring-boot:run
```

### Start the Vue3 admin frontend

```bash
cd ruoyi-ui-vue3
npm install
npm run dev
```

Production build:

```bash
cd ruoyi-ui-vue3
npm run build:prod
```

## Permissions

Baihou admin permissions follow the `baihou:*` convention, for example:

- `baihou:product:list`
- `baihou:product:add`
- `baihou:product:edit`
- `baihou:lead:export`
- `baihou:order:edit`

The backend controllers already use `@PreAuthorize`, and the Vue3 pages use `v-hasPermi` for button-level control.

## Verification Status

The current baseline has already passed:

- Frontend production build: `npm run build:prod`
- Backend Baihou regression suite: `100` passing tests

Example backend verification command:

```bash
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
mvn -s '../maven-central-settings.xml' \
  -Dmaven.repo.local='../.m2/repository' \
  -Dsurefire.failIfNoSpecifiedTests=false \
  -pl ruoyi-admin -am \
  -Dtest=BaihouAdminPermissionAnnotationTest,BaihouOrderJobTest,BaihouOrderControllerTest,BaihouOrderServiceImplTest,BaihouAppointmentControllerTest,BaihouAppointmentServiceImplTest,BaihouLeadControllerTest,BaihouLeadServiceImplTest,BaihouDesignerControllerTest,BaihouDesignerGroupControllerTest,BaihouDesignerServiceImplTest,BaihouDesignerGroupServiceImplTest,BaihouProductControllerTest,BaihouProductServiceImplTest,BaihouBannerControllerTest,BaihouBannerServiceImplTest,BaihouAdminControllerTest,BaihouServiceImplTest,BaihouModuleIntegrationTest,BaihouModuleStructureTest test
```

## Next Steps

The repository is ready for environment integration. Recommended next steps:

1. Initialize the database and import the Baihou menu SQL
2. Run backend and frontend together for live integration
3. Verify dynamic menus, button permissions, 403 behavior, and state transitions
4. Prepare staging environment configuration and seed data

## Naming Conventions

- Chinese brand name: 柏厚生活
- English brand name: `Baihou Life`
- Business module: `ruoyi-baihou`
- Java package: `com.ruoyi.baihou`
- Repository directory: `ruoyi-baihou-life`
