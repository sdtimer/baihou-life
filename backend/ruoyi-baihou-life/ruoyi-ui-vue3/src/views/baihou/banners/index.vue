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
            <el-table-column label="区域" min-width="200">
              <template #default="scope">
                <template v-if="parseRegionTags(scope.row.regions).length">
                  <el-tag
                    v-for="tag in parseRegionTags(scope.row.regions)"
                    :key="tag.value"
                    :type="tag.value === 'ALL' ? 'primary' : 'info'"
                    size="small"
                    style="margin-right: 4px; margin-bottom: 2px"
                  >{{ tag.label }}</el-tag>
                </template>
                <span v-else>--</span>
              </template>
            </el-table-column>
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
            <el-select
              v-model="regionsArr"
              multiple
              placeholder="请选择投放区域"
              style="width: 100%"
              @change="handleRegionChange"
            >
              <el-option label="全部区域" value="ALL" />
              <el-option v-for="item in regionOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
            <div style="margin-top: 6px; display: flex; gap: 8px">
              <el-button size="small" @click="selectAllRegions">全选</el-button>
              <el-button size="small" @click="regionsArr = []">清空</el-button>
            </div>
          </el-form-item>
          <el-form-item label="排序">
            <el-input-number v-model="form.sortOrder" :min="0" :controls="false" style="width: 100%" />
          </el-form-item>
          <el-form-item label="开始时间">
            <el-date-picker v-model="form.startTime" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" style="width: 100%" />
          </el-form-item>
          <el-form-item label="结束时间" prop="endTime">
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
import { getRegionOptions } from "@/api/baihou/regions"

const { proxy } = getCurrentInstance()

const loading = ref(false)
const open = ref(false)
const title = ref("")
const bannerList = ref([])
const regionOptions = ref([])
const regionsArr = ref([])
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
  imageUrl: [{ required: true, message: "请输入图片地址", trigger: "blur" }],
  endTime: [{
    validator: (rule, value, callback) => {
      if (value && form.startTime && value <= form.startTime) {
        callback(new Error("结束时间必须晚于开始时间"))
      } else {
        callback()
      }
    },
    trigger: "change"
  }]
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
  regionsArr.value = []
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
  try { regionsArr.value = JSON.parse(row.regions || "[]") } catch (e) { regionsArr.value = [] }
  title.value = "编辑 Banner"
  open.value = true
}

function handleDelete(row) {
  removeBanner(row.bannerId).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  })
}

function handleRegionChange(val) {
  if (val.includes("ALL") && val.length > 1) {
    const lastSelected = val[val.length - 1]
    if (lastSelected === "ALL") {
      regionsArr.value = ["ALL"]
    } else {
      regionsArr.value = val.filter((v) => v !== "ALL")
    }
  }
}

function selectAllRegions() {
  regionsArr.value = ["ALL"]
}

function parseRegionTags(regionsStr) {
  try {
    const arr = JSON.parse(regionsStr || "[]")
    return arr.map((v) => {
      if (v === "ALL") return { value: "ALL", label: "全部区域" }
      const found = regionOptions.value.find((r) => r.value === v)
      return { value: v, label: found ? found.label : v }
    })
  } catch (e) {
    return []
  }
}

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    const payload = { ...form, regions: JSON.stringify(regionsArr.value) }
    const request = form.bannerId ? updateBanner(form.bannerId, payload) : addBanner(payload)
    request.then(() => {
      proxy.$modal.msgSuccess("保存成功")
      open.value = false
      getList()
    })
  })
}

onMounted(() => {
  getRegionOptions().then((res) => {
    regionOptions.value = res.data || []
  })
  getList()
})
</script>
