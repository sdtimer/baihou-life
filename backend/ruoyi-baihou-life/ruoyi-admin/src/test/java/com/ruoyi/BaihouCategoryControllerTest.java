package com.ruoyi;

import com.ruoyi.baihou.controller.admin.BaihouCategoryController;
import com.ruoyi.baihou.service.IBaihouCategoryService;
import com.ruoyi.baihou.service.IBaihouCategorySpecDefService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class BaihouCategoryControllerTest
{
    @Test
    void specDefSortShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouCategoryService categoryService = Mockito.mock(IBaihouCategoryService.class);
        IBaihouCategorySpecDefService specDefService = Mockito.mock(IBaihouCategorySpecDefService.class);
        Mockito.when(specDefService.updateSpecDefSort(Mockito.eq(4L), Mockito.anyList())).thenReturn(2);

        BaihouCategoryController controller = new BaihouCategoryController();
        ReflectionTestUtils.setField(controller, "categoryService", categoryService);
        ReflectionTestUtils.setField(controller, "specDefService", specDefService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/categories/4/spec-defs/sort")
                .contentType("application/json")
                .content("[{\"specDefId\":1,\"sortOrder\":10},{\"specDefId\":2,\"sortOrder\":20}]"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void emptySpecDefSortShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouCategoryService categoryService = Mockito.mock(IBaihouCategoryService.class);
        IBaihouCategorySpecDefService specDefService = Mockito.mock(IBaihouCategorySpecDefService.class);

        BaihouCategoryController controller = new BaihouCategoryController();
        ReflectionTestUtils.setField(controller, "categoryService", categoryService);
        ReflectionTestUtils.setField(controller, "specDefService", specDefService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/categories/4/spec-defs/sort")
                .contentType("application/json")
                .content("[]"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        Mockito.verify(specDefService, Mockito.never()).updateSpecDefSort(Mockito.anyLong(), Mockito.anyList());
    }
}
