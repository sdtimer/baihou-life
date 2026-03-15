<template>
  <div class="login">
    <div class="login-shell">
      <section class="login-brand">
        <div class="login-brand__badge">Baihou Life</div>
        <div class="login-brand__mark" aria-hidden="true">BH</div>
        <h1>{{ title }}</h1>
        <p class="login-brand__desc">
          面向柏厚生活产品展示、空间内容运营与交付协同的统一后台入口，帮助团队高效完成商品配置、线索转化与订单履约管理。
        </p>
        <div class="login-brand__tips">
          <div class="login-brand__tip">
            <span class="login-brand__tip-title">统一品牌体验</span>
            <span class="login-brand__tip-text">暖中性配色、清晰卡片和高可读表单，保持后台专业感与生活方式气质。</span>
          </div>
          <div class="login-brand__tip">
            <span class="login-brand__tip-title">运营效率优先</span>
            <span class="login-brand__tip-text">保留现有权限、表格、搜索和批量处理能力，不改变现有登录流程。</span>
          </div>
        </div>
      </section>

      <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form">
        <div class="login-form__header">
          <div class="login-form__eyebrow">管理后台登录</div>
          <h3 class="title">欢迎回来</h3>
          <p>使用后台账号登录柏厚生活产品展示系统管理后台。</p>
        </div>
        <el-form-item prop="username">
          <el-input
            v-model="loginForm.username"
            type="text"
            size="large"
            auto-complete="off"
            placeholder="账号"
          >
            <template #prefix><svg-icon icon-class="user" class="el-input__icon input-icon" /></template>
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            size="large"
            auto-complete="off"
            placeholder="密码"
            @keyup.enter="handleLogin"
          >
            <template #prefix><svg-icon icon-class="password" class="el-input__icon input-icon" /></template>
          </el-input>
        </el-form-item>
        <el-form-item prop="code" v-if="captchaEnabled">
          <div class="login-code-row">
            <el-input
              v-model="loginForm.code"
              size="large"
              auto-complete="off"
              placeholder="验证码"
              @keyup.enter="handleLogin"
            >
              <template #prefix><svg-icon icon-class="validCode" class="el-input__icon input-icon" /></template>
            </el-input>
            <button type="button" class="login-code" @click="getCode">
              <img :src="codeUrl" @click.stop="getCode" class="login-code-img" alt="验证码"/>
            </button>
          </div>
        </el-form-item>
        <div class="login-form__options">
          <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
          <router-link v-if="register" class="link-type" :to="'/register'">立即注册</router-link>
        </div>
        <el-form-item class="login-form__submit">
          <el-button
            :loading="loading"
            size="large"
            type="primary"
            @click.prevent="handleLogin"
          >
            <span v-if="!loading">登 录</span>
            <span v-else>登 录 中...</span>
          </el-button>
        </el-form-item>
      </el-form>
    </div>
    <!--  底部  -->
    <div class="el-login-footer">
      <span>{{ footerContent }}</span>
    </div>
  </div>
</template>

<script setup>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from "@/utils/jsencrypt"
import useUserStore from '@/store/modules/user'
import defaultSettings from '@/settings'

const title = import.meta.env.VITE_APP_TITLE
const footerContent = defaultSettings.footerContent
const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()

const loginForm = ref({
  username: "admin",
  password: "admin123",
  rememberMe: false,
  code: "",
  uuid: ""
})

const loginRules = {
  username: [{ required: true, trigger: "blur", message: "请输入您的账号" }],
  password: [{ required: true, trigger: "blur", message: "请输入您的密码" }],
  code: [{ required: true, trigger: "change", message: "请输入验证码" }]
}

const codeUrl = ref("")
const loading = ref(false)
// 验证码开关
const captchaEnabled = ref(true)
// 注册开关
const register = ref(false)
const redirect = ref(undefined)

watch(route, (newRoute) => {
    redirect.value = newRoute.query && newRoute.query.redirect
}, { immediate: true })

function handleLogin() {
  proxy.$refs.loginRef.validate(valid => {
    if (valid) {
      loading.value = true
      // 勾选了需要记住密码设置在 cookie 中设置记住用户名和密码
      if (loginForm.value.rememberMe) {
        Cookies.set("username", loginForm.value.username, { expires: 30 })
        Cookies.set("password", encrypt(loginForm.value.password), { expires: 30 })
        Cookies.set("rememberMe", loginForm.value.rememberMe, { expires: 30 })
      } else {
        // 否则移除
        Cookies.remove("username")
        Cookies.remove("password")
        Cookies.remove("rememberMe")
      }
      // 调用action的登录方法
      userStore.login(loginForm.value).then(() => {
        const query = route.query
        const otherQueryParams = Object.keys(query).reduce((acc, cur) => {
          if (cur !== "redirect") {
            acc[cur] = query[cur]
          }
          return acc
        }, {})
        router.push({ path: redirect.value || "/", query: otherQueryParams })
      }).catch(() => {
        loading.value = false
        // 重新获取验证码
        if (captchaEnabled.value) {
          getCode()
        }
      })
    }
  })
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    if (captchaEnabled.value) {
      codeUrl.value = "data:image/gif;base64," + res.img
      loginForm.value.uuid = res.uuid
    }
  })
}

