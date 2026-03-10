package com.ruoyi.baihou.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baihou.domain.BaihouCategory;
import com.ruoyi.baihou.mapper.BaihouCategoryMapper;
import com.ruoyi.baihou.service.IBaihouCategoryService;

/**
 * Baihou category service implementation.
 */
@Service
public class BaihouCategoryServiceImpl implements IBaihouCategoryService
{
    @Autowired
    private BaihouCategoryMapper categoryMapper;

    @Override
    public List<BaihouCategory> selectCategoryList()
    {
        return categoryMapper.selectCategoryList();
    }

    @Override
    public BaihouCategory selectCategoryById(Long categoryId)
    {
        return categoryMapper.selectCategoryById(categoryId);
    }

    @Override
    public int insertCategory(BaihouCategory category)
    {
        return categoryMapper.insertCategory(category);
    }

    @Override
    public int updateCategory(BaihouCategory category)
    {
        return categoryMapper.updateCategory(category);
    }

    @Override
    public int updateCategoryStatus(Long categoryId, Integer isActive)
    {
        int rows = categoryMapper.updateCategoryStatus(categoryId, isActive);
        if (rows > 0 && Integer.valueOf(0).equals(isActive))
        {
            categoryMapper.updateProductsOffShelfByCategoryId(categoryId);
        }
        return rows;
    }
}
