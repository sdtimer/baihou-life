package com.ruoyi.baihou.service.impl;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.baihou.domain.BaihouRegion;
import com.ruoyi.baihou.mapper.BaihouRegionMapper;
import com.ruoyi.baihou.service.IBaihouRegionService;

/**
 * Baihou region service implementation.
 */
@Service
@Transactional(rollbackFor = Exception.class)
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

    @Override
    public List<Map<String, String>> selectActiveOptions()
    {
        return regionMapper.selectActiveOptions();
    }
}
