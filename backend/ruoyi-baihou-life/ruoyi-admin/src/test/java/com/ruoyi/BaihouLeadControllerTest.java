package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.controller.admin.BaihouLeadController;
import com.ruoyi.baihou.dto.BaihouLeadUpdateRequest;
import com.ruoyi.baihou.service.IBaihouLeadService;
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

class BaihouLeadControllerTest
{
    @Test
    void leadListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouLeadService leadService = Mockito.mock(IBaihouLeadService.class);
        Mockito.when(leadService.selectLeadList(Mockito.any(BaihouLead.class))).thenReturn(List.of(new BaihouLead(1L, "foshan", "new")));

        BaihouLeadController controller = new BaihouLeadController();
        ReflectionTestUtils.setField(controller, "leadService", leadService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/leads")
                .param("regionId", "foshan")
                .param("status", "new")
                .param("categoryId", "10")
                .param("assignedTo", "2001")
                .param("startDate", "2026-03-01 00:00:00")
                .param("endDate", "2026-03-10 23:59:59"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].leadId").value(1L));

        ArgumentCaptor<BaihouLead> captor = ArgumentCaptor.forClass(BaihouLead.class);
        Mockito.verify(leadService).selectLeadList(captor.capture());
        assertEquals("foshan", captor.getValue().getRegionId());
        assertEquals("new", captor.getValue().getStatus());
        assertEquals(10L, captor.getValue().getCategoryId());
        assertEquals(2001L, captor.getValue().getAssignedTo());
        assertEquals("2026-03-01 00:00:00", captor.getValue().getStartDate());
        assertEquals("2026-03-10 23:59:59", captor.getValue().getEndDate());
    }

    @Test
    void leadUpdateShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouLeadService leadService = Mockito.mock(IBaihouLeadService.class);
        Mockito.when(leadService.updateLead(Mockito.eq(1L), Mockito.any(BaihouLeadUpdateRequest.class))).thenReturn(1);

        BaihouLeadController controller = new BaihouLeadController();
        ReflectionTestUtils.setField(controller, "leadService", leadService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(patch("/admin/leads/1")
                .contentType("application/json")
                .content("{\"status\":\"following\",\"assignedTo\":2001,\"followNote\":\"已联系客户\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void leadExportShouldReturnAjaxResultData() throws Exception
    {
        IBaihouLeadService leadService = Mockito.mock(IBaihouLeadService.class);
        Mockito.when(leadService.exportLeadList(Mockito.any(BaihouLead.class))).thenReturn(List.of(new BaihouLead(1L, "foshan", "following")));

        BaihouLeadController controller = new BaihouLeadController();
        ReflectionTestUtils.setField(controller, "leadService", leadService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/leads/export").param("regionId", "foshan"))
                .andExpect(status().isOk())
                .andExpect(result -> {
                    String contentType = result.getResponse().getContentType();
                    if (contentType == null || !contentType.contains("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                    {
                        throw new AssertionError("Expected Excel content type but was: " + contentType);
                    }
                });
    }
}
