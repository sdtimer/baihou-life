package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.controller.admin.BaihouDesignerController;
import com.ruoyi.baihou.domain.BaihouDesigner;
import com.ruoyi.baihou.service.IBaihouDesignerService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class BaihouDesignerControllerTest
{
    @Test
    void designerListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouDesignerService designerService = Mockito.mock(IBaihouDesignerService.class);
        Mockito.when(designerService.selectDesignerList()).thenReturn(List.of(new BaihouDesigner(1L, "张三", "13900005678")));

        BaihouDesignerController controller = new BaihouDesignerController();
        ReflectionTestUtils.setField(controller, "designerService", designerService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/designers"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].designerId").value(1L))
                .andExpect(jsonPath("$.data[0].name").value("张三"));
    }

    @Test
    void designerAddShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouDesignerService designerService = Mockito.mock(IBaihouDesignerService.class);
        Mockito.when(designerService.insertDesigner(Mockito.any(BaihouDesigner.class))).thenReturn(1);

        BaihouDesignerController controller = new BaihouDesignerController();
        ReflectionTestUtils.setField(controller, "designerService", designerService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(post("/admin/designers")
                .contentType("application/json")
                .content("{\"name\":\"张三\",\"phone\":\"13900005678\",\"phoneHash\":\"hash-13900005678\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void designerEditShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouDesignerService designerService = Mockito.mock(IBaihouDesignerService.class);
        Mockito.when(designerService.updateDesigner(Mockito.any(BaihouDesigner.class))).thenReturn(1);

        BaihouDesignerController controller = new BaihouDesignerController();
        ReflectionTestUtils.setField(controller, "designerService", designerService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/designers/1")
                .contentType("application/json")
                .content("{\"name\":\"张三更新\",\"phone\":\"13900005678\",\"phoneHash\":\"hash-13900005678\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void designerToggleShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouDesignerService designerService = Mockito.mock(IBaihouDesignerService.class);
        Mockito.when(designerService.toggleDesignerStatus(1L)).thenReturn(1);

        BaihouDesignerController controller = new BaihouDesignerController();
        ReflectionTestUtils.setField(controller, "designerService", designerService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(patch("/admin/designers/1/toggle"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }
}
