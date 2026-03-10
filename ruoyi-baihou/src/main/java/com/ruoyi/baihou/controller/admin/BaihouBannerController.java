package com.ruoyi.baihou.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.baihou.domain.BaihouBanner;
import com.ruoyi.baihou.service.IBaihouBannerService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou banner admin controller.
 */
@RestController
@RequestMapping("/admin/banners")
public class BaihouBannerController extends BaseController
{
    @Autowired
    private IBaihouBannerService bannerService;

    @PreAuthorize("@ss.hasPermi('baihou:banner:list')")
    @GetMapping
    public AjaxResult list()
    {
        return success(bannerService.selectBannerList());
    }

    @PreAuthorize("@ss.hasPermi('baihou:banner:add')")
    @Log(title = "Banner管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BaihouBanner banner)
    {
        return toAjax(bannerService.insertBanner(banner));
    }

    @PreAuthorize("@ss.hasPermi('baihou:banner:edit')")
    @Log(title = "Banner管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{bannerId}")
    public AjaxResult edit(@PathVariable Long bannerId, @RequestBody BaihouBanner banner)
    {
        banner.setBannerId(bannerId);
        return toAjax(bannerService.updateBanner(banner));
    }

    @PreAuthorize("@ss.hasPermi('baihou:banner:remove')")
    @Log(title = "Banner管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{bannerId}")
    public AjaxResult remove(@PathVariable Long bannerId)
    {
        return toAjax(bannerService.deleteBanner(bannerId));
    }
}
