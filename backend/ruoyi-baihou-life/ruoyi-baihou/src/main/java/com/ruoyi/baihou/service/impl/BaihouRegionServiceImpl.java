package com.ruoyi.baihou.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baihou.domain.BaihouRegion;
import com.ruoyi.baihou.mapper.BaihouRegionMapper;
import com.ruoyi.baihou.service.IBaihouRegionService;

/**
 * Baihou region service implementation.
 */
@Service
public class BaihouRegionServiceImpl implements IBaihouRegionService
{
    @Autowired
    private BaihouRegionMapper regionMapper;

    @Override
    public List<BaihouRegion> selectRegionList()
    {
        return regionMapper.selectRegionList();
    }

    @Override
    public BaihouRegion selectRegionById(String regionId)
    {
        return regionMapper.selectRegionById(regionId);
    }

    @Override
    public int insertRegion(BaihouRegion region)
    {
        return regionMapper.insertRegion(region);
    }

    @Override
    public int updateRegion(BaihouRegion region)
    {
        return regionMapper.updateRegion(region);
    }

    @Override
    public int updateRegionStatus(String regionId, Integer isActive)
    {
        return regionMapper.updateRegionStatus(regionId, isActive);
    }
}
