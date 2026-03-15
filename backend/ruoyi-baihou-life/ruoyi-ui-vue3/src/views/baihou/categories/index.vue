<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Category</div>
        <h1 class="baihou-hero__title">品类树管理</h1>
        <p class="baihou-hero__desc">维护首页导航、商品归类和运营排序。当前页面按设计系统使用暖中性色、轻卡片和高可读表格，兼顾品牌一致性与后台操作效率。</p>
      </section>

      <section class="baihou-stats">
        <div class="baihou-stat">
          <div class="baihou-stat__label">品类总数</div>
          <div class="baihou-stat__value">{{ categoryList.length }}</div>
          <div class="baihou-stat__hint">含一级与子级品类</div>
        </div>
        <div class="baihou-stat">
          <div class="baihou-stat__label">启用品类</div>
          <div class="baihou-stat__value">{{ enabledCount }}</div>
          <div class="baihou-stat__hint">前台可展示</div>
        </div>
        <div class="baihou-stat">
          <div class="baihou-stat__label">停用品类</div>
          <div class="baihou-stat__value">{{ disabledCount }}</div>
          <div class="baihou-stat__hint">停用会联动商品下架</div>
        </div>
      </section>

      <section class="baihou-panel baihou-table">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">品类列表</div>
            <div class="baihou-panel__desc">支持创建、编辑、启停和排序调整</div>
          </div>
          <div class="baihou-toolbar">
            <el-button type="primary" @click="handleAdd" v-hasPermi="['baihou:category:add']">新增品类</el-button>
            <el-button @click="getList">刷新</el-button>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="categoryList" row-key="categoryId">
            <el-table-column prop="categoryName" label="品类名称" min-width="220" />
            <el-table-column prop="parentId" label="父级 ID" width="110" />
            <el-table-column label="图标" min-width="180">
              <template #default="scope">
                <span class="baihou-code">{{ scope.row.iconUrl || "未配置" }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="sortOrder" label="排序" width="100" />
            <el-table-column label="状态" width="120">
              <template #default="scope">
                <el-switch
                  :model-value="scope.row.isActive === 1"
                  @change="(value) => handleStatusChange(scope.row, value)"
                />
              </template>
            </el-table-column>
            <el-table-column label="操作" width="180" fixed="right">
              <template #default="scope">
                <el-button link type="primary" @click="handleEdit(scope.row)" v-hasPermi="['baihou:category:edit']">编辑</el-button>
                <el-button link type="primary" @click="handleSpecDef(scope.row)" v-hasPermi="['baihou:category:edit']">规格模板</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <!-- 规格模板对话框 -->
    <el-dialog v-model="specDefOpen" :title="`规格模板 — ${specDefCategoryName}`" width="720px" append-to-body>
      <div class="baihou-toolbar" style="margin-bottom: 12px; display: flex; gap: 8px">
        <el-button type="primary" size="small" @click="handleAddSpecDef">新增规格</el-button>
        <el-button size="small" @click="submitSort" :disabled="specDefList.length < 2">保存排序</el-button>
      </div>
      <el-table :data="specDefList" v-loading="specDefLoading">
        <el-table-column prop="specLabel" label="显示名称" min-width="120" />
        <el-table-column prop="specKey" label="字段Key" min-width="120" />
        <el-table-column prop="inputType" label="输入类型" width="100" />
        <el-table-column prop="unit" label="单位" width="80" />
        <el-table-column label="必填" width="80">
          <template #default="scope">{{ scope.row.isRequired === 1 ? "是" : "否" }}</template>
        </el-table-column>
        <el-table-column prop="sortOrder" label="排序" width="80" />
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button link type="primary" @click="handleMoveUp(scope.$index)" :disabled="scope.$index === 0">↑</el-button>
            <el-button link type="primary" @click="handleMoveDown(scope.$index)" :disabled="scope.$index === specDefList.length - 1">↓</el-button>
            <el-button link type="primary" @click="handleEditSpecDef(scope.row)">编辑</el-button>
            <el-button link type="danger" @click="handleDeleteSpecDef(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>

    <!-- 规格编辑表单对话框（平级，避免嵌套 dialog z-index 问题） -->
    <el-dialog v-model="specDefFormOpen" :title="specDefFormTitle" width="500px" append-to-body>
      <el-form ref="specDefFormRef" :model="specDefForm" :rules="specDefRules" label-width="90px">
        <el-form-item label="显示名称" prop="specLabel">
          <el-input v-model="specDefForm.specLabel" />
        </el-form-item>
        <el-form-item label="字段Key" prop="specKey">
          <el-input v-model="specDefForm.specKey" placeholder="英文字母/下划线" />
        </el-form-item>
        <el-form-item label="输入类型" prop="inputType">
          <el-select v-model="specDefForm.inputType" style="width: 100%">
            <el-option label="文本" value="text" />
            <el-option label="数字" value="number" />
            <el-option label="下拉选择" value="select" />
          </el-select>
        </el-form-item>
        <el-form-item v-if="specDefForm.inputType === 'select'" label="选项">
          <el-input v-model="specDefForm.options" placeholder='["选项1","选项2"]' />
        </el-form-item>
        <el-form-item label="单位">
          <el-input v-model="specDefForm.unit" placeholder="如 mm、kg" />
        </el-form-item>
        <el-form-item label="必填">
          <el-radio-group v-model="specDefForm.isRequired">
            <el-radio :value="1">是</el-radio>
            <el-radio :value="0">否</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="specDefForm.sortOrder" :min="0" :controls="false" style="width: 100%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="specDefFormOpen = false">取消</el-button>
        <el-button type="primary" @click="submitSpecDefForm">保存</el-button>
      </template>
    </el-dialog>

    <el-dialog v-model="open" :title="title" width="560px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <div class="baihou-form-grid">
          <el-form-item label="品类名称" prop="categoryName">
            <el-input v-model="form.categoryName" placeholder="如 客厅沙发" />
          </el-form-item>
          <el-form-item label="父级 ID" prop="parentId">
            <el-input-number v-model="form.parentId" :min="0" :controls="false" style="width: 100%" />
          </el-form-item>
          <el-form-item label="图标地址" prop="iconUrl">
            <el-input v-model="form.iconUrl" placeholder="可选" />
          </el-form-item>
          <el-form-item label="排序" prop="sortOrder">
            <el-input-number v-model="form.sortOrder" :min="0" :controls="false" style="width: 100%" />
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

<script setup name="BaihouCategories">
import { addCategory, addSpecDef, changeCategoryStatus, listCategories, listSpecDefs, removeSpecDef, updateCategory, updateSpecDef, updateSpecDefSort } from "@/api/baihou/categories"

const { proxy } = getCurrentInstance()

const loading = ref(false)
const open = ref(false)
const title = ref("")
const categoryList = ref([])

// 规格模板状态
const specDefOpen = ref(false)
const specDefLoading = ref(false)
const specDefCategoryId = ref(null)
const specDefCategoryName = ref("")
const specDefList = ref([])
const specDefFormOpen = ref(false)
const specDefFormTitle = ref("")
const specDefFormRef = ref()
const specDefForm = reactive({
  specDefId: undefined,
  specLabel: "",
  specKey: "",
  inputType: "text",
  options: "",
  unit: "",
  isRequired: 0,
  sortOrder: 10
})
const specDefRules = {
  specLabel: [{ required: true, message: "请输入显示名称", trigger: "blur" }],
  specKey: [{ required: true, message: "请输入字段Key", trigger: "blur" }],
  inputType: [{ required: true, message: "请选择输入类型", trigger: "change" }]
}

const formRef = ref()
const form = reactive({
  categoryId: undefined,
  categoryName: "",
  parentId: 0,
  iconUrl: "",
  sortOrder: 10,
  isActive: 1
})

const rules = {
  categoryName: [{ required: true, message: "请输入品类名称", trigger: "blur" }]
}

const enabledCount = computed(() => categoryList.value.filter((item) => item.isActive === 1).length)
const disabledCount = computed(() => categoryList.value.filter((item) => item.isActive !== 1).length)

function getList() {
  loading.value = true
  listCategories().then((res) => {
    categoryList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function resetFormState() {
  Object.assign(form, {
    categoryId: undefined,
    categoryName: "",
    parentId: 0,
    iconUrl: "",
    sortOrder: 10,
    isActive: 1
  })
  proxy.resetForm("formRef")
}

function handleAdd() {
  resetFormState()
  title.value = "新增品类"
  open.value = true
}

function handleEdit(row) {
  resetFormState()
  Object.assign(form, row)
  title.value = "编辑品类"
  open.value = true
}

function handleStatusChange(row, value) {
  changeCategoryStatus(row.categoryId, value ? 1 : 0).then(() => {
    proxy.$modal.msgSuccess("状态已更新")
    getList()
  })
}

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    const request = form.categoryId ? updateCategory({ ...form }) : addCategory({ ...form })
    request.then(() => {
      proxy.$modal.msgSuccess("保存成功")
      open.value = false
      getList()
    })
  })
}

function handleSpecDef(row) {
  specDefCategoryId.value = row.categoryId
  specDefCategoryName.value = row.categoryName
  specDefList.value = []
  specDefOpen.value = true
  loadSpecDefList()
}

function loadSpecDefList() {
  specDefLoading.value = true
  listSpecDefs(specDefCategoryId.value).then((res) => {
    specDefList.value = res.data || []
  }).finally(() => {
    specDefLoading.value = false
  })
}

function handleAddSpecDef() {
  Object.assign(specDefForm, {
    specDefId: undefined,
    specLabel: "",
    specKey: "",
    inputType: "text",
    options: "",
    unit: "",
    isRequired: 0,
    sortOrder: 10
  })
  specDefFormTitle.value = "新增规格"
  specDefFormOpen.value = true
}

function handleEditSpecDef(row) {
  Object.assign(specDefForm, row)
  specDefFormTitle.value = "编辑规格"
  specDefFormOpen.value = true
}

function handleDeleteSpecDef(row) {
  removeSpecDef(specDefCategoryId.value, row.specDefId).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    loadSpecDefList()
  })
}

