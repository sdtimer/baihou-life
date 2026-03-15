package com.ruoyi.baihou.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.baihou.domain.BaihouRegion;
import com.ruoyi.baihou.service.IBaihouRegionService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou region admin controller.
 */
@RestController
@RequestMapping("/admin/regions")
public class BaihouRegionController extends BaseController
{
    @Autowired
    private IBaihouRegionService regionService;

    @PreAuthorize("@ss.hasPermi('baihou:region:list')")
    @GetMapping("/list")
    public AjaxResult list()
    {
        return success(regionService.selectRegionList());
    }

    @PreAuthorize("@ss.hasPermi('baihou:region:list')")
    @GetMapping("/{regionId}")
    public AjaxResult getInfo(@PathVariable String regionId)
    {
        return success(regionService.selectRegionById(regionId));
    }

    @PreAuthorize("@ss.hasPermi('baihou:region:add')")
    @Log(title = "区域管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BaihouRegion region)
    {
        return toAjax(regionService.insertRegion(region));
    }

    @PreAuthorize("@ss.hasPermi('baihou:region:edit')")
    @Log(title = "区域管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody BaihouRegion region)
    {
        return toAjax(regionService.updateRegion(region));
    }

    @PreAuthorize("@ss.hasPermi('baihou:region:edit')")
    @Log(title = "区域管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{regionId}/status/{isActive}")
    public AjaxResult updateStatus(@PathVariable String regionId, @PathVariable Integer isActive)
    {
        return toAjax(regionService.updateRegionStatus(regionId, isActive));
    }

    @PreAuthorize("@ss.hasPermi('baihou:region:list')")
    @GetMapping("/options")
    public AjaxResult options()
    {
        return success(regionService.selectActiveOptions());
    }
}
