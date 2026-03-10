package com.ruoyi.baihou.mapper;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouRegion;

/**
 * Baihou region mapper.
 */
public interface BaihouRegionMapper
{
    List<BaihouRegion> selectRegionList();

    BaihouRegion selectRegionById(String regionId);

    int insertRegion(BaihouRegion region);

    int updateRegion(BaihouRegion region);

    int updateRegionStatus(String regionId, Integer isActive);
}
