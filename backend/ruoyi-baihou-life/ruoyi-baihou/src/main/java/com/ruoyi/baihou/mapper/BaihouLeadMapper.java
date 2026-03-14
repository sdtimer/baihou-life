package com.ruoyi.baihou.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.dto.BaihouLeadUpdateRequest;

/**
 * Baihou lead mapper.
 */
public interface BaihouLeadMapper
{
    List<BaihouLead> selectLeadList(BaihouLead query);

    BaihouLead selectLeadById(Long leadId);

    int updateLead(@Param("leadId") Long leadId, @Param("request") BaihouLeadUpdateRequest request);

    int insertLead(com.ruoyi.baihou.domain.BaihouLead lead);

    int countRecentDuplicateLead(@Param("userId") Long userId, @Param("productId") Long productId, @Param("phone") String phone);
}
