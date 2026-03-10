package com.ruoyi.baihou.mapper;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouCategory;

/**
 * Baihou category mapper.
 */
public interface BaihouCategoryMapper
{
    List<BaihouCategory> selectCategoryList();

    BaihouCategory selectCategoryById(Long categoryId);

    int insertCategory(BaihouCategory category);

    int updateCategory(BaihouCategory category);

    int updateCategoryStatus(Long categoryId, Integer isActive);

    int updateProductsOffShelfByCategoryId(Long categoryId);
}
