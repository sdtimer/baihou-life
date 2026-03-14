package com.ruoyi.baihou.mapper;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouBanner;

/**
 * Baihou banner mapper.
 */
public interface BaihouBannerMapper
{
    List<BaihouBanner> selectBannerList();

    int insertBanner(BaihouBanner banner);

    int updateBanner(BaihouBanner banner);

    int deleteBanner(Long bannerId);
}
