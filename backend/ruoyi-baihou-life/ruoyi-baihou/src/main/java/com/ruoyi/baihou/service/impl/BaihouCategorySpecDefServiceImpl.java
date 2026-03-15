package com.ruoyi.baihou.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.baihou.domain.BaihouCategorySpecDef;
import com.ruoyi.baihou.mapper.BaihouCategorySpecDefMapper;
import com.ruoyi.baihou.service.IBaihouCategorySpecDefService;

/**
 * Baihou category spec definition service implementation.
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BaihouCategorySpecDefServiceImpl implements IBaihouCategorySpecDefService
{
    @Autowired
    private BaihouCategorySpecDefMapper specDefMapper;

    @Override
    public List<BaihouCategorySpecDef> selectSpecDefsByCategoryId(Long categoryId)
    {
        return specDefMapper.selectSpecDefsByCategoryId(categoryId);
    }

    @Override
    public int insertSpecDef(BaihouCategorySpecDef specDef)
    {
        return specDefMapper.insertSpecDef(specDef);
    }

    @Override
    public int updateSpecDef(BaihouCategorySpecDef specDef)
    {
        return specDefMapper.updateSpecDef(specDef);
    }

    @Override
    public int deleteSpecDef(Long specDefId)
    {
        return specDefMapper.deleteSpecDef(specDefId);
    }

    @Override
    public int updateSpecDefSort(Long categoryId, List<BaihouCategorySpecDef> specDefs)
    {
        int updated = 0;
        for (BaihouCategorySpecDef specDef : specDefs)
        {
            updated += specDefMapper.updateSpecDefSort(categoryId, specDef.getSpecDefId(), specDef.getSortOrder());
        }
        return updated;
    }
}
