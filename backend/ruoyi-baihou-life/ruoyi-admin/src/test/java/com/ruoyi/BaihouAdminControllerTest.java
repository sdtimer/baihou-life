package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.controller.admin.BaihouCategoryController;
import com.ruoyi.baihou.controller.admin.BaihouRegionController;
import com.ruoyi.baihou.domain.BaihouCategory;
import com.ruoyi.baihou.domain.BaihouRegion;
import com.ruoyi.baihou.service.IBaihouCategoryService;
import com.ruoyi.baihou.service.IBaihouRegionService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class BaihouAdminControllerTest
{
    @Test
    void categoryListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouCategoryService categoryService = Mockito.mock(IBaihouCategoryService.class);
        Mockito.when(categoryService.selectCategoryList()).thenReturn(List.of(new BaihouCategory(1L, "客厅")));

        BaihouCategoryController controller = new BaihouCategoryController();
        ReflectionTestUtils.setField(controller, "categoryService", categoryService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/categories/list").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].categoryId").value(1L))
                .andExpect(jsonPath("$.data[0].categoryName").value("客厅"));
    }

    @Test
    void categoryAddShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouCategoryService categoryService = Mockito.mock(IBaihouCategoryService.class);
        Mockito.when(categoryService.insertCategory(Mockito.any(BaihouCategory.class))).thenReturn(1);

        BaihouCategoryController controller = new BaihouCategoryController();
        ReflectionTestUtils.setField(controller, "categoryService", categoryService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(post("/admin/categories")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"parentId\":0,\"categoryName\":\"卫浴\",\"sortOrder\":40,\"isActive\":1}")
                        .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void categoryInfoShouldReturnAjaxResultData() throws Exception
    {
        IBaihouCategoryService categoryService = Mockito.mock(IBaihouCategoryService.class);
        Mockito.when(categoryService.selectCategoryById(1L)).thenReturn(new BaihouCategory(1L, "主材"));

        BaihouCategoryController controller = new BaihouCategoryController();
        ReflectionTestUtils.setField(controller, "categoryService", categoryService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/categories/1").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.categoryId").value(1L))
                .andExpect(jsonPath("$.data.categoryName").value("主材"));
    }

    @Test
    void categoryEditShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouCategoryService categoryService = Mockito.mock(IBaihouCategoryService.class);
        Mockito.when(categoryService.updateCategory(Mockito.any(BaihouCategory.class))).thenReturn(1);

        BaihouCategoryController controller = new BaihouCategoryController();
        ReflectionTestUtils.setField(controller, "categoryService", categoryService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/categories")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"categoryId\":1,\"parentId\":0,\"categoryName\":\"主材馆\",\"sortOrder\":10,\"isActive\":1}")
                        .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void categoryStatusShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouCategoryService categoryService = Mockito.mock(IBaihouCategoryService.class);
        Mockito.when(categoryService.updateCategoryStatus(1L, 0)).thenReturn(1);

        BaihouCategoryController controller = new BaihouCategoryController();
        ReflectionTestUtils.setField(controller, "categoryService", categoryService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/categories/1/status/0"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void regionListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouRegionService regionService = Mockito.mock(IBaihouRegionService.class);
        Mockito.when(regionService.selectRegionList()).thenReturn(List.of(new BaihouRegion("shanghai", "上海")));

        BaihouRegionController controller = new BaihouRegionController();
        ReflectionTestUtils.setField(controller, "regionService", regionService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/regions/list").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].regionId").value("shanghai"))
                .andExpect(jsonPath("$.data[0].regionName").value("上海"));
    }

    @Test
    void regionInfoShouldReturnAjaxResultData() throws Exception
    {
        IBaihouRegionService regionService = Mockito.mock(IBaihouRegionService.class);
        Mockito.when(regionService.selectRegionById("shanghai")).thenReturn(new BaihouRegion("shanghai", "上海"));

        BaihouRegionController controller = new BaihouRegionController();
        ReflectionTestUtils.setField(controller, "regionService", regionService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/regions/shanghai").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.regionId").value("shanghai"))
                .andExpect(jsonPath("$.data.regionName").value("上海"));
    }

    @Test
    void regionAddShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouRegionService regionService = Mockito.mock(IBaihouRegionService.class);
        Mockito.when(regionService.insertRegion(Mockito.any(BaihouRegion.class))).thenReturn(1);

        BaihouRegionController controller = new BaihouRegionController();
        ReflectionTestUtils.setField(controller, "regionService", regionService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(post("/admin/regions")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"regionId\":\"hangzhou\",\"regionName\":\"杭州\",\"province\":\"浙江\",\"isActive\":1,\"sortOrder\":40}")
                        .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void regionEditShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouRegionService regionService = Mockito.mock(IBaihouRegionService.class);
        Mockito.when(regionService.updateRegion(Mockito.any(BaihouRegion.class))).thenReturn(1);

        BaihouRegionController controller = new BaihouRegionController();
        ReflectionTestUtils.setField(controller, "regionService", regionService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/regions")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"regionId\":\"shanghai\",\"regionName\":\"上海市\",\"province\":\"上海\",\"isActive\":1,\"sortOrder\":10}")
                        .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void regionStatusShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouRegionService regionService = Mockito.mock(IBaihouRegionService.class);
        Mockito.when(regionService.updateRegionStatus("shanghai", 0)).thenReturn(1);

        BaihouRegionController controller = new BaihouRegionController();
        ReflectionTestUtils.setField(controller, "regionService", regionService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/regions/shanghai/status/0"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }
}
