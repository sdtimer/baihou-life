<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Banner</div>
        <h1 class="baihou-hero__title">Banner 管理</h1>
        <p class="baihou-hero__desc">维护首页推荐位、区域投放和上下线时间窗口，确保小程序首页氛围和运营节奏一致。</p>
      </section>

      <section class="baihou-panel baihou-table">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">Banner 列表</div>
            <div class="baihou-panel__desc">支持图像地址、跳转类型、区域和排序维护</div>
          </div>
          <div class="baihou-toolbar">
            <el-button type="primary" @click="handleAdd" v-hasPermi="['baihou:banner:add']">新增 Banner</el-button>
            <el-button @click="getList">刷新</el-button>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="bannerList">
            <el-table-column prop="title" label="标题" min-width="160" />
            <el-table-column label="图片地址" min-width="220" show-overflow-tooltip>
              <template #default="scope">
                <span class="baihou-code">{{ scope.row.imageUrl || "--" }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="linkType" label="跳转类型" width="120" />
            <el-table-column prop="regions" label="区域" min-width="160" show-overflow-tooltip />
            <el-table-column prop="sortOrder" label="排序" width="100" />
            <el-table-column label="状态" width="120">
              <template #default="scope">
                <span class="baihou-chip" :class="scope.row.isActive === 1 ? 'is-soft-green' : 'is-danger'">
                  {{ scope.row.isActive === 1 ? "启用" : "停用" }}
                </span>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="160">
              <template #default="scope">
                <el-button link type="primary" @click="handleEdit(scope.row)" v-hasPermi="['baihou:banner:edit']">编辑</el-button>
                <el-button link type="danger" @click="handleDelete(scope.row)" v-hasPermi="['baihou:banner:remove']">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <el-dialog v-model="open" :title="title" width="680px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
        <div class="baihou-form-grid">
          <el-form-item label="标题" prop="title">
            <el-input v-model="form.title" />
          </el-form-item>
          <el-form-item label="图片地址" prop="imageUrl">
            <el-input v-model="form.imageUrl" />
          </el-form-item>
          <el-form-item label="跳转类型">
            <el-input v-model="form.linkType" placeholder="product / page" />
          </el-form-item>
          <el-form-item label="跳转值">
            <el-input v-model="form.linkValue" />
          </el-form-item>
          <el-form-item label="投放区域">
            <el-input v-model="form.regions" placeholder='如 ["foshan"]' />
          </el-form-item>
          <el-form-item label="排序">
            <el-input-number v-model="form.sortOrder" :min="0" :controls="false" style="width: 100%" />
          </el-form-item>
          <el-form-item label="开始时间">
            <el-date-picker v-model="form.startTime" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
          </el-form-item>
          <el-form-item label="结束时间">
            <el-date-picker v-model="form.endTime" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
          </el-form-item>
          <el-form-item label="状态">
            <el-radio-group v-model="form.isActive">
              <el-radio :value="1">启用</el-radio>
              <el-radio :value="0">停用</el-radio>
            </el-radio-group>
          </el-form-item>
        </div>
      </el-form>
      <template #footer>
        <el-button @click="open = false">取消</el-button>
        <el-button type="primary" @click="submitForm">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="BaihouBanners">
import { addBanner, listBanners, removeBanner, updateBanner } from "@/api/baihou/banners"

const { proxy } = getCurrentInstance()

const loading = ref(false)
const open = ref(false)
const title = ref("")
const bannerList = ref([])
const formRef = ref()
const form = reactive({
  bannerId: undefined,
  title: "",
  imageUrl: "",
  linkType: "",
  linkValue: "",
  regions: "",
  startTime: "",
  endTime: "",
  sortOrder: 10,
  isActive: 1
})

const rules = {
  title: [{ required: true, message: "请输入标题", trigger: "blur" }],
  imageUrl: [{ required: true, message: "请输入图片地址", trigger: "blur" }]
}

function getList() {
  loading.value = true
  listBanners().then((res) => {
    bannerList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function resetFormState() {
  Object.assign(form, {
    bannerId: undefined,
    title: "",
    imageUrl: "",
    linkType: "",
    linkValue: "",
    regions: "",
    startTime: "",
    endTime: "",
    sortOrder: 10,
    isActive: 1
  })
  proxy.resetForm("formRef")
}

function handleAdd() {
  resetFormState()
  title.value = "新增 Banner"
  open.value = true
}

function handleEdit(row) {
  resetFormState()
  Object.assign(form, row)
  title.value = "编辑 Banner"
  open.value = true
}

function handleDelete(row) {
  removeBanner(row.bannerId).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  })
}

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    const request = form.bannerId ? updateBanner(form.bannerId, { ...form }) : addBanner({ ...form })
    request.then(() => {
      proxy.$modal.msgSuccess("保存成功")
      open.value = false
      getList()
    })
  })
}

onMounted(() => {
  getList()
})
</script>
