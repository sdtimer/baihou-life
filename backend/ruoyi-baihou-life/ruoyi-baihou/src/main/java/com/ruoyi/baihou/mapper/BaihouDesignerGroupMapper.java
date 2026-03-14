package com.ruoyi.baihou.mapper;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouDesignerGroup;

/**
 * Baihou designer group mapper.
 */
public interface BaihouDesignerGroupMapper
{
    List<BaihouDesignerGroup> selectGroupList();

    int insertGroup(BaihouDesignerGroup group);

    int updateGroup(BaihouDesignerGroup group);
}
