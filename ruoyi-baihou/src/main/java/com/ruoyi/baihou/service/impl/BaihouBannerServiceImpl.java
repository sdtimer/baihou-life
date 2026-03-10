package com.ruoyi.baihou.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baihou.domain.BaihouBanner;
import com.ruoyi.baihou.mapper.BaihouBannerMapper;
import com.ruoyi.baihou.service.IBaihouBannerService;

/**
 * Baihou banner service implementation.
 */
@Service
public class BaihouBannerServiceImpl implements IBaihouBannerService
{
    @Autowired
    private BaihouBannerMapper bannerMapper;

    @Override
    public List<BaihouBanner> selectBannerList()
    {
        return bannerMapper.selectBannerList();
    }

    @Override
    public int insertBanner(BaihouBanner banner)
    {
        if (banner.getIsActive() == null)
        {
            banner.setIsActive(1);
        }
        return bannerMapper.insertBanner(banner);
    }

    @Override
    public int updateBanner(BaihouBanner banner)
    {
        return bannerMapper.updateBanner(banner);
    }

    @Override
    public int deleteBanner(Long bannerId)
    {
        return bannerMapper.deleteBanner(bannerId);
    }
}
