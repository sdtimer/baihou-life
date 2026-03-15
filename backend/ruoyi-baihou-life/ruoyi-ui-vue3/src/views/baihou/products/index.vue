<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Product</div>
        <h1 class="baihou-hero__title">商品管理</h1>
        <p class="baihou-hero__desc">集中维护商品资料、售卖区域和上下架状态。页面同时支持筛选、批量操作、详情抽屉和最小可用编辑表单。</p>
      </section>

      <section class="baihou-stats">
        <div class="baihou-stat">
          <div class="baihou-stat__label">商品总数</div>
          <div class="baihou-stat__value">{{ productList.length }}</div>
          <div class="baihou-stat__hint">当前查询结果</div>
        </div>
        <div class="baihou-stat">
          <div class="baihou-stat__label">上架中</div>
          <div class="baihou-stat__value">{{ statusCount.on_shelf }}</div>
          <div class="baihou-stat__hint">前台可见</div>
        </div>
        <div class="baihou-stat">
          <div class="baihou-stat__label">草稿 / 下架</div>
          <div class="baihou-stat__value">{{ statusCount.draft + statusCount.off_shelf }}</div>
          <div class="baihou-stat__hint">待完善或暂停销售</div>
        </div>
      </section>

      <section class="baihou-panel">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">筛选条件</div>
            <div class="baihou-panel__desc">按关键词、品类、区域和状态定位商品</div>
          </div>
        </div>
        <div class="baihou-panel__body">
          <div class="baihou-filter">
            <el-input v-model="queryParams.keyword" placeholder="商品名称 / SKU" clearable />
            <el-select v-model="queryParams.categoryId" placeholder="品类" clearable>
              <el-option v-for="item in categoryOptions" :key="item.categoryId" :label="item.categoryName" :value="item.categoryId" />
            </el-select>
            <el-select v-model="queryParams.regionId" placeholder="区域" clearable>
              <el-option v-for="item in regionSelectOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
            <el-select v-model="queryParams.status" placeholder="状态" clearable>
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </div>
          <div class="baihou-toolbar" style="margin-top: 14px">
            <el-button type="primary" @click="getList">搜索</el-button>
            <el-button @click="resetQuery">重置</el-button>
          </div>
        </div>
      </section>

      <section class="baihou-panel baihou-table">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">商品列表</div>
            <div class="baihou-panel__desc">支持单条上下架、批量操作和详情查看</div>
          </div>
          <div class="baihou-toolbar">
            <el-button type="primary" @click="handleAdd" v-hasPermi="['baihou:product:add']">新增商品</el-button>
            <el-button :disabled="!selectionIds.length" @click="handleBatchAction('on_shelf')" v-hasPermi="['baihou:product:edit']">批量上架</el-button>
            <el-button :disabled="!selectionIds.length" @click="handleBatchAction('off_shelf')" v-hasPermi="['baihou:product:edit']">批量下架</el-button>
            <el-button :disabled="!selectionIds.length" type="danger" @click="handleBatchAction('archive')" v-hasPermi="['baihou:product:remove']">批量归档</el-button>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="productList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="50" />
            <el-table-column prop="name" label="商品名称" min-width="220" show-overflow-tooltip />
            <el-table-column prop="skuCode" label="SKU" min-width="120" />
            <el-table-column prop="brand" label="品牌" min-width="110" />
            <el-table-column prop="guidePrice" label="指导价" width="120" />
            <el-table-column label="状态" width="110">
              <template #default="scope">
                <span class="baihou-chip" :class="statusClass(scope.row.status)">{{ statusLabel(scope.row.status) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="regions" label="区域" min-width="160" show-overflow-tooltip />
            <el-table-column label="操作" width="220" fixed="right">
              <template #default="scope">
                <el-button link type="primary" @click="showDetail(scope.row)">详情</el-button>
                <el-button link type="primary" @click="handleEdit(scope.row)" v-hasPermi="['baihou:product:edit']">编辑</el-button>
                <el-dropdown @command="(command) => handleStatus(scope.row, command)">
                  <el-button link type="primary" v-hasPermi="['baihou:product:edit']">状态</el-button>
                  <template #dropdown>
                    <el-dropdown-menu>
                      <el-dropdown-item command="draft">设为草稿</el-dropdown-item>
                      <el-dropdown-item command="on_shelf">上架</el-dropdown-item>
                      <el-dropdown-item command="off_shelf">下架</el-dropdown-item>
                      <el-dropdown-item command="archived">归档</el-dropdown-item>
                    </el-dropdown-menu>
                  </template>
                </el-dropdown>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <el-dialog v-model="open" :title="title" width="760px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
        <div class="baihou-form-grid">
          <el-form-item label="商品名称" prop="name">
            <el-input v-model="form.name" />
          </el-form-item>
          <el-form-item label="SKU" prop="skuCode">
            <el-input v-model="form.skuCode" />
          </el-form-item>
          <el-form-item label="品牌">
            <el-input v-model="form.brand" />
          </el-form-item>
          <el-form-item label="型号">
            <el-input v-model="form.model" />
          </el-form-item>
          <el-form-item label="品类" prop="categoryId">
            <el-select v-model="form.categoryId" placeholder="请选择">
              <el-option v-for="item in categoryOptions" :key="item.categoryId" :label="item.categoryName" :value="item.categoryId" />
            </el-select>
          </el-form-item>
          <el-form-item label="指导价">
            <el-input-number v-model="form.guidePrice" :precision="2" :min="0" style="width: 100%" />
          </el-form-item>
          <el-form-item label="价格单位">
            <el-input v-model="form.priceUnit" placeholder="如 元/套" />
          </el-form-item>
          <el-form-item label="设计师折扣">
            <el-input-number v-model="form.designerDiscount" :precision="2" :min="0" :max="1" :step="0.01" style="width: 100%" />
          </el-form-item>
          <el-form-item label="区域" prop="regions">
            <el-select v-model="form.regions" multiple placeholder="请选择区域" style="width: 100%">
              <el-option v-for="item in regionSelectOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="空间标签">
            <el-select v-model="spaceTagsArr" multiple placeholder="请选择空间标签" style="width: 100%">
              <el-option v-for="item in spaceTagOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="场景标签">
            <el-select v-model="sceneTagsArr" multiple placeholder="请选择场景标签" style="width: 100%">
              <el-option v-for="item in sceneTagOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item v-if="specDefs.length > 0" label="规格参数" style="grid-column: 1 / -1">
            <div class="baihou-spec-grid">
              <template v-for="def in specDefs" :key="def.specDefId">
                <div class="baihou-spec-item">
                  <div class="baihou-spec-label">{{ def.specLabel }}<span v-if="def.unit" style="color:#999;font-size:12px">（{{ def.unit }}）</span></div>
                  <el-input v-if="def.inputType === 'text'" v-model="specParamsObj[def.specKey]" />
                  <el-input-number v-else-if="def.inputType === 'number'" v-model="specParamsObj[def.specKey]" style="width: 100%" />
                  <el-select v-else-if="def.inputType === 'select'" v-model="specParamsObj[def.specKey]" style="width: 100%">
                    <el-option v-for="opt in parseOptions(def.options)" :key="opt" :label="opt" :value="opt" />
                  </el-select>
                </div>
              </template>
            </div>
          </el-form-item>
          <el-form-item label="状态">
            <el-select v-model="form.status">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="排序">
            <el-input-number v-model="form.sortOrder" :min="0" :controls="false" style="width: 100%" />
          </el-form-item>
        </div>
        <el-form-item label="商品描述">
          <el-input v-model="form.description" type="textarea" :rows="4" />
        </el-form-item>
        <el-divider content-position="left">图片与下载资源</el-divider>
        <el-form-item label="场景图" prop="sceneImageUrls">
          <div class="baihou-media-panel">
            <ImageUpload v-model="form.sceneImageUrls" :limit="8" />
            <div v-if="sceneImageList.length" class="baihou-cover-grid">
              <div v-for="item in sceneImageList" :key="item" class="baihou-cover-item">
                <img :src="previewUrl(item)" class="baihou-cover-item__image" />
                <el-radio v-model="form.coverImageUrl" :label="item">设为主图</el-radio>
              </div>
            </div>
            <div v-else class="baihou-form-tip">请至少上传一张场景图，并选择主图。</div>
          </div>
        </el-form-item>
        <el-form-item label="元素图">
          <ImageUpload v-model="form.elementImageUrls" :limit="8" />
        </el-form-item>
        <el-form-item label="规格图">
          <ImageUpload v-model="form.specImageUrls" :limit="8" />
        </el-form-item>
        <el-form-item label="高清下载图">
          <ImageUpload v-model="form.downloadImageUrls" :limit="8" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="open = false">取消</el-button>
        <el-button type="primary" @click="submitForm">保存</el-button>
      </template>
    </el-dialog>

    <el-drawer v-model="detailOpen" title="商品详情" size="560px">
      <div v-if="detailData" class="baihou-shell">
        <div class="baihou-drawer-summary">
          <div class="baihou-drawer-card">
            <div class="baihou-drawer-card__label">商品名称</div>
            <div class="baihou-drawer-card__value">{{ detailData.name }}</div>
          </div>
          <div class="baihou-drawer-card">
            <div class="baihou-drawer-card__label">状态</div>
            <div class="baihou-drawer-card__value">{{ statusLabel(detailData.status) }}</div>
          </div>
          <div class="baihou-drawer-card">
            <div class="baihou-drawer-card__label">区域</div>
            <div class="baihou-drawer-card__value">{{ detailData.regions || "--" }}</div>
          </div>
          <div class="baihou-drawer-card">
            <div class="baihou-drawer-card__label">SKU</div>
            <div class="baihou-drawer-card__value">{{ detailData.skuCode || "--" }}</div>
          </div>
        </div>
        <div class="baihou-drawer-card">
          <div class="baihou-drawer-card__label">描述</div>
          <div class="baihou-drawer-card__value">{{ detailData.description || "暂无描述" }}</div>
        </div>
        <div class="baihou-drawer-card">
          <div class="baihou-drawer-card__label">素材分组</div>
          <div class="baihou-drawer-card__value">
            场景图 {{ detailData.sceneImages?.length || 0 }} / 元素图 {{ detailData.elementImages?.length || 0 }} /
            规格图 {{ detailData.specImages?.length || 0 }} / 高清图 {{ detailData.downloadImages?.length || 0 }} /
            源文件 {{ detailData.sourceFiles?.length || 0 }}
          </div>
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<script setup name="BaihouProducts">
import { ElMessageBox } from "element-plus"
import { listCategories, listSpecDefs } from "@/api/baihou/categories"
import { getRegionOptions } from "@/api/baihou/regions"
import { addProduct, batchProductAction, changeProductStatus, getProduct, listProducts, removeProduct, updateProduct } from "@/api/baihou/products"
import { useDict } from "@/utils/dict"

const { proxy } = getCurrentInstance()
const { baihou_space_tag: spaceTagOptions, baihou_scene_tag: sceneTagOptions } = useDict("baihou_space_tag", "baihou_scene_tag")

const loading = ref(false)
const open = ref(false)
const detailOpen = ref(false)
const title = ref("")
const productList = ref([])
const categoryOptions = ref([])
const regionSelectOptions = ref([])
const detailData = ref()
const selectionIds = ref([])
const spaceTagsArr = ref([])
const sceneTagsArr = ref([])
const specDefs = ref([])
const specParamsObj = ref({})
const specParamCache = new Map()

const formRef = ref()
const queryParams = reactive({
  keyword: "",
  categoryId: undefined,
  regionId: undefined,
  status: ""
})
const form = reactive({
  id: undefined,
  name: "",
  skuCode: "",
  brand: "",
  model: "",
  categoryId: undefined,
  guidePrice: 0,
  priceUnit: "元/套",
  designerDiscount: 0.9,
  regions: [],
  spaceTags: "",
  sceneTags: "",
  specParams: "",
  description: "",
  status: "draft",
  sortOrder: 10,
  sceneImageUrls: "",
  elementImageUrls: "",
  specImageUrls: "",
  downloadImageUrls: "",
  coverImageUrl: ""
})

const rules = {
  name: [{ required: true, message: "请输入商品名称", trigger: "blur" }],
  skuCode: [{ required: true, message: "请输入 SKU", trigger: "blur" }],
  categoryId: [{ required: true, message: "请选择品类", trigger: "change" }],
  regions: [{ required: true, message: "请选择区域", trigger: "change" }]
}

const statusOptions = [
  { label: "草稿", value: "draft" },
  { label: "上架", value: "on_shelf" },
  { label: "下架", value: "off_shelf" },
  { label: "归档", value: "archived" }
]

const statusCount = computed(() => {
  return productList.value.reduce((acc, item) => {
    acc[item.status] = (acc[item.status] || 0) + 1
    return acc
  }, { draft: 0, on_shelf: 0, off_shelf: 0, archived: 0 })
})

function getList() {
  loading.value = true
  listProducts(queryParams).then((res) => {
    productList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function loadOptions() {
  listCategories().then((res) => {
    categoryOptions.value = res.data || []
  })
  getRegionOptions().then((res) => {
    regionSelectOptions.value = res.data || []
  })
}

function resetQuery() {
  Object.assign(queryParams, { keyword: "", categoryId: undefined, regionId: undefined, status: "" })
  getList()
}

function resetFormState() {
  Object.assign(form, {
    id: undefined,
    name: "",
    skuCode: "",
    brand: "",
    model: "",
    categoryId: undefined,
    guidePrice: 0,
    priceUnit: "元/套",
    designerDiscount: 0.9,
    regions: [],
    spaceTags: "",
    sceneTags: "",
    specParams: "",
  description: "",
  status: "draft",
  sortOrder: 10,
  sceneImageUrls: "",
  elementImageUrls: "",
  specImageUrls: "",
  downloadImageUrls: "",
  coverImageUrl: ""
  })
  spaceTagsArr.value = []
  sceneTagsArr.value = []
  specDefs.value = []
  specParamsObj.value = {}
  specParamCache.clear()
  proxy.resetForm("formRef")
}

function handleAdd() {
  resetFormState()
  title.value = "新增商品"
  open.value = true
}

async function handleEdit(row) {
  resetFormState()
  const productId = row?.id ?? row?.productId ?? row?.product_id
  if (!productId) {
    proxy.$modal.msgError("商品ID缺失，无法编辑")
    return
  }
  const detail = await getProduct(productId).then((res) => res.data)
  if (!detail) {
    proxy.$modal.msgError("商品详情不存在或已被删除")
    return
  }
  Object.assign(form, detail)
  try { form.regions = JSON.parse(detail.regions || "[]") } catch (e) { form.regions = [] }
  try { spaceTagsArr.value = JSON.parse(detail.spaceTags || "[]") } catch (e) { spaceTagsArr.value = [] }
  try { sceneTagsArr.value = JSON.parse(detail.sceneTags || "[]") } catch (e) { sceneTagsArr.value = [] }
  try { specParamsObj.value = JSON.parse(detail.specParams || "{}") } catch (e) { specParamsObj.value = {} }
  form.sceneImageUrls = mediaUrlsToString(detail.sceneImages)
  form.elementImageUrls = mediaUrlsToString(detail.elementImages)
  form.specImageUrls = mediaUrlsToString(detail.specImages)
  form.downloadImageUrls = mediaUrlsToString(detail.downloadImages)
  form.coverImageUrl = detail.sceneImages?.find((item) => Number(item.isCover) === 1)?.url || firstMediaUrl(detail.sceneImages)
  if (detail.categoryId) {
    loadSpecDefs(detail.categoryId)
  } else {
    specDefs.value = []
  }
  title.value = "编辑商品"
  open.value = true
}

function handleSelectionChange(selection) {
  selectionIds.value = selection.map((item) => item.id)
}

function handleStatus(row, status) {
  if (status === "archived") {
    removeProduct(row.id).then(() => {
      proxy.$modal.msgSuccess("商品已归档")
      getList()
    })
    return
  }
  changeProductStatus(row.id, status).then(() => {
    proxy.$modal.msgSuccess("状态已更新")
    getList()
  })
}

async function handleBatchAction(action) {
  if (action === "archive") {
    try {
      await ElMessageBox.confirm(
        `确认归档选中的 ${selectionIds.value.length} 件商品？归档后不可撤销。`,
        "批量归档确认",
        { type: "warning" }
      )
    } catch {
      return
    }
  }
  batchProductAction({ ids: selectionIds.value, action }).then(() => {
    proxy.$modal.msgSuccess("批量操作成功")
    getList()
  })
}

function loadSpecDefs(categoryId) {
  if (!categoryId) {
    specDefs.value = []
    specParamsObj.value = {}
    return
  }
  listSpecDefs(categoryId).then((res) => {
    specDefs.value = res.data || []
    const newObj = {}
    specDefs.value.forEach((def) => {
      newObj[def.specKey] = specParamsObj.value[def.specKey] ?? undefined
    })
    specParamsObj.value = newObj
  })
}

function parseOptions(optionsStr) {
  try { return JSON.parse(optionsStr || "[]") } catch (e) { return [] }
}

watch(() => form.categoryId, (newVal, oldVal) => {
  if (newVal !== oldVal) {
    if (oldVal) specParamCache.set(oldVal, { ...specParamsObj.value })
    specParamsObj.value = specParamCache.get(newVal) ?? {}
    if (newVal) loadSpecDefs(newVal)
  }
})

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    if (!sceneImageList.value.length) {
      proxy.$modal.msgError("请至少上传一张场景图")
      return
    }
    const payload = {
      ...form,
      regions: JSON.stringify(form.regions),
      spaceTags: JSON.stringify(spaceTagsArr.value),
      sceneTags: JSON.stringify(sceneTagsArr.value),
      specParams: JSON.stringify(specParamsObj.value),
      sceneImages: buildMediaPayload(sceneImageList.value, {
        type: "scene",
        accessLevel: "public",
        assetRole: "display",
        coverUrl: form.coverImageUrl
      }),
      elementImages: buildMediaPayload(parseMediaList(form.elementImageUrls), {
        type: "element",
        accessLevel: "public",
        assetRole: "display"
      }),
      specImages: buildMediaPayload(parseMediaList(form.specImageUrls), {
        type: "spec",
        accessLevel: "public",
        assetRole: "display"
      }),
      sourceFiles: [],
      downloadImages: buildMediaPayload(parseMediaList(form.downloadImageUrls), {
        type: "scene",
        accessLevel: "designer",
        assetRole: "download"
      })
    }
    delete payload.sceneImageUrls
    delete payload.elementImageUrls
    delete payload.specImageUrls
    delete payload.downloadImageUrls
    delete payload.coverImageUrl
    const request = form.id ? updateProduct(form.id, payload) : addProduct(payload)
    request.then(() => {
      proxy.$modal.msgSuccess("保存成功")
      open.value = false
      getList()
    })
  })
}

function showDetail(row) {
  getProduct(row.id).then((res) => {
    detailData.value = res.data
    detailOpen.value = true
  })
}

function mediaUrlsToString(list = []) {
  return (list || []).map((item) => item.url).filter(Boolean).join(",")
}

function parseMediaList(value) {
  return (value || "").split(",").map((item) => item.trim()).filter(Boolean)
}

function firstMediaUrl(list = []) {
  return (list || []).find((item) => item?.url)?.url || ""
}

function buildMediaPayload(urls, options = {}) {
  return urls.map((url, index) => {
    const cleanUrl = url.replace(import.meta.env.VITE_APP_BASE_API, "")
    return {
      type: options.type,
      url: cleanUrl,
      thumbnailUrl: cleanUrl,
      originalUrl: options.assetRole === "download" ? cleanUrl : cleanUrl,
      fileName: cleanUrl.split("/").pop(),
      fileFormat: cleanUrl.split(".").pop() || "",
      accessLevel: options.accessLevel,
      assetRole: options.assetRole,
      isCover: options.coverUrl && cleanUrl === options.coverUrl.replace(import.meta.env.VITE_APP_BASE_API, "") ? 1 : 0,
      sortOrder: (index + 1) * 10
    }
  })
}

function previewUrl(url) {
  if (!url) {
    return ""
  }
  if (/^https?:\/\//.test(url)) {
    return url
  }
  return `${import.meta.env.VITE_APP_BASE_API}${url}`
}

function statusLabel(status) {
  return statusOptions.find((item) => item.value === status)?.label || status
}

function statusClass(status) {
  if (status === "on_shelf") {
    return "is-soft-green"
  }
  if (status === "archived") {
    return "is-danger"
  }
  return ""
}

onMounted(() => {
  loadOptions()
  getList()
})

const sceneImageList = computed(() => parseMediaList(form.sceneImageUrls))

watch(sceneImageList, (list) => {
  if (!list.length) {
    form.coverImageUrl = ""
    return
  }
  if (!list.includes(form.coverImageUrl)) {
    form.coverImageUrl = list[0]
  }
}, { immediate: true })
</script>

<style scoped lang="scss">
.baihou-media-panel {
  width: 100%;
}

.baihou-cover-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 12px;
  margin-top: 12px;
}

.baihou-cover-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 10px;
  border: 1px solid rgba(111, 90, 69, 0.12);
  border-radius: 16px;
  background: #fffaf4;
}

.baihou-cover-item__image {
  width: 100%;
  height: 92px;
  object-fit: cover;
  border-radius: 12px;
}

.baihou-form-tip {
  color: #8f7a66;
  font-size: 13px;
}
</style>
