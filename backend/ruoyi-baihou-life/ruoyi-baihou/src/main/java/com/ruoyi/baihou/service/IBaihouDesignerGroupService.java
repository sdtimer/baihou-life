package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouDesignerGroup;

/**
 * Baihou designer group service.
 */
public interface IBaihouDesignerGroupService
{
    List<BaihouDesignerGroup> selectGroupList();

    int insertGroup(BaihouDesignerGroup group);

    int updateGroup(BaihouDesignerGroup group);
}
