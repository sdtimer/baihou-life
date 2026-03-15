package com.ruoyi.baihou.mapper;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouCategorySpecDef;
import org.apache.ibatis.annotations.Param;

/**
 * Baihou category spec definition mapper.
 */
public interface BaihouCategorySpecDefMapper
{
    List<BaihouCategorySpecDef> selectSpecDefsByCategoryId(Long categoryId);

    int insertSpecDef(BaihouCategorySpecDef specDef);

    int updateSpecDef(BaihouCategorySpecDef specDef);

    int deleteSpecDef(Long specDefId);

    int updateSpecDefSort(@Param("categoryId") Long categoryId, @Param("specDefId") Long specDefId, @Param("sortOrder") Integer sortOrder);
}
