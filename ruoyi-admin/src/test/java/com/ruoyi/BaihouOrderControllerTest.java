package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.controller.admin.BaihouOrderController;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;
import com.ruoyi.baihou.service.IBaihouOrderService;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class BaihouOrderControllerTest
{
    @Test
    void orderListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        Mockito.when(orderService.selectOrderList(Mockito.any(BaihouOrder.class)))
                .thenReturn(List.of(new BaihouOrder(1L, "ORD202603100001", "paid")));

        BaihouOrderController controller = new BaihouOrderController();
        ReflectionTestUtils.setField(controller, "orderService", orderService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/orders").param("regionId", "foshan").param("status", "paid"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].orderId").value(1L));

        ArgumentCaptor<BaihouOrder> captor = ArgumentCaptor.forClass(BaihouOrder.class);
        Mockito.verify(orderService).selectOrderList(captor.capture());
        assertEquals("foshan", captor.getValue().getRegionId());
        assertEquals("paid", captor.getValue().getStatus());
    }

    @Test
    void orderDetailShouldReturnAjaxResultData() throws Exception
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        Mockito.when(orderService.selectOrderById(1L)).thenReturn(new BaihouOrder(1L, "ORD202603100001", "processing"));

        BaihouOrderController controller = new BaihouOrderController();
        ReflectionTestUtils.setField(controller, "orderService", orderService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/orders/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.status").value("processing"));
    }

    @Test
    void orderUpdateShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        Mockito.when(orderService.updateOrder(Mockito.eq(1L), Mockito.any(BaihouOrderUpdateRequest.class))).thenReturn(1);

        BaihouOrderController controller = new BaihouOrderController();
        ReflectionTestUtils.setField(controller, "orderService", orderService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(patch("/admin/orders/1")
                .contentType("application/json")
                .content("{\"status\":\"shipped\",\"trackingNo\":\"SF123456789CN\",\"adminNote\":\"已发货\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }
}
