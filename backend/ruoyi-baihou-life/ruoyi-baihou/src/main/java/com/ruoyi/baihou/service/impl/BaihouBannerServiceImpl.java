package com.ruoyi.baihou.service.impl;

import java.util.Objects;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.baihou.domain.BaihouBanner;
import com.ruoyi.baihou.mapper.BaihouBannerMapper;
import com.ruoyi.baihou.service.IBaihouBannerService;
import com.ruoyi.common.exception.ServiceException;

/**
 * Baihou banner service implementation.
 */
@Service
@Transactional(rollbackFor = Exception.class)
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
        validateRegions(banner);
        return bannerMapper.insertBanner(banner);
    }

    @Override
    public int updateBanner(BaihouBanner banner)
    {
        validateRegions(banner);
        return bannerMapper.updateBanner(banner);
    }

    @Override
    public int deleteBanner(Long bannerId)
    {
        return bannerMapper.deleteBanner(bannerId);
    }

    private void validateRegions(BaihouBanner banner)
    {
        if (banner == null || banner.getRegions() == null)
        {
            return;
        }
        String normalized = banner.getRegions().replace(" ", "");
        if (normalized.contains("\"ALL\"") && !Objects.equals(normalized, "[\"ALL\"]"))
        {
            throw new ServiceException("全部区域不能与具体区域同时选择");
        }
    }
}
