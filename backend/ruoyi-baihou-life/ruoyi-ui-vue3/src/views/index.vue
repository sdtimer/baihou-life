<template>
  <div class="home">
    <section class="home-hero">
      <div class="home-hero__content">
        <div class="home-eyebrow">Baihou Life Admin</div>
        <h1>柏厚生活产品展示系统管理后台</h1>
        <p>
          面向商品展示、空间内容运营与交付协同的统一工作台，覆盖商品、品类、区域、设计师、线索、预约与订单等核心业务模块。
        </p>
        <div class="home-hero__actions">
          <el-button type="primary" @click="goFirstModule">进入业务模块</el-button>
          <el-button @click="router.push('/system/user')">查看账号与权限</el-button>
        </div>
      </div>
      <div class="home-hero__panel">
        <div class="home-kpi">
          <span class="home-kpi__label">已接入业务模块</span>
          <span class="home-kpi__value">{{ availableBusinessModules.length }}</span>
          <span class="home-kpi__hint">当前后台可直接访问的柏厚生活业务目录</span>
        </div>
        <div class="home-kpi">
          <span class="home-kpi__label">导航模式</span>
          <span class="home-kpi__value">{{ navTypeLabel }}</span>
          <span class="home-kpi__hint">支持左侧、混合与顶部布局切换</span>
        </div>
      </div>
    </section>

    <section class="home-section">
      <div class="home-section__head">
        <div>
          <h2>核心业务入口</h2>
          <p>围绕产品展示系统的一期核心模块，支持快速跳转到日常运营页面。</p>
        </div>
      </div>
      <div class="home-grid">
        <button
          v-for="module in availableBusinessModules"
          :key="module.path"
          class="home-card"
          type="button"
          @click="router.push(module.path)"
        >
          <div class="home-card__icon">
            <svg-icon :icon-class="module.icon" />
          </div>
          <div class="home-card__title">{{ module.title }}</div>
          <div class="home-card__desc">{{ module.description }}</div>
          <div class="home-card__meta">{{ module.meta }}</div>
        </button>
      </div>
    </section>

    <section class="home-section">
      <div class="home-section__head">
        <div>
          <h2>运营概览</h2>
          <p>本次首页不依赖新增统计接口，先聚合后台现有结构信息和工作台配置状态。</p>
        </div>
      </div>
      <div class="home-overview">
        <div v-for="item in overviewCards" :key="item.label" class="home-overview__card">
          <div class="home-overview__label">{{ item.label }}</div>
          <div class="home-overview__value">{{ item.value }}</div>
          <div class="home-overview__hint">{{ item.hint }}</div>
        </div>
      </div>
    </section>

    <section class="home-section">
      <div class="home-section__head">
        <div>
          <h2>后台使用原则</h2>
          <p>在保持现有后台能力与操作效率的同时，统一到柏厚生活品牌的暖中性视觉和更清晰的信息组织。</p>
        </div>
      </div>
      <div class="home-guides">
        <div v-for="guide in guides" :key="guide.title" class="home-guide">
          <div class="home-guide__title">{{ guide.title }}</div>
          <p>{{ guide.description }}</p>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import usePermissionStore from '@/store/modules/permission'
import useSettingsStore from '@/store/modules/settings'

const router = useRouter()
const permissionStore = usePermissionStore()
const settingsStore = useSettingsStore()

