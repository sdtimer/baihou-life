package com.ruoyi.baihou.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.baihou.domain.BaihouDesigner;
import com.ruoyi.baihou.mapper.BaihouDesignerMapper;
import com.ruoyi.baihou.mapper.BaihouWxUserMapper;
import com.ruoyi.baihou.service.IBaihouDesignerService;

/**
 * Baihou designer service implementation.
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BaihouDesignerServiceImpl implements IBaihouDesignerService
{
    @Autowired
    private BaihouDesignerMapper designerMapper;

    @Autowired
    private BaihouWxUserMapper wxUserMapper;

    @Override
    public List<BaihouDesigner> selectDesignerList()
    {
        return designerMapper.selectDesignerList();
    }

    @Override
    public int insertDesigner(BaihouDesigner designer)
    {
        if (designer.getStatus() == null)
        {
            designer.setStatus("active");
        }
        Long userId = wxUserMapper.selectUserIdByPhoneHash(designer.getPhoneHash());
        if (userId != null)
        {
            designer.setUserId(userId);
        }
        int rows = designerMapper.insertDesigner(designer);
        if (rows > 0 && designer.getUserId() != null)
        {
            wxUserMapper.updateUserRole(designer.getUserId(), 2);
        }
        return rows;
    }

    @Override
    public int updateDesigner(BaihouDesigner designer)
    {
        return designerMapper.updateDesigner(designer);
    }

    @Override
    public int toggleDesignerStatus(Long designerId)
    {
        BaihouDesigner designer = designerMapper.selectDesignerById(designerId);
        String nextStatus = "active".equals(designer.getStatus()) ? "disabled" : "active";
        int rows = designerMapper.updateDesignerStatus(designerId, nextStatus);
        if (rows > 0 && designer.getUserId() != null)
        {
            wxUserMapper.updateUserStatus(designer.getUserId(), nextStatus);
        }
        return rows;
    }
}
