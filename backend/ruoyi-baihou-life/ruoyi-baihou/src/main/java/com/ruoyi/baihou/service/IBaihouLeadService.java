package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.dto.BaihouLeadUpdateRequest;
import com.ruoyi.baihou.dto.miniapp.MiniLeadRequest;

/**
 * Baihou lead service.
 */
public interface IBaihouLeadService
{
    List<BaihouLead> selectLeadList(BaihouLead query);

    List<BaihouLead> exportLeadList(BaihouLead query);

    int updateLead(Long leadId, BaihouLeadUpdateRequest request);

    BaihouLead createMiniLead(Long uid, MiniLeadRequest request);
}
