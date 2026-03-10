package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouRegion;

/**
 * Baihou region service.
 */
public interface IBaihouRegionService
{
    List<BaihouRegion> selectRegionList();

    BaihouRegion selectRegionById(String regionId);

    int insertRegion(BaihouRegion region);

    int updateRegion(BaihouRegion region);

    int updateRegionStatus(String regionId, Integer isActive);
}
