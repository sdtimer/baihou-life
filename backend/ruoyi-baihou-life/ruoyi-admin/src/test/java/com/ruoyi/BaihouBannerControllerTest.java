package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.controller.admin.BaihouBannerController;
import com.ruoyi.baihou.domain.BaihouBanner;
import com.ruoyi.baihou.service.IBaihouBannerService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class BaihouBannerControllerTest
{
    @Test
    void bannerListShouldReturnAjaxResultData() throws Exception
    {
        IBaihouBannerService bannerService = Mockito.mock(IBaihouBannerService.class);
        Mockito.when(bannerService.selectBannerList()).thenReturn(List.of(new BaihouBanner(1L, "首页推荐", "https://cdn.example.com/banner.jpg")));

        BaihouBannerController controller = new BaihouBannerController();
        ReflectionTestUtils.setField(controller, "bannerService", bannerService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(get("/admin/banners"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data[0].bannerId").value(1L))
                .andExpect(jsonPath("$.data[0].title").value("首页推荐"));
    }

    @Test
    void bannerAddShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouBannerService bannerService = Mockito.mock(IBaihouBannerService.class);
        Mockito.when(bannerService.insertBanner(Mockito.any(BaihouBanner.class))).thenReturn(1);

        BaihouBannerController controller = new BaihouBannerController();
        ReflectionTestUtils.setField(controller, "bannerService", bannerService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(post("/admin/banners")
                .contentType("application/json")
                .content("{\"title\":\"首页推荐\",\"imageUrl\":\"https://cdn.example.com/banner.jpg\",\"linkType\":\"url\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void bannerEditShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouBannerService bannerService = Mockito.mock(IBaihouBannerService.class);
        Mockito.when(bannerService.updateBanner(Mockito.any(BaihouBanner.class))).thenReturn(1);

        BaihouBannerController controller = new BaihouBannerController();
        ReflectionTestUtils.setField(controller, "bannerService", bannerService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(put("/admin/banners/1")
                .contentType("application/json")
                .content("{\"title\":\"首页推荐更新\",\"imageUrl\":\"https://cdn.example.com/banner.jpg\",\"linkType\":\"url\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    @Test
    void bannerRemoveShouldReturnSuccessAjaxResult() throws Exception
    {
        IBaihouBannerService bannerService = Mockito.mock(IBaihouBannerService.class);
        Mockito.when(bannerService.deleteBanner(1L)).thenReturn(1);

        BaihouBannerController controller = new BaihouBannerController();
        ReflectionTestUtils.setField(controller, "bannerService", bannerService);
        MockMvc mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        mockMvc.perform(delete("/admin/banners/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }
}
