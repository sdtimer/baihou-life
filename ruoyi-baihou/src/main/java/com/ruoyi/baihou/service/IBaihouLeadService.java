package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.dto.BaihouLeadUpdateRequest;

/**
 * Baihou lead service.
 */
public interface IBaihouLeadService
{
    List<BaihouLead> selectLeadList(BaihouLead query);

    List<BaihouLead> exportLeadList(BaihouLead query);

    int updateLead(Long leadId, BaihouLeadUpdateRequest request);
}
