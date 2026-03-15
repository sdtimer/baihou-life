package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouBanner;
import com.ruoyi.baihou.mapper.BaihouBannerMapper;
import com.ruoyi.baihou.service.impl.BaihouBannerServiceImpl;
import com.ruoyi.common.exception.ServiceException;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class BaihouBannerServiceImplTest
{
    @Test
    void bannerListShouldDelegateToMapper()
    {
        BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
        List<BaihouBanner> expected = List.of(new BaihouBanner(1L, "首页推荐", "https://cdn.example.com/banner.jpg"));
        Mockito.when(bannerMapper.selectBannerList()).thenReturn(expected);

        BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
        ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

        assertEquals(expected, service.selectBannerList());
    }

    @Test
    void bannerInsertShouldDelegateToMapper()
    {
        BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
        Mockito.when(bannerMapper.insertBanner(Mockito.any(BaihouBanner.class))).thenReturn(1);

        BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
        ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

        assertEquals(1, service.insertBanner(new BaihouBanner()));
    }

    @Test
    void bannerUpdateShouldDelegateToMapper()
    {
        BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
        Mockito.when(bannerMapper.updateBanner(Mockito.any(BaihouBanner.class))).thenReturn(1);

        BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
        ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

        BaihouBanner banner = new BaihouBanner(1L, "首页推荐更新", "https://cdn.example.com/banner.jpg");
        assertEquals(1, service.updateBanner(banner));
    }

    @Test
    void bannerDeleteShouldDelegateToMapper()
    {
        BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
        Mockito.when(bannerMapper.deleteBanner(1L)).thenReturn(1);

        BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
        ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

        assertEquals(1, service.deleteBanner(1L));
    }

    @Test
    void bannerInsertShouldRejectAllMixedWithSpecificRegions()
    {
        BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
        BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
        ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

        BaihouBanner banner = new BaihouBanner();
        banner.setRegions("[\"ALL\", \"chengdu\"]");

        assertThrows(ServiceException.class, () -> service.insertBanner(banner));
    }

    @Test
    void bannerInsertShouldRejectEndTimeBeforeStartTime()
    {
        BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
        BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
        ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

        BaihouBanner banner = new BaihouBanner();
        banner.setTitle("测试");
        banner.setImageUrl("https://cdn.example.com/a.jpg");
        banner.setStartTime(new java.util.Date(System.currentTimeMillis() + 3600_000)); // 1 hour later
        banner.setEndTime(new java.util.Date(System.currentTimeMillis()));              // now (BEFORE start)

        assertThrows(com.ruoyi.common.exception.ServiceException.class,
            () -> service.insertBanner(banner),
            "end before start should throw ServiceException");
    }

    @Test
    void bannerUpdateShouldRejectEndTimeEqualToStartTime()
    {
        BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
        BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
        ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

        long now = System.currentTimeMillis();
        BaihouBanner banner = new BaihouBanner();
        banner.setBannerId(1L);
        banner.setTitle("测试");
        banner.setImageUrl("https://cdn.example.com/a.jpg");
        banner.setStartTime(new java.util.Date(now));
        banner.setEndTime(new java.util.Date(now));  // equal → should also fail

        assertThrows(com.ruoyi.common.exception.ServiceException.class,
            () -> service.updateBanner(banner),
            "end equal to start should throw ServiceException");
    }

    @Test
    void bannerInsertShouldAllowNullTimes()
    {
        BaihouBannerMapper bannerMapper = Mockito.mock(BaihouBannerMapper.class);
        Mockito.when(bannerMapper.insertBanner(Mockito.any())).thenReturn(1);
        BaihouBannerServiceImpl service = new BaihouBannerServiceImpl();
        ReflectionTestUtils.setField(service, "bannerMapper", bannerMapper);

        BaihouBanner banner = new BaihouBanner();
        banner.setTitle("测试");
        banner.setImageUrl("https://cdn.example.com/a.jpg");
        // startTime and endTime both null → should pass without exception
        assertEquals(1, service.insertBanner(banner));
    }
}