const businessModules = [
  { title: '商品管理', path: '/baihou/products', icon: 'shopping', meta: '上架、批量操作、详情维护', description: '管理商品资料、状态与展示内容。' },
  { title: '品类管理', path: '/baihou/categories', icon: 'tree-table', meta: '导航、层级、排序', description: '维护首页分类结构与商品归类体系。' },
  { title: '区域管理', path: '/baihou/regions', icon: 'guide', meta: '城市、坐标、启停', description: '配置服务区域与可售城市范围。' },
  { title: 'Banner 管理', path: '/baihou/banners', icon: 'build', meta: '推荐位与上下线', description: '运营首页推荐内容与展示节奏。' },
  { title: '设计师管理', path: '/baihou/designers', icon: 'peoples', meta: '账号、折扣、状态', description: '管理设计师资料与业务协同状态。' },
  { title: '设计师分组', path: '/baihou/designer-groups', icon: 'tree', meta: '分组与结构配置', description: '组织设计师团队结构与归属分组。' },
  { title: '线索管理', path: '/baihou/leads', icon: 'message', meta: '分配、跟进、导出', description: '查看留资线索并推进客户转化。' },
  { title: '预约管理', path: '/baihou/appointments', icon: 'date', meta: '预约状态流转', description: '处理上门预约与安排执行流程。' },
  { title: '订单管理', path: '/baihou/orders', icon: 'money', meta: '履约与订单状态', description: '查看订单详情、交付状态和处理动作。' }
]

const guides = [
  { title: '统一品牌语气', description: '登录页、首页、业务页与系统页保持一致的柏厚生活品牌感，避免后台与业务内容割裂。' },
  { title: '运营效率优先', description: '保留筛选、批量操作、弹窗编辑与权限体系，不为了视觉表达牺牲管理效率。' },
  { title: '状态信息清晰', description: '通过卡片、标签、表头和焦点态统一语义，让商品、线索、预约、订单处理更可读。' },
  { title: '渐进式扩展', description: '首页先提供轻量概览与快捷入口，后续若需要 BI 看板，可在不破坏视觉体系的前提下继续演进。' }
]

function collectPaths(routes, prefix = '') {
  return routes.flatMap((route) => {
    const currentPath = route.path?.startsWith('/') ? route.path : `${prefix}/${route.path || ''}`.replace(/\/+/g, '/')
    const children = route.children ? collectPaths(route.children, currentPath) : []
    return [currentPath, ...children]
  })
}

const availablePaths = computed(() => new Set(collectPaths(permissionStore.sidebarRouters)))

const availableBusinessModules = computed(() =>
  businessModules.filter((module) => availablePaths.value.has(module.path))
)

const navTypeLabel = computed(() => {
  if (settingsStore.navType === 2) return '混合导航'
  if (settingsStore.navType === 3) return '顶部导航'
  return '左侧导航'
})

const overviewCards = computed(() => [
  {
    label: '业务覆盖',
    value: `${availableBusinessModules.value.length} 个模块`,
    hint: '商品、流量、线索和履约链路已接入后台'
  },
  {
    label: '页签模式',
    value: settingsStore.tagsView ? '已开启' : '已关闭',
    hint: '支持多页面并行处理和频繁切换'
  },
  {
    label: '品牌主题',
    value: settingsStore.theme,
    hint: '主色已统一到柏厚生活暖棕品牌色'
  },
  {
    label: '系统定位',
    value: '产品展示管理',
    hint: '聚焦展示内容运营与转化交付，不涉及小程序前台改动'
  }
])

function goFirstModule() {
  const [first] = availableBusinessModules.value
  router.push(first?.path || '/baihou/products')
}
</script>

<style lang="scss" scoped>
.home {
  display: flex;
  flex-direction: column;
  gap: 18px;
  padding: 24px;
  min-height: calc(100vh - 84px);
}

.home-hero,
.home-section {
  position: relative;
  overflow: hidden;
  border: 1px solid rgba(189, 175, 159, 0.42);
  border-radius: 24px;
  background: rgba(255, 255, 255, 0.88);
  box-shadow: 0 18px 44px rgba(47, 42, 38, 0.06);
}

.home-hero {
  display: grid;
  grid-template-columns: minmax(0, 1.5fr) minmax(300px, 0.9fr);
  gap: 18px;
  padding: 28px;
  background:
    radial-gradient(circle at top right, rgba(125, 138, 99, 0.18), transparent 28%),
    linear-gradient(135deg, rgba(255, 255, 255, 0.96), rgba(243, 238, 232, 0.94));
}

