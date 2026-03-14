package com.ruoyi.baihou.mapper;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouDesigner;

/**
 * Baihou designer mapper.
 */
public interface BaihouDesignerMapper
{
    List<BaihouDesigner> selectDesignerList();

    BaihouDesigner selectDesignerById(Long designerId);

    int insertDesigner(BaihouDesigner designer);

    int updateDesigner(BaihouDesigner designer);

    int updateDesignerStatus(Long designerId, String status);
}
