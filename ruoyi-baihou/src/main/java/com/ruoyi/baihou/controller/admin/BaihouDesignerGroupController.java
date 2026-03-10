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
import com.ruoyi.baihou.domain.BaihouDesignerGroup;
import com.ruoyi.baihou.service.IBaihouDesignerGroupService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou designer group admin controller.
 */
@RestController
@RequestMapping("/admin/designer-groups")
public class BaihouDesignerGroupController extends BaseController
{
    @Autowired
    private IBaihouDesignerGroupService designerGroupService;

    @PreAuthorize("@ss.hasPermi('baihou:designerGroup:list')")
    @GetMapping
    public AjaxResult list()
    {
        return success(designerGroupService.selectGroupList());
    }

    @PreAuthorize("@ss.hasPermi('baihou:designerGroup:add')")
    @Log(title = "设计师分组", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BaihouDesignerGroup group)
    {
        return toAjax(designerGroupService.insertGroup(group));
    }

    @PreAuthorize("@ss.hasPermi('baihou:designerGroup:edit')")
    @Log(title = "设计师分组", businessType = BusinessType.UPDATE)
    @PutMapping("/{groupId}")
    public AjaxResult edit(@PathVariable Long groupId, @RequestBody BaihouDesignerGroup group)
    {
        group.setGroupId(groupId);
        return toAjax(designerGroupService.updateGroup(group));
    }
}
