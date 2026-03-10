package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouMedia;
import com.ruoyi.baihou.controller.admin.BaihouProductController;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.service.IBaihouProductService;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.junit.jupiter.api.Assertions.assertEquals;

class BaihouProductControllerTest
{
    @Test
    void productListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        Mockito.when(productService.selectProductList(Mockito.any(BaihouProduct.class))).thenReturn(List.of(new BaihouProduct(1001L, "测试商品", "BH-001", "draft")));

        BaihouProductController controller = new BaihouProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/products"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].id").value(1001L))
                .andExpect(jsonPath("$.data[0].name").value("测试商品"));
    }

    @Test
    void productInfoShouldReturnAjaxResultData() throws Exception
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        BaihouProduct product = new BaihouProduct(1001L, "测试商品", "BH-001", "draft");
        product.setSceneImages(List.of(new BaihouMedia(5001L, "scene", "https://cdn.example.com/scene.jpg")));
        Mockito.when(productService.selectProductById(1001L)).thenReturn(product);

        BaihouProductController controller = new BaihouProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/products/1001"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.id").value(1001L))
                .andExpect(jsonPath("$.data.skuCode").value("BH-001"))
                .andExpect(jsonPath("$.data.sceneImages[0].mediaId").value(5001L));
    }

    @Test
    void productStatusShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        Mockito.when(productService.updateProductStatus(1001L, "on_shelf")).thenReturn(1);

        BaihouProductController controller = new BaihouProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/products/1001/status/on_shelf"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void productAddShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        Mockito.when(productService.insertProduct(Mockito.any(BaihouProduct.class))).thenReturn(1);

        BaihouProductController controller = new BaihouProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(post("/admin/products")
                .contentType("application/json")
                .content("{\"name\":\"测试商品\",\"skuCode\":\"BH-001\",\"categoryId\":4}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void productEditShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        Mockito.when(productService.updateProduct(Mockito.any(BaihouProduct.class))).thenReturn(1);

        BaihouProductController controller = new BaihouProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/products/1001")
                .contentType("application/json")
                .content("{\"name\":\"更新商品\",\"skuCode\":\"BH-001\",\"categoryId\":4}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void productRemoveShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        Mockito.when(productService.archiveProduct(1001L)).thenReturn(1);

        BaihouProductController controller = new BaihouProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(delete("/admin/products/1001"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void productBatchShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        Mockito.when(productService.batchUpdateProductStatus(Mockito.anyList(), Mockito.eq("off_shelf"))).thenReturn(2);

        BaihouProductController controller = new BaihouProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(post("/admin/products/batch")
                .contentType("application/json")
                .content("{\"ids\":[1001,1002],\"action\":\"off_shelf\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void productListShouldBindQueryFilters() throws Exception
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        Mockito.when(productService.selectProductList(Mockito.any(BaihouProduct.class))).thenReturn(List.of());

        BaihouProductController controller = new BaihouProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/products")
                .param("keyword", "瓷砖")
                .param("categoryId", "4")
                .param("regionId", "chengdu")
                .param("status", "draft"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        ArgumentCaptor<BaihouProduct> captor = ArgumentCaptor.forClass(BaihouProduct.class);
        Mockito.verify(productService).selectProductList(captor.capture());
        assertEquals("瓷砖", captor.getValue().getKeyword());
        assertEquals(Long.valueOf(4L), captor.getValue().getCategoryId());
        assertEquals("chengdu", captor.getValue().getRegionId());
        assertEquals("draft", captor.getValue().getStatus());
    }
}
