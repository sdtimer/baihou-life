package com.ruoyi.baihou.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.dto.BaihouLeadUpdateRequest;
import com.ruoyi.baihou.service.IBaihouLeadService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou lead admin controller.
 */
@RestController
@RequestMapping("/admin/leads")
public class BaihouLeadController extends BaseController
{
    @Autowired
    private IBaihouLeadService leadService;

    @PreAuthorize("@ss.hasPermi('baihou:lead:list')")
    @GetMapping
    public AjaxResult list(BaihouLead query)
    {
        return success(leadService.selectLeadList(query));
    }

    @PreAuthorize("@ss.hasPermi('baihou:lead:edit')")
    @Log(title = "线索管理", businessType = BusinessType.UPDATE)
    @PatchMapping("/{leadId}")
    public AjaxResult update(@PathVariable Long leadId, @RequestBody BaihouLeadUpdateRequest request)
    {
        return toAjax(leadService.updateLead(leadId, request));
    }

    @PreAuthorize("@ss.hasPermi('baihou:lead:export')")
    @Log(title = "线索管理", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(BaihouLead query)
    {
        return success(leadService.exportLeadList(query));
    }
}
