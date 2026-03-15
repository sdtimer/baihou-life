package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouCategorySpecDef;

/**
 * Baihou category spec definition service.
 */
public interface IBaihouCategorySpecDefService
{
    List<BaihouCategorySpecDef> selectSpecDefsByCategoryId(Long categoryId);

    int insertSpecDef(BaihouCategorySpecDef specDef);

    int updateSpecDef(BaihouCategorySpecDef specDef);

    int deleteSpecDef(Long specDefId);
}