function getCookie() {
  const username = Cookies.get("username")
  const password = Cookies.get("password")
  const rememberMe = Cookies.get("rememberMe")
  loginForm.value = {
    username: username === undefined ? loginForm.value.username : username,
    password: password === undefined ? loginForm.value.password : decrypt(password),
    rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
  }
}

getCode()
getCookie()
</script>

<style lang='scss' scoped>
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100%;
  padding: 32px 20px 72px;
  background:
    radial-gradient(circle at top left, rgba(125, 138, 99, 0.18), transparent 22%),
    radial-gradient(circle at right center, rgba(111, 90, 69, 0.12), transparent 22%),
    linear-gradient(135deg, rgba(250, 247, 242, 0.98), rgba(243, 238, 232, 0.94)),
    url("../assets/images/login-background.jpg") center/cover;
}

.login-shell {
  display: grid;
  grid-template-columns: minmax(0, 1.1fr) minmax(360px, 420px);
  gap: 24px;
  width: min(1120px, 100%);
}

.login-brand,
.login-form {
  position: relative;
  overflow: hidden;
  border: 1px solid rgba(189, 175, 159, 0.4);
  border-radius: 28px;
  background: rgba(255, 255, 255, 0.8);
  box-shadow: 0 24px 48px rgba(47, 42, 38, 0.09);
  backdrop-filter: blur(14px);
}

.login-brand {
  padding: 36px;
  background:
    radial-gradient(circle at top right, rgba(125, 138, 99, 0.18), transparent 28%),
    linear-gradient(145deg, rgba(255, 255, 255, 0.94), rgba(243, 238, 232, 0.92));
}

.login-brand__badge {
  display: inline-flex;
  padding: 7px 12px;
  border-radius: 999px;
  background: rgba(238, 241, 232, 0.9);
  color: #7d8a63;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.16em;
  text-transform: uppercase;
}

.login-brand__mark {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 74px;
  height: 74px;
  margin-top: 28px;
  border-radius: 24px;
  background: linear-gradient(135deg, #8e745c, #6f5a45);
  color: #fffaf5;
  font-size: 24px;
  font-weight: 700;
  letter-spacing: 0.08em;
  box-shadow: 0 18px 38px rgba(47, 42, 38, 0.16);
}

.login-brand h1 {
  margin: 24px 0 0;
  color: #2f2a26;
  font-size: 36px;
  line-height: 1.2;
}

.login-brand__desc {
  max-width: 580px;
  margin: 18px 0 0;
  color: #6c655e;
  font-size: 15px;
  line-height: 1.9;
}

.login-brand__tips {
  display: grid;
  gap: 14px;
  margin-top: 28px;
}

.login-brand__tip {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 18px 18px 20px;
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.72);
  border: 1px solid rgba(221, 213, 204, 0.72);
}

.login-brand__tip-title {
  color: #2f2a26;
  font-size: 15px;
  font-weight: 600;
}

.login-brand__tip-text {
  color: #6c655e;
  font-size: 13px;
  line-height: 1.8;
}

.login-form {
  width: 100%;
  padding: 30px 28px 22px;
  z-index: 1;

  &__header {
    margin-bottom: 22px;
  }

  &__eyebrow {
    color: #7d8a63;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.14em;
    text-transform: uppercase;
  }

  &__options {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    margin: 2px 0 24px;
    color: #6c655e;
  }

  &__submit {
    margin-bottom: 0;
  }

  &__submit :deep(.el-form-item__content),
  &__submit .el-button {
    width: 100%;
  }

  .el-input {
    height: 48px;
    input {
      height: 48px;
    }
  }
  .input-icon {
    height: 47px;
    width: 14px;
    margin-left: 0px;
  }
}

.title {
  margin: 10px 0 0;
  color: #2f2a26;
  font-size: 28px;
}

.login-form p {
  margin: 10px 0 0;
  color: #6c655e;
  font-size: 13px;
  line-height: 1.8;
}

.login-code-row {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 120px;
  gap: 12px;
  width: 100%;
}

.login-code {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 48px;
  padding: 0;
  border: 1px solid rgba(221, 213, 204, 0.92);
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.95);
  cursor: pointer;
  img {
    display: block;
    width: 100%;
    height: 100%;
    border-radius: 13px;
  }
}

.el-login-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #6c655e;
  font-family: inherit;
  font-size: 12px;
  letter-spacing: 1px;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0), rgba(250, 247, 242, 0.92));
}
.login-code-img {
  height: 48px;
}

@media (max-width: 960px) {
  .login {
    align-items: flex-start;
  }

  .login-shell {
    grid-template-columns: 1fr;
    max-width: 560px;
  }

  .login-brand {
    padding: 28px 24px;
  }

  .login-brand h1 {
    font-size: 28px;
  }
}

@media (max-width: 640px) {
  .login {
    padding: 16px 16px 72px;
  }

  .login-brand,
  .login-form {
    border-radius: 22px;
  }

  .login-form {
    padding: 24px 18px 18px;
  }

  .login-code-row {
    grid-template-columns: 1fr;
  }
}
</style>
