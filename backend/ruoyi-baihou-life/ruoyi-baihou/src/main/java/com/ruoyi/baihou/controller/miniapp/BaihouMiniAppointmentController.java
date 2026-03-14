package com.ruoyi.baihou.controller.miniapp;

import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.miniapp.MiniAppointmentCreateRequest;
import com.ruoyi.baihou.service.IBaihouAppointmentService;
import com.ruoyi.baihou.vo.miniapp.MiniAppointmentVO;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.context.BaihouMiniContext;

/**
 * 小程序预约接口
 * POST /v1/appointment/create
 * GET  /v1/appointment/list
 * GET  /v1/appointment/{appointmentId}
 */
@RestController
@RequestMapping("/v1/appointment")
public class BaihouMiniAppointmentController
{
    @Autowired
    private IBaihouAppointmentService appointmentService;

    @PostMapping("/create")
    public AjaxResult create(@RequestBody MiniAppointmentCreateRequest request)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        Long uid = BaihouMiniContext.getUid();
        BaihouAppointment appointment = appointmentService.createMiniAppointment(uid, request);
        return AjaxResult.success(MiniAppointmentVO.from(appointment));
    }

    @GetMapping("/list")
    public AjaxResult list()
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        Long uid = BaihouMiniContext.getUid();
        List<BaihouAppointment> appointments = appointmentService.selectAppointmentListByUserId(uid);
        List<MiniAppointmentVO> rows = appointments.stream()
                .map(MiniAppointmentVO::from)
                .collect(Collectors.toList());
        return AjaxResult.success(rows);
    }

    @GetMapping("/{appointmentId}")
    public AjaxResult detail(@PathVariable Long appointmentId)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        BaihouAppointment appointment = appointmentService.selectAppointmentByUser(
                BaihouMiniContext.getUid(), appointmentId);
        if (appointment == null)
        {
            return AjaxResult.error("预约不存在");
        }
        return AjaxResult.success(MiniAppointmentVO.from(appointment));
    }
}
