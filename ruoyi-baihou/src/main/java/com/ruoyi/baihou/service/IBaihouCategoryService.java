package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouCategory;

/**
 * Baihou category service.
 */
public interface IBaihouCategoryService
{
    List<BaihouCategory> selectCategoryList();

    BaihouCategory selectCategoryById(Long categoryId);

    int insertCategory(BaihouCategory category);

    int updateCategory(BaihouCategory category);

    int updateCategoryStatus(Long categoryId, Integer isActive);
}
