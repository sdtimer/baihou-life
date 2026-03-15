package com.ruoyi.baihou.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.dto.BaihouLeadUpdateRequest;
import com.ruoyi.baihou.dto.miniapp.MiniLeadRequest;
import com.ruoyi.baihou.mapper.BaihouLeadMapper;
import com.ruoyi.baihou.service.IBaihouLeadService;
import com.ruoyi.common.exception.ServiceException;

/**
 * Baihou lead service implementation.
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BaihouLeadServiceImpl implements IBaihouLeadService
{
    private static final Map<String, Set<String>> ALLOWED_TRANSITIONS = Map.of(
            "new", Set.of("following", "abandoned"),
            "following", Set.of("converted", "abandoned"),
            "abandoned", Set.of("following"),
            "converted", Set.of());

    @Autowired
    private BaihouLeadMapper leadMapper;

    @Override
    public List<BaihouLead> selectLeadList(BaihouLead query)
    {
        List<BaihouLead> leads = leadMapper.selectLeadList(query);
        maskLeadPhones(leads);
        return leads;
    }

    @Override
    public List<BaihouLead> exportLeadList(BaihouLead query)
    {
        List<BaihouLead> leads = leadMapper.selectLeadList(query);
        maskLeadPhones(leads);
        return leads;
    }

    @Override
    public BaihouLead createMiniLead(Long uid, MiniLeadRequest request)
    {
        if (request.getPhone() == null || !request.getPhone().matches("^1\\d{10}$"))
        {
            throw new ServiceException("手机号格式不正确");
        }
        if (request.getRegionId() == null || request.getRegionId().isBlank())
        {
            throw new ServiceException("区域不能为空");
        }
        if (leadMapper.countRecentDuplicateLead(uid, request.getProductId(), request.getPhone()) > 0)
        {
            throw new ServiceException("24小时内请勿重复提交相同商品线索");
        }

        BaihouLead lead = new BaihouLead();
        lead.setUserId(uid);
        lead.setProductId(request.getProductId());
        lead.setProductName(request.getProductName());
        lead.setName(request.getName());
        lead.setPhone(request.getPhone());
        lead.setRegionId(request.getRegionId());
        lead.setStatus("new");
        leadMapper.insertLead(lead);
        return lead;
    }

    @Override
    public int updateLead(Long leadId, BaihouLeadUpdateRequest request)
    {
        BaihouLead current = leadMapper.selectLeadById(leadId);
        if (current == null)
        {
            throw new ServiceException("线索不存在");
        }
        validateTransition(current.getStatus(), request.getStatus());
        return leadMapper.updateLead(leadId, request);
    }

    private void validateTransition(String currentStatus, String nextStatus)
    {
        if (nextStatus == null || nextStatus.isBlank() || nextStatus.equals(currentStatus))
        {
            return;
        }

        Set<String> allowedTargets = ALLOWED_TRANSITIONS.get(currentStatus);
        if (allowedTargets == null || !allowedTargets.contains(nextStatus))
        {
            throw new ServiceException("线索状态流转非法");
        }
    }

    private void maskLeadPhones(List<BaihouLead> leads)
    {
        for (BaihouLead lead : leads)
        {
            lead.setPhone(maskPhone(lead.getPhone()));
        }
    }

    private String maskPhone(String phone)
    {
        if (phone == null || phone.length() < 7)
        {
            return phone;
        }
        return phone.substring(0, 3) + "****" + phone.substring(phone.length() - 4);
    }
}
