<template>
  <footer v-if="visible" class="copyright">
    <span>{{ content }}</span>
  </footer>
</template>

<script setup>
import useSettingsStore from '@/store/modules/settings'

const settingsStore = useSettingsStore()

const visible = computed(() => settingsStore.footerVisible)
const content = computed(() => settingsStore.footerContent)
</script>

<style scoped>
.copyright {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: 36px;
  padding: 10px 20px;
  text-align: right;
  background: rgba(255, 250, 245, 0.92);
  color: #6c655e;
  font-size: 13px;
  border-top: 1px solid rgba(221, 213, 204, 0.85);
  backdrop-filter: blur(12px);
  z-index: 999;
}
</style>
