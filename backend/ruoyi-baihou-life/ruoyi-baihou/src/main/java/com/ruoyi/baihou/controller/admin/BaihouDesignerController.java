package com.ruoyi.baihou.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.baihou.domain.BaihouDesigner;
import com.ruoyi.baihou.service.IBaihouDesignerService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou designer admin controller.
 */
@RestController
@RequestMapping("/admin/designers")
public class BaihouDesignerController extends BaseController
{
    @Autowired
    private IBaihouDesignerService designerService;

    @PreAuthorize("@ss.hasPermi('baihou:designer:list')")
    @GetMapping
    public AjaxResult list()
    {
        return success(designerService.selectDesignerList());
    }

    @PreAuthorize("@ss.hasPermi('baihou:designer:add')")
    @Log(title = "设计师管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody BaihouDesigner designer)
    {
        return toAjax(designerService.insertDesigner(designer));
    }

    @PreAuthorize("@ss.hasPermi('baihou:designer:edit')")
    @Log(title = "设计师管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{designerId}")
    public AjaxResult edit(@PathVariable Long designerId, @Validated @RequestBody BaihouDesigner designer)
    {
        designer.setDesignerId(designerId);
        return toAjax(designerService.updateDesigner(designer));
    }

    @PreAuthorize("@ss.hasPermi('baihou:designer:edit')")
    @Log(title = "设计师管理", businessType = BusinessType.UPDATE)
    @PatchMapping("/{designerId}/toggle")
    public AjaxResult toggle(@PathVariable Long designerId)
    {
        return toAjax(designerService.toggleDesignerStatus(designerId));
    }
}
