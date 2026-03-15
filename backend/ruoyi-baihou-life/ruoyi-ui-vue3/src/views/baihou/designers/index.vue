<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Designer</div>
        <h1 class="baihou-hero__title">设计师账号管理</h1>
        <p class="baihou-hero__desc">维护设计师名单、手机号哈希关联、公司信息和权益折扣。页面与分组页配合使用，完成完整设计师体系配置。</p>
      </section>

      <section class="baihou-panel baihou-table">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">设计师列表</div>
            <div class="baihou-panel__desc">支持创建、编辑和启停</div>
          </div>
          <div class="baihou-toolbar">
            <el-button type="primary" @click="handleAdd" v-hasPermi="['baihou:designer:add']">新增设计师</el-button>
            <el-button @click="getList">刷新</el-button>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="designerList">
            <el-table-column prop="name" label="姓名" min-width="120" />
            <el-table-column prop="phone" label="手机号" min-width="140" />
            <el-table-column prop="company" label="公司" min-width="160" />
            <el-table-column prop="groupId" label="分组 ID" width="110" />
            <el-table-column prop="discount" label="折扣" width="100" />
            <el-table-column label="状态" width="120">
              <template #default="scope">
                <span class="baihou-chip" :class="scope.row.status === 'active' ? 'is-soft-green' : 'is-danger'">
                  {{ scope.row.status === "active" ? "启用" : "停用" }}
                </span>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="160">
              <template #default="scope">
                <el-button link type="primary" @click="handleEdit(scope.row)" v-hasPermi="['baihou:designer:edit']">编辑</el-button>
                <el-button link type="warning" @click="handleToggle(scope.row)" v-hasPermi="['baihou:designer:edit']">切换状态</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <el-dialog v-model="open" :title="title" width="640px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
        <div class="baihou-form-grid">
          <el-form-item label="姓名" prop="name">
            <el-input v-model="form.name" />
          </el-form-item>
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="form.phone" />
          </el-form-item>
          <el-form-item label="微信绑定号" prop="phoneHash">
            <el-input v-model="form.phoneHash" placeholder="微信手机号哈希（由系统或开发人员填入）" />
          </el-form-item>
          <el-form-item label="公司">
            <el-input v-model="form.company" />
          </el-form-item>
          <el-form-item label="分组 ID">
            <el-input-number v-model="form.groupId" :min="0" :controls="false" style="width: 100%" />
          </el-form-item>
          <el-form-item label="折扣">
            <el-input-number v-model="form.discount" :precision="2" :min="0" :max="1" :step="0.01" style="width: 100%" />
          </el-form-item>
          <el-form-item label="状态">
            <el-radio-group v-model="form.status">
              <el-radio value="active">启用</el-radio>
              <el-radio value="disabled">停用</el-radio>
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

<script setup name="BaihouDesigners">
import { addDesigner, listDesigners, toggleDesignerStatus, updateDesigner } from "@/api/baihou/designers"

const { proxy } = getCurrentInstance()
const loading = ref(false)
const open = ref(false)
const title = ref("")
const designerList = ref([])
const formRef = ref()
const form = reactive({
  designerId: undefined,
  name: "",
  phone: "",
  phoneHash: "",
  company: "",
  groupId: undefined,
  discount: 0.9,
  status: "active"
})

const rules = {
  name: [{ required: true, message: "请输入姓名", trigger: "blur" }],
  phoneHash: [{ required: true, message: "请输入微信绑定手机号哈希", trigger: "blur" }]
}

function getList() {
  loading.value = true
  listDesigners().then((res) => {
    designerList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function resetFormState() {
  Object.assign(form, {
    designerId: undefined,
    name: "",
    phone: "",
    phoneHash: "",
    company: "",
    groupId: undefined,
    discount: 0.9,
    status: "active"
  })
  proxy.resetForm("formRef")
}

function handleAdd() {
  resetFormState()
  title.value = "新增设计师"
  open.value = true
}

function handleEdit(row) {
  resetFormState()
  Object.assign(form, row)
  title.value = "编辑设计师"
  open.value = true
}

function handleToggle(row) {
  toggleDesignerStatus(row.designerId).then(() => {
    proxy.$modal.msgSuccess("状态已切换")
    getList()
  })
}

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    const request = form.designerId ? updateDesigner(form.designerId, { ...form }) : addDesigner({ ...form })
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
