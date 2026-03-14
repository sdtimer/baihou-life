package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouBanner;

/**
 * Baihou banner service.
 */
public interface IBaihouBannerService
{
    List<BaihouBanner> selectBannerList();

    int insertBanner(BaihouBanner banner);

    int updateBanner(BaihouBanner banner);

    int deleteBanner(Long bannerId);
}
