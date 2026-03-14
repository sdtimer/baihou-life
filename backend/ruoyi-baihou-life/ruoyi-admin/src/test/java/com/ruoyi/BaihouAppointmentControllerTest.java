package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.controller.admin.BaihouAppointmentController;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;
import com.ruoyi.baihou.service.IBaihouAppointmentService;
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

class BaihouAppointmentControllerTest
{
    @Test
    void appointmentListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouAppointmentService appointmentService = Mockito.mock(IBaihouAppointmentService.class);
        Mockito.when(appointmentService.selectAppointmentList(Mockito.any(BaihouAppointment.class)))
                .thenReturn(List.of(new BaihouAppointment(1L, "APT202603100001", "pending")));

        BaihouAppointmentController controller = new BaihouAppointmentController();
        ReflectionTestUtils.setField(controller, "appointmentService", appointmentService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/appointments").param("regionId", "foshan").param("status", "pending"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].appointmentId").value(1L));

        ArgumentCaptor<BaihouAppointment> captor = ArgumentCaptor.forClass(BaihouAppointment.class);
        Mockito.verify(appointmentService).selectAppointmentList(captor.capture());
        assertEquals("foshan", captor.getValue().getRegionId());
        assertEquals("pending", captor.getValue().getStatus());
    }

    @Test
    void appointmentUpdateShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouAppointmentService appointmentService = Mockito.mock(IBaihouAppointmentService.class);
        Mockito.when(appointmentService.updateAppointment(Mockito.eq(1L), Mockito.any(BaihouAppointmentUpdateRequest.class)))
                .thenReturn(1);

        BaihouAppointmentController controller = new BaihouAppointmentController();
        ReflectionTestUtils.setField(controller, "appointmentService", appointmentService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(patch("/admin/appointments/1")
                .contentType("application/json")
                .content("{\"status\":\"confirmed\",\"assignedTo\":3001,\"adminNote\":\"已联系确认\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }
}
