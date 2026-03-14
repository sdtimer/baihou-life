package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.controller.admin.BaihouDesignerGroupController;
import com.ruoyi.baihou.domain.BaihouDesignerGroup;
import com.ruoyi.baihou.service.IBaihouDesignerGroupService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class BaihouDesignerGroupControllerTest
{
    @Test
    void groupListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouDesignerGroupService groupService = Mockito.mock(IBaihouDesignerGroupService.class);
        Mockito.when(groupService.selectGroupList()).thenReturn(List.of(new BaihouDesignerGroup(1L, "核心设计师")));

        BaihouDesignerGroupController controller = new BaihouDesignerGroupController();
        ReflectionTestUtils.setField(controller, "designerGroupService", groupService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/designer-groups"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].groupId").value(1L));
    }

    @Test
    void groupAddShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouDesignerGroupService groupService = Mockito.mock(IBaihouDesignerGroupService.class);
        Mockito.when(groupService.insertGroup(Mockito.any(BaihouDesignerGroup.class))).thenReturn(1);

        BaihouDesignerGroupController controller = new BaihouDesignerGroupController();
        ReflectionTestUtils.setField(controller, "designerGroupService", groupService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(post("/admin/designer-groups")
                .contentType("application/json")
                .content("{\"groupName\":\"核心设计师\",\"defaultDiscount\":0.90}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void groupEditShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouDesignerGroupService groupService = Mockito.mock(IBaihouDesignerGroupService.class);
        Mockito.when(groupService.updateGroup(Mockito.any(BaihouDesignerGroup.class))).thenReturn(1);

        BaihouDesignerGroupController controller = new BaihouDesignerGroupController();
        ReflectionTestUtils.setField(controller, "designerGroupService", groupService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/designer-groups/1")
                .contentType("application/json")
                .content("{\"groupName\":\"核心设计师更新\",\"defaultDiscount\":0.88}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }
}
