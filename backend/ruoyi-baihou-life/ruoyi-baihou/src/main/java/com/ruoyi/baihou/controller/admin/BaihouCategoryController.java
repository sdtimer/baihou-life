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
import com.ruoyi.baihou.domain.BaihouCategory;
import com.ruoyi.baihou.domain.BaihouCategorySpecDef;
import com.ruoyi.baihou.service.IBaihouCategoryService;
import com.ruoyi.baihou.service.IBaihouCategorySpecDefService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou category admin controller.
 */
@RestController
@RequestMapping("/admin/categories")
public class BaihouCategoryController extends BaseController
{
    @Autowired
    private IBaihouCategoryService categoryService;

    @Autowired
    private IBaihouCategorySpecDefService specDefService;

    @PreAuthorize("@ss.hasPermi('baihou:category:list')")
    @GetMapping("/list")
    public AjaxResult list()
    {
        return success(categoryService.selectCategoryList());
    }

    @PreAuthorize("@ss.hasPermi('baihou:category:list')")
    @GetMapping("/{categoryId}")
    public AjaxResult getInfo(@PathVariable Long categoryId)
    {
        return success(categoryService.selectCategoryById(categoryId));
    }

    @PreAuthorize("@ss.hasPermi('baihou:category:add')")
    @Log(title = "品类管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BaihouCategory category)
    {
        return toAjax(categoryService.insertCategory(category));
    }

    @PreAuthorize("@ss.hasPermi('baihou:category:edit')")
    @Log(title = "品类管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody BaihouCategory category)
    {
        return toAjax(categoryService.updateCategory(category));
    }

    @PreAuthorize("@ss.hasPermi('baihou:category:edit')")
    @Log(title = "品类管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{categoryId}/status/{isActive}")
    public AjaxResult updateStatus(@PathVariable Long categoryId, @PathVariable Integer isActive)
    {
        return toAjax(categoryService.updateCategoryStatus(categoryId, isActive));
    }

    @PreAuthorize("@ss.hasPermi('baihou:category:list')")
    @GetMapping("/{categoryId}/spec-defs")
    public AjaxResult listSpecDefs(@PathVariable Long categoryId)
    {
        return success(specDefService.selectSpecDefsByCategoryId(categoryId));
    }

    @PreAuthorize("@ss.hasPermi('baihou:category:edit')")
    @Log(title = "规格模板", businessType = BusinessType.INSERT)
    @PostMapping("/{categoryId}/spec-defs")
    public AjaxResult addSpecDef(@PathVariable Long categoryId, @RequestBody BaihouCategorySpecDef specDef)
    {
        specDef.setCategoryId(categoryId);
        return toAjax(specDefService.insertSpecDef(specDef));
    }

    @PreAuthorize("@ss.hasPermi('baihou:category:edit')")
    @Log(title = "规格模板", businessType = BusinessType.UPDATE)
    @PutMapping("/{categoryId}/spec-defs/{specDefId}")
    public AjaxResult editSpecDef(@PathVariable Long categoryId, @PathVariable Long specDefId, @RequestBody BaihouCategorySpecDef specDef)
    {
        specDef.setCategoryId(categoryId);
        specDef.setSpecDefId(specDefId);
        return toAjax(specDefService.updateSpecDef(specDef));
    }

    @PreAuthorize("@ss.hasPermi('baihou:category:edit')")
    @Log(title = "规格模板", businessType = BusinessType.DELETE)
    @DeleteMapping("/{categoryId}/spec-defs/{specDefId}")
    public AjaxResult removeSpecDef(@PathVariable Long categoryId, @PathVariable Long specDefId)
    {
        return toAjax(specDefService.deleteSpecDef(specDefId));
    }
}
