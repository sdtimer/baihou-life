<template>
  <div class="sidebar-logo-container" :class="{ 'collapse': collapse }">
    <transition name="sidebarLogoFade">
      <router-link v-if="collapse" key="collapse" class="sidebar-logo-link" to="/">
        <span class="sidebar-mark" aria-hidden="true">BH</span>
      </router-link>
      <router-link v-else key="expand" class="sidebar-logo-link" to="/">
        <span class="sidebar-mark" aria-hidden="true">BH</span>
        <div class="sidebar-brand">
          <div class="sidebar-title">{{ shortTitle }}</div>
          <div class="sidebar-subtitle">{{ subtitle }}</div>
        </div>
      </router-link>
    </transition>
  </div>
</template>

<script setup>
import useSettingsStore from '@/store/modules/settings'
import variables from '@/assets/styles/variables.module.scss'

defineProps({
  collapse: {
    type: Boolean,
    required: true
  }
})

const shortTitle = '柏厚生活'
const subtitle = '产品展示管理后台'
const settingsStore = useSettingsStore()
const sideTheme = computed(() => settingsStore.sideTheme)

// 获取Logo背景色
const getLogoBackground = computed(() => {
  if (settingsStore.isDark) {
    return 'var(--sidebar-bg)'
  }
  if (settingsStore.navType == 3) {
    return variables.menuLightBg
  }
  return sideTheme.value === 'theme-dark' ? variables.menuBg : variables.menuLightBg
})

// 获取Logo文字颜色
const getLogoTextColor = computed(() => {
  if (settingsStore.isDark) {
    return 'var(--sidebar-text)'
  }
  if (settingsStore.navType == 3) {
    return variables.menuLightText
  }
  return sideTheme.value === 'theme-dark' ? '#fff' : variables.menuLightText
})
</script>

<style lang="scss" scoped>
.sidebarLogoFade-enter-active {
  transition: opacity 1.5s;
}

.sidebarLogoFade-enter,
.sidebarLogoFade-leave-to {
  opacity: 0;
}

.sidebar-logo-container {
  position: relative;
  height: 50px;
  line-height: 50px;
  background: v-bind(getLogoBackground);
  text-align: center;
  overflow: hidden;

  & .sidebar-logo-link {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    height: 100%;
    width: 100%;

    & .sidebar-mark {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 32px;
      height: 32px;
      border-radius: 12px;
      border: 1px solid rgba(255, 255, 255, 0.18);
      background:
        linear-gradient(135deg, rgba(255, 255, 255, 0.18), rgba(255, 255, 255, 0.04)),
        linear-gradient(135deg, #8e745c, #6f5a45);
      color: #fdf8f2;
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 0.08em;
      box-shadow: 0 8px 20px rgba(47, 42, 38, 0.2);
      flex-shrink: 0;
    }

    & .sidebar-brand {
      display: flex;
      min-width: 0;
      flex-direction: column;
      align-items: flex-start;
      justify-content: center;
      line-height: 1.1;
    }

    & .sidebar-title {
      margin: 0;
      color: v-bind(getLogoTextColor);
      font-weight: 600;
      font-size: 14px;
      letter-spacing: 0.04em;
    }

    & .sidebar-subtitle {
      margin-top: 2px;
      color: rgba(231, 221, 210, 0.72);
      font-size: 11px;
      letter-spacing: 0.08em;
      white-space: nowrap;
    }
  }

  &.collapse {
    .sidebar-logo-link {
      gap: 0;
    }

    .sidebar-brand {
      display: none;
    }
  }
}
</style>
