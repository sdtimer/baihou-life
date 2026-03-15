<template>
  <div class="baihou-page">
    <div class="baihou-shell">
      <section class="baihou-hero">
        <div class="baihou-hero__eyebrow">Baihou Life / Order</div>
        <h1 class="baihou-hero__title">订单管理</h1>
        <p class="baihou-hero__desc">订单页覆盖后台确认处理、发货、关闭和详情查看，同时支持后续 Quartz 自动关单和自动收货的人工校验。</p>
      </section>

      <section class="baihou-panel">
        <div class="baihou-panel__head">
          <div>
            <div class="baihou-panel__title">筛选条件</div>
            <div class="baihou-panel__desc">按区域与状态定位订单</div>
          </div>
        </div>
        <div class="baihou-panel__body">
          <div class="baihou-filter">
            <el-select v-model="queryParams.regionId" placeholder="区域" clearable>
              <el-option v-for="item in regionOptions" :key="item.value" :label="item.label" :value="item.value" />
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
            <div class="baihou-panel__title">订单列表</div>
            <div class="baihou-panel__desc">支持详情、物流单号维护和状态流转</div>
          </div>
        </div>
        <div class="baihou-panel__body">
          <el-table v-loading="loading" :data="orderList">
            <el-table-column prop="orderNo" label="订单号" min-width="180" />
            <el-table-column prop="regionId" label="区域" width="110" />
            <el-table-column prop="payAmount" label="实付金额" width="120" />
            <el-table-column label="状态" width="120">
              <template #default="scope">
                <span class="baihou-chip" :class="orderStatusClass(scope.row.status)">{{ orderStatusLabel(scope.row.status) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="trackingNo" label="物流单号" min-width="150" show-overflow-tooltip />
            <el-table-column label="操作" width="160">
              <template #default="scope">
                <el-button link type="primary" @click="showDetail(scope.row)">详情</el-button>
                <el-button link type="primary" @click="handleUpdate(scope.row)" v-hasPermi="['baihou:order:edit']">更新</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </section>
    </div>

    <el-dialog v-model="open" title="更新订单" width="520px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="orderUpdateRules" label-width="90px">
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status">
            <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="物流单号" prop="trackingNo">
          <el-input v-model="form.trackingNo" placeholder="发货状态下必填" />
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

    <el-drawer v-model="detailOpen" title="订单详情" size="560px">
      <div v-if="detailData" class="baihou-shell">
        <div class="baihou-drawer-summary">
          <div class="baihou-drawer-card">
            <div class="baihou-drawer-card__label">订单号</div>
            <div class="baihou-drawer-card__value">{{ detailData.orderNo }}</div>
          </div>
          <div class="baihou-drawer-card">
            <div class="baihou-drawer-card__label">状态</div>
            <div class="baihou-drawer-card__value">{{ orderStatusLabel(detailData.status) }}</div>
          </div>
          <div class="baihou-drawer-card">
            <div class="baihou-drawer-card__label">支付金额</div>
            <div class="baihou-drawer-card__value">{{ detailData.payAmount }}</div>
          </div>
          <div class="baihou-drawer-card">
            <div class="baihou-drawer-card__label">物流单号</div>
            <div class="baihou-drawer-card__value">{{ detailData.trackingNo || "--" }}</div>
          </div>
        </div>
        <div class="baihou-drawer-card">
          <div class="baihou-drawer-card__label">管理备注</div>
          <div class="baihou-drawer-card__value">{{ detailData.adminNote || "暂无备注" }}</div>
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<script setup name="BaihouOrders">
import { getOrder, listOrders, updateOrder } from "@/api/baihou/orders"
import { getRegionOptions } from "@/api/baihou/regions"

const { proxy } = getCurrentInstance()

const loading = ref(false)
const regionOptions = ref([])
const open = ref(false)
const formRef = ref()
const detailOpen = ref(false)
const orderList = ref([])
const detailData = ref()
const currentId = ref()
const queryParams = reactive({
  regionId: "",
  status: ""
})
const form = reactive({
  status: "processing",
  trackingNo: "",
  adminNote: ""
})

const orderUpdateRules = computed(() => ({
  status: [{ required: true, message: "请选择状态", trigger: "change" }],
  trackingNo: form.status === "shipped"
    ? [{ required: true, message: "发货状态下物流单号必填", trigger: "blur" }]
    : []
}))

const statusOptions = [
  { label: "待支付", value: "pending_pay" },
  { label: "已支付", value: "paid" },
  { label: "处理中", value: "processing" },
  { label: "已发货", value: "shipped" },
  { label: "已完成", value: "completed" },
  { label: "已关闭", value: "closed" }
]

function getList() {
  loading.value = true
  listOrders(queryParams).then((res) => {
    orderList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

function resetQuery() {
  Object.assign(queryParams, { regionId: "", status: "" })
  getList()
}

function handleUpdate(row) {
  currentId.value = row.orderId
  Object.assign(form, {
    status: row.status,
    trackingNo: row.trackingNo || "",
    adminNote: row.adminNote || ""
  })
  open.value = true
}

function submitForm() {
  formRef.value.validate((valid) => {
    if (!valid) return
    updateOrder(currentId.value, { ...form }).then(() => {
      proxy.$modal.msgSuccess("订单已更新")
      open.value = false
      getList()
    })
  })
}

function showDetail(row) {
  getOrder(row.orderId).then((res) => {
    detailData.value = res.data
    detailOpen.value = true
  })
}

function orderStatusLabel(status) {
  return statusOptions.find((item) => item.value === status)?.label || status
}

function orderStatusClass(status) {
  if (status === "processing" || status === "shipped" || status === "completed") {
    return "is-soft-green"
  }
  if (status === "closed") {
    return "is-danger"
  }
  return ""
}

onMounted(() => {
  getRegionOptions().then((res) => {
    regionOptions.value = res.data || []
  })
  getList()
})
</script>