function handleMoveUp(index) {
  if (index === 0) return
  const list = [...specDefList.value]
  ;[list[index - 1].sortOrder, list[index].sortOrder] = [list[index].sortOrder, list[index - 1].sortOrder]
  ;[list[index - 1], list[index]] = [list[index], list[index - 1]]
  specDefList.value = list
}

function handleMoveDown(index) {
  if (index === specDefList.value.length - 1) return
  const list = [...specDefList.value]
  ;[list[index].sortOrder, list[index + 1].sortOrder] = [list[index + 1].sortOrder, list[index].sortOrder]
  ;[list[index], list[index + 1]] = [list[index + 1], list[index]]
  specDefList.value = list
}

function submitSort() {
  const payload = specDefList.value.map(({ specDefId, sortOrder }) => ({ specDefId, sortOrder }))
  updateSpecDefSort(specDefCategoryId.value, payload).then(() => {
    proxy.$modal.msgSuccess("排序已保存")
  })
}

function submitSpecDefForm() {
  specDefFormRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    const request = specDefForm.specDefId
      ? updateSpecDef(specDefCategoryId.value, specDefForm.specDefId, { ...specDefForm })
      : addSpecDef(specDefCategoryId.value, { ...specDefForm })
    request.then(() => {
      proxy.$modal.msgSuccess("保存成功")
      specDefFormOpen.value = false
      loadSpecDefList()
    })
  })
}

onMounted(() => {
  getList()
})
</script>
