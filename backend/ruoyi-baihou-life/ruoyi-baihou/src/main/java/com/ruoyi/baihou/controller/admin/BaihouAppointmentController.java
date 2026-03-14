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
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;
import com.ruoyi.baihou.service.IBaihouAppointmentService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou appointment admin controller.
 */
@RestController
@RequestMapping("/admin/appointments")
public class BaihouAppointmentController extends BaseController
{
    @Autowired
    private IBaihouAppointmentService appointmentService;

    @PreAuthorize("@ss.hasPermi('baihou:appointment:list')")
    @GetMapping
    public AjaxResult list(BaihouAppointment query)
    {
        return success(appointmentService.selectAppointmentList(query));
    }

    @PreAuthorize("@ss.hasPermi('baihou:appointment:edit')")
    @Log(title = "预约管理", businessType = BusinessType.UPDATE)
    @PatchMapping("/{appointmentId}")
    public AjaxResult update(@PathVariable Long appointmentId, @RequestBody BaihouAppointmentUpdateRequest request)
    {
        return toAjax(appointmentService.updateAppointment(appointmentId, request));
    }
}
