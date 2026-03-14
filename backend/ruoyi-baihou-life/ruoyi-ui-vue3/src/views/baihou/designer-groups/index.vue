<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Designer Group</div>
        <h1 class="baihou-hero__title">设计师分组</h1>
        <p class="baihou-hero__desc">统一管理设计师层级和默认折扣，给后续设计师账号管理和素材策略提供基础规则。</p>
      </section>

      <section class="baihou-stats">
        <div class="baihou-stat">
          <div class="baihou-stat__label">分组数量</div>
          <div class="baihou-stat__value">{{ groupList.length }}</div>
          <div class="baihou-stat__hint">当前折扣体系节点</div>
        </div>
        <div class="baihou-stat">
          <div class="baihou-stat__label">平均折扣</div>
          <div class="baihou-stat__value">{{ averageDiscount }}</div>
          <div class="baihou-stat__hint">按已配置组计算</div>
        </div>
      </section>

      <section class="baihou-panel baihou-table">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">设计师分组列表</div>
            <div class="baihou-panel__desc">用于设计师分层、默认权益和素材下载策略</div>
          </div>
          <div class="baihou-toolbar">
            <el-button type="primary" @click="handleAdd" v-hasPermi="['baihou:designerGroup:add']">新增分组</el-button>
            <el-button @click="getList">刷新</el-button>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="groupList">
            <el-table-column prop="groupId" label="分组 ID" width="120" />
            <el-table-column prop="groupName" label="分组名称" min-width="180" />
            <el-table-column label="默认折扣" min-width="140">
              <template #default="scope">
                <span class="baihou-chip is-soft-green">{{ scope.row.defaultDiscount || "未配置" }}</span>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="120">
              <template #default="scope">
                <el-button link type="primary" @click="handleEdit(scope.row)" v-hasPermi="['baihou:designerGroup:edit']">编辑</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <el-dialog v-model="open" :title="title" width="520px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="分组名称" prop="groupName">
          <el-input v-model="form.groupName" placeholder="如 城市合伙人" />
        </el-form-item>
        <el-form-item label="默认折扣" prop="defaultDiscount">
          <el-input-number v-model="form.defaultDiscount" :precision="2" :min="0" :step="0.01" style="width: 100%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="open = false">取消</el-button>
        <el-button type="primary" @click="submitForm">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="BaihouDesignerGroups">
import { addDesignerGroup, listDesignerGroups, updateDesignerGroup } from "@/api/baihou/designerGroups"

const { proxy } = getCurrentInstance()

const loading = ref(false)
const open = ref(false)
const title = ref("")
const groupList = ref([])

const formRef = ref()
const form = reactive({
  groupId: undefined,
  groupName: "",
  defaultDiscount: 0.9
})

const rules = {
  groupName: [{ required: true, message: "请输入分组名称", trigger: "blur" }]
}

const averageDiscount = computed(() => {
  const valid = groupList.value.filter((item) => item.defaultDiscount !== null && item.defaultDiscount !== undefined)
  if (!valid.length) {
    return "--"
  }
  const total = valid.reduce((sum, item) => sum + Number(item.defaultDiscount), 0)
  return (total / valid.length).toFixed(2)
})

function getList() {
  loading.value = true
  listDesignerGroups().then((res) => {
    groupList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function resetFormState() {
  Object.assign(form, {
    groupId: undefined,
    groupName: "",
    defaultDiscount: 0.9
  })
  proxy.resetForm("formRef")
}

function handleAdd() {
  resetFormState()
  title.value = "新增分组"
  open.value = true
}

function handleEdit(row) {
  resetFormState()
  Object.assign(form, row)
  title.value = "编辑分组"
  open.value = true
}

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    const request = form.groupId ? updateDesignerGroup(form.groupId, { ...form }) : addDesignerGroup({ ...form })
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
