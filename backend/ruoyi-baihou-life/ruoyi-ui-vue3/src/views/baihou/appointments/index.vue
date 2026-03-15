<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Appointment</div>
        <h1 class="baihou-hero__title">预约管理</h1>
        <p class="baihou-hero__desc">用于后台确认、服务开始和完成流转。页面直接遵循预约状态机，避免任意状态跳变。</p>
      </section>

      <section class="baihou-panel">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">筛选条件</div>
            <div class="baihou-panel__desc">按区域和状态筛选预约单</div>
          </div>
        </div>
        <div class="baihou-panel__body">
          <div class="baihou-filter">
            <el-input v-model="queryParams.regionId" placeholder="区域 ID" clearable />
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
            <div class="baihou-panel__title">预约列表</div>
            <div class="baihou-panel__desc">支持负责人分配和服务进度流转</div>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="appointmentList">
            <el-table-column prop="appointmentNo" label="预约单号" min-width="180" />
            <el-table-column prop="customerName" label="客户" min-width="120" />
            <el-table-column prop="serviceType" label="服务类型" width="120" />
            <el-table-column prop="preferredDate" label="期望日期" min-width="120" />
            <el-table-column prop="regionId" label="区域" width="110" />
            <el-table-column label="状态" width="120">
              <template #default="scope">
                <span class="baihou-chip" :class="appointmentStatusClass(scope.row.status)">{{ appointmentStatusLabel(scope.row.status) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="assignedTo" label="负责人" width="100" />
            <el-table-column label="操作" width="120">
              <template #default="scope">
                <el-button link type="primary" @click="handleUpdate(scope.row)" v-hasPermi="['baihou:appointment:edit']">更新</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <el-dialog v-model="open" title="更新预约" width="520px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status">
            <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="负责人 ID">
          <el-input-number v-model="form.assignedTo" :controls="false" style="width: 100%" />
        </el-form-item>
        <el-form-item label="管理备注">
          <el-input v-model="form.adminNote" type="textarea" :rows="4" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="open = false">取消</el-button>
        <el-button type="primary" @click="submitForm">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="BaihouAppointments">
import { listAppointments, updateAppointment } from "@/api/baihou/appointments"

const { proxy } = getCurrentInstance()

const loading = ref(false)
const open = ref(false)
const formRef = ref()
const appointmentList = ref([])
const currentId = ref()
const queryParams = reactive({
  regionId: "",
  status: ""
})
const form = reactive({
  status: "pending",
  assignedTo: undefined,
  adminNote: ""
})

const rules = {
  status: [{ required: true, message: "请选择状态", trigger: "change" }]
}

const statusOptions = [
  { label: "待确认", value: "pending" },
  { label: "已确认", value: "confirmed" },
  { label: "进行中", value: "in_progress" },
  { label: "已完成", value: "completed" },
  { label: "已取消", value: "cancelled" }
]

function getList() {
  loading.value = true
  listAppointments(queryParams).then((res) => {
    appointmentList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function resetQuery() {
  Object.assign(queryParams, { regionId: "", status: "" })
  getList()
}

function handleUpdate(row) {
  currentId.value = row.appointmentId
  Object.assign(form, {
    status: row.status,
    assignedTo: row.assignedTo,
    adminNote: row.adminNote || ""
  })
  open.value = true
}

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) return
    updateAppointment(currentId.value, { ...form }).then(() => {
      proxy.$modal.msgSuccess("预约已更新")
      open.value = false
      getList()
    })
  })
}

function appointmentStatusLabel(status) {
  return statusOptions.find((item) => item.value === status)?.label || status
}

function appointmentStatusClass(status) {
  if (status === "confirmed" || status === "completed") {
    return "is-soft-green"
  }
  if (status === "cancelled") {
    return "is-danger"
  }
  return ""
}

onMounted(() => {
  getList()
})
</script>
