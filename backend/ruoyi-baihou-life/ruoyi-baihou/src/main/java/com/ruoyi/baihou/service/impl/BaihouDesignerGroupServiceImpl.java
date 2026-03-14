package com.ruoyi.baihou.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baihou.domain.BaihouDesignerGroup;
import com.ruoyi.baihou.mapper.BaihouDesignerGroupMapper;
import com.ruoyi.baihou.service.IBaihouDesignerGroupService;

/**
 * Baihou designer group service implementation.
 */
@Service
public class BaihouDesignerGroupServiceImpl implements IBaihouDesignerGroupService
{
    @Autowired
    private BaihouDesignerGroupMapper designerGroupMapper;

    @Override
    public List<BaihouDesignerGroup> selectGroupList()
    {
        return designerGroupMapper.selectGroupList();
    }

    @Override
    public int insertGroup(BaihouDesignerGroup group)
    {
        return designerGroupMapper.insertGroup(group);
    }

    @Override
    public int updateGroup(BaihouDesignerGroup group)
    {
        return designerGroupMapper.updateGroup(group);
    }
}
