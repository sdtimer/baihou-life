<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Region</div>
        <h1 class="baihou-hero__title">区域管理</h1>
        <p class="baihou-hero__desc">维护服务城市、坐标和排序。区域启停会影响前台可售范围和缓存刷新，因此这里保留显式状态操作。</p>
      </section>

      <section class="baihou-stats">
        <div class="baihou-stat">
          <div class="baihou-stat__label">服务区域</div>
          <div class="baihou-stat__value">{{ regionList.length }}</div>
          <div class="baihou-stat__hint">当前可维护城市数</div>
        </div>
        <div class="baihou-stat">
          <div class="baihou-stat__label">启用中</div>
          <div class="baihou-stat__value">{{ activeCount }}</div>
          <div class="baihou-stat__hint">前台可选城市</div>
        </div>
        <div class="baihou-stat">
          <div class="baihou-stat__label">暂停中</div>
          <div class="baihou-stat__value">{{ inactiveCount }}</div>
          <div class="baihou-stat__hint">用于预发或临时关闭</div>
        </div>
      </section>

      <section class="baihou-panel baihou-table">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">区域列表</div>
            <div class="baihou-panel__desc">提供区域 ID、城市名称、省份、中心点和状态维护</div>
          </div>
          <div class="baihou-toolbar">
            <el-button type="primary" @click="handleAdd" v-hasPermi="['baihou:region:add']">新增区域</el-button>
            <el-button @click="getList">刷新</el-button>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="regionList">
            <el-table-column prop="regionId" label="区域 ID" min-width="120" />
            <el-table-column prop="regionName" label="区域名称" min-width="160" />
            <el-table-column prop="province" label="省份" min-width="120" />
            <el-table-column label="中心点" min-width="180">
              <template #default="scope">
                <span class="baihou-code">{{ scope.row.centerLat || "-" }}, {{ scope.row.centerLng || "-" }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="sortOrder" label="排序" width="90" />
            <el-table-column label="状态" width="110">
              <template #default="scope">
                <el-switch
                  :model-value="scope.row.isActive === 1"
                  @change="(value) => handleStatusChange(scope.row, value)"
                />
              </template>
            </el-table-column>
            <el-table-column label="操作" width="120">
              <template #default="scope">
                <el-button link type="primary" @click="handleEdit(scope.row)" v-hasPermi="['baihou:region:edit']">编辑</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <el-dialog v-model="open" :title="title" width="620px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <div class="baihou-form-grid">
          <el-form-item label="区域 ID" prop="regionId">
            <el-input v-model="form.regionId" :disabled="!!form._editing" placeholder="如 foshan" />
          </el-form-item>
          <el-form-item label="区域名称" prop="regionName">
            <el-input v-model="form.regionName" placeholder="如 佛山" />
          </el-form-item>
          <el-form-item label="省份" prop="province">
            <el-input v-model="form.province" placeholder="如 广东" />
          </el-form-item>
          <el-form-item label="排序" prop="sortOrder">
            <el-input-number v-model="form.sortOrder" :min="0" :controls="false" style="width: 100%" />
          </el-form-item>
          <el-form-item label="纬度">
            <el-input-number v-model="form.centerLat" :precision="6" :controls="false" style="width: 100%" />
          </el-form-item>
          <el-form-item label="经度">
            <el-input-number v-model="form.centerLng" :precision="6" :controls="false" style="width: 100%" />
          </el-form-item>
          <el-form-item label="状态" prop="isActive">
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

<script setup name="BaihouRegions">
import { addRegion, changeRegionStatus, listRegions, updateRegion } from "@/api/baihou/regions"

const { proxy } = getCurrentInstance()

const loading = ref(false)
const open = ref(false)
const title = ref("")
const regionList = ref([])

const formRef = ref()
const form = reactive({
  regionId: "",
  regionName: "",
  province: "",
  centerLat: undefined,
  centerLng: undefined,
  isActive: 1,
  sortOrder: 10,
  _editing: false
})

const rules = {
  regionId: [{ required: true, message: "请输入区域 ID", trigger: "blur" }],
  regionName: [{ required: true, message: "请输入区域名称", trigger: "blur" }]
}

const activeCount = computed(() => regionList.value.filter((item) => item.isActive === 1).length)
const inactiveCount = computed(() => regionList.value.filter((item) => item.isActive !== 1).length)

function getList() {
  loading.value = true
  listRegions().then((res) => {
    regionList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function resetFormState() {
  Object.assign(form, {
    regionId: "",
    regionName: "",
    province: "",
    centerLat: undefined,
    centerLng: undefined,
    isActive: 1,
    sortOrder: 10,
    _editing: false
  })
  proxy.resetForm("formRef")
}

function handleAdd() {
  resetFormState()
  title.value = "新增区域"
  open.value = true
}

function handleEdit(row) {
  resetFormState()
  Object.assign(form, row, { _editing: true })
  title.value = "编辑区域"
  open.value = true
}

function handleStatusChange(row, value) {
  changeRegionStatus(row.regionId, value ? 1 : 0).then(() => {
    proxy.$modal.msgSuccess("状态已更新")
    getList()
  })
}

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    const payload = { ...form }
    delete payload._editing
    const request = form._editing ? updateRegion(payload) : addRegion(payload)
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
