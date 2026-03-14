package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouDesigner;

/**
 * Baihou designer service.
 */
public interface IBaihouDesignerService
{
    List<BaihouDesigner> selectDesignerList();

    int insertDesigner(BaihouDesigner designer);

    int updateDesigner(BaihouDesigner designer);

    int toggleDesignerStatus(Long designerId);
}
