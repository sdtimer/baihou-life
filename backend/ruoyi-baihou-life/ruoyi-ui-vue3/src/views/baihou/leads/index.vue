<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Lead</div>
        <h1 class="baihou-hero__title">线索管理</h1>
        <p class="baihou-hero__desc">用于留资筛选、分配和状态转化，列表默认显示脱敏手机号，并支持按当前筛选条件导出 CSV。</p>
      </section>

      <section class="baihou-panel">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">筛选条件</div>
            <div class="baihou-panel__desc">支持区域、品类、状态、负责人和日期范围</div>
          </div>
        </div>
        <div class="baihou-panel__body">
          <div class="baihou-filter">
            <el-input v-model="queryParams.regionId" placeholder="区域 ID" clearable />
            <el-input-number v-model="queryParams.categoryId" :controls="false" placeholder="品类 ID" style="width: 100%" />
            <el-select v-model="queryParams.status" placeholder="状态" clearable>
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
            <el-input-number v-model="queryParams.assignedTo" :controls="false" placeholder="负责人 ID" style="width: 100%" />
            <el-date-picker v-model="dateRange" type="daterange" value-format="YYYY-MM-DD HH:mm:ss" start-placeholder="开始时间" end-placeholder="结束时间" />
          </div>
          <div class="baihou-toolbar" style="margin-top: 14px">
            <el-button type="primary" @click="getList">搜索</el-button>
            <el-button @click="resetQuery">重置</el-button>
            <el-button type="success" @click="handleExport" v-hasPermi="['baihou:lead:export']">导出筛选结果</el-button>
          </div>
        </div>
      </section>

      <section class="baihou-panel baihou-table">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">线索列表</div>
            <div class="baihou-panel__desc">严格按状态机进行流转</div>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="leadList">
            <el-table-column prop="leadId" label="线索 ID" width="100" />
            <el-table-column prop="name" label="客户称呼" min-width="120" />
            <el-table-column prop="phone" label="手机号" min-width="140" />
            <el-table-column prop="productName" label="商品" min-width="180" show-overflow-tooltip />
            <el-table-column prop="regionId" label="区域" width="120" />
            <el-table-column label="状态" width="120">
              <template #default="scope">
                <span class="baihou-chip" :class="leadStatusClass(scope.row.status)">{{ leadStatusLabel(scope.row.status) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="assignedTo" label="负责人" width="100" />
            <el-table-column label="跟进备注" min-width="220" show-overflow-tooltip>
              <template #default="scope">
                {{ scope.row.followNote || "--" }}
              </template>
            </el-table-column>
            <el-table-column label="操作" width="120">
              <template #default="scope">
                <el-button link type="primary" @click="handleUpdate(scope.row)" v-hasPermi="['baihou:lead:edit']">更新</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <el-dialog v-model="open" title="更新线索" width="520px" append-to-body>
      <el-form ref="formRef" :model="form" label-width="90px">
        <el-form-item label="状态">
          <el-select v-model="form.status">
            <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="负责人 ID">
          <el-input-number v-model="form.assignedTo" :controls="false" style="width: 100%" />
        </el-form-item>
        <el-form-item label="跟进备注">
          <el-input v-model="form.followNote" type="textarea" :rows="4" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="open = false">取消</el-button>
        <el-button type="primary" @click="submitForm">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="BaihouLeads">
import { exportLeads, listLeads, updateLead } from "@/api/baihou/leads"

const { proxy } = getCurrentInstance()

const loading = ref(false)
const open = ref(false)
const leadList = ref([])
const currentLeadId = ref()
const dateRange = ref([])
const form = reactive({
  status: "following",
  assignedTo: undefined,
  followNote: ""
})
const queryParams = reactive({
  regionId: "",
  categoryId: undefined,
  status: "",
  assignedTo: undefined,
  startDate: "",
  endDate: ""
})

const statusOptions = [
  { label: "新线索", value: "new" },
  { label: "跟进中", value: "following" },
  { label: "已成单", value: "converted" },
  { label: "已放弃", value: "abandoned" }
]

watch(dateRange, (val) => {
  queryParams.startDate = val?.[0] || ""
  queryParams.endDate = val?.[1] || ""
})

function getList() {
  loading.value = true
  listLeads(queryParams).then((res) => {
    leadList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function resetQuery() {
  Object.assign(queryParams, {
    regionId: "",
    categoryId: undefined,
    status: "",
    assignedTo: undefined,
    startDate: "",
    endDate: ""
  })
  dateRange.value = []
  getList()
}

function handleUpdate(row) {
  currentLeadId.value = row.leadId
  Object.assign(form, {
    status: row.status,
    assignedTo: row.assignedTo,
    followNote: row.followNote || ""
  })
  open.value = true
}

function submitForm() {
  updateLead(currentLeadId.value, { ...form }).then(() => {
    proxy.$modal.msgSuccess("线索已更新")
    open.value = false
    getList()
  })
}

function handleExport() {
  exportLeads(queryParams).then((res) => {
    const rows = res.data || []
    const headers = ["线索ID", "客户称呼", "手机号", "商品", "区域", "状态", "负责人", "备注"]
    const lines = rows.map((item) => [
      item.leadId,
      item.name || "",
      item.phone || "",
      item.productName || "",
      item.regionId || "",
      leadStatusLabel(item.status),
      item.assignedTo || "",
      (item.followNote || "").replaceAll(",", "，")
    ].join(","))
    const blob = new Blob([[headers.join(","), ...lines].join("\n")], { type: "text/csv;charset=utf-8;" })
    const link = document.createElement("a")
    link.href = URL.createObjectURL(blob)
    link.download = "baihou-leads.csv"
    link.click()
    URL.revokeObjectURL(link.href)
  })
}

function leadStatusLabel(status) {
  return statusOptions.find((item) => item.value === status)?.label || status
}

function leadStatusClass(status) {
  if (status === "following" || status === "converted") {
    return "is-soft-green"
  }
  if (status === "abandoned") {
    return "is-danger"
  }
  return ""
}

onMounted(() => {
  getList()
})
</script>