.home-eyebrow {
  margin-bottom: 12px;
  color: #7d8a63;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.18em;
  text-transform: uppercase;
}

.home-hero h1 {
  margin: 0;
  max-width: 720px;
  color: #2f2a26;
  font-size: 36px;
  line-height: 1.18;
}

.home-hero p {
  max-width: 680px;
  margin: 16px 0 0;
  color: #6c655e;
  font-size: 15px;
  line-height: 1.8;
}

.home-hero__actions {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-top: 24px;
}

.home-hero__panel {
  display: grid;
  gap: 14px;
}

.home-kpi {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 20px 22px;
  min-height: 160px;
  border-radius: 20px;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.98), rgba(247, 244, 239, 0.92));
  border: 1px solid rgba(189, 175, 159, 0.42);
}

.home-kpi__label {
  color: #6c655e;
  font-size: 12px;
}

.home-kpi__value {
  margin-top: 14px;
  color: #2f2a26;
  font-size: 30px;
  font-weight: 600;
}

.home-kpi__hint {
  margin-top: 12px;
  color: #9b938b;
  font-size: 12px;
  line-height: 1.7;
}

.home-section {
  padding: 24px;
}

.home-section__head {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 18px;
}

.home-section__head h2 {
  margin: 0;
  color: #2f2a26;
  font-size: 22px;
}

.home-section__head p {
  margin: 8px 0 0;
  color: #6c655e;
  font-size: 14px;
}

.home-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 14px;
}

.home-card {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  min-height: 190px;
  padding: 18px;
  border: 1px solid rgba(189, 175, 159, 0.35);
  border-radius: 18px;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.98), rgba(249, 246, 241, 0.96));
  text-align: left;
  cursor: pointer;
  transition: transform 0.22s ease, box-shadow 0.22s ease, border-color 0.22s ease;
}

.home-card:hover,
.home-card:focus-visible {
  transform: translateY(-2px);
  border-color: rgba(111, 90, 69, 0.4);
  box-shadow: 0 18px 32px rgba(47, 42, 38, 0.08);
  outline: none;
}

.home-card__icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 42px;
  height: 42px;
  border-radius: 14px;
  background: rgba(243, 238, 232, 0.96);
  color: #6f5a45;
}

.home-card__title {
  margin-top: 18px;
  color: #2f2a26;
  font-size: 17px;
  font-weight: 600;
}

.home-card__desc {
  margin-top: 10px;
  color: #6c655e;
  font-size: 13px;
  line-height: 1.7;
}

.home-card__meta {
  margin-top: auto;
  padding-top: 16px;
  color: #9b938b;
  font-size: 12px;
}

.home-overview {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 14px;
}

.home-overview__card,
.home-guide {
  padding: 18px;
  border: 1px solid rgba(189, 175, 159, 0.3);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.94);
}

.home-overview__label {
  color: #6c655e;
  font-size: 12px;
}

.home-overview__value {
  margin-top: 12px;
  color: #2f2a26;
  font-size: 24px;
  font-weight: 600;
}

.home-overview__hint {
  margin-top: 10px;
  color: #9b938b;
  font-size: 12px;
  line-height: 1.7;
}

.home-guides {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 14px;
}

.home-guide__title {
  color: #2f2a26;
  font-size: 16px;
  font-weight: 600;
}

.home-guide p {
  margin: 10px 0 0;
  color: #6c655e;
  font-size: 13px;
  line-height: 1.8;
}

@media (max-width: 1024px) {
  .home {
    padding: 16px;
  }

  .home-hero {
    grid-template-columns: 1fr;
    padding: 22px;
  }

  .home-hero h1 {
    font-size: 28px;
  }
}

@media (max-width: 768px) {
  .home-section {
    padding: 18px;
  }

  .home-hero__actions {
    flex-direction: column;
  }

  .home-hero__actions :deep(.el-button) {
    width: 100%;
    margin-left: 0;
  }
}
</style>
