package com.ruoyi.baihou.controller.miniapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.dto.miniapp.MiniLeadRequest;
import com.ruoyi.baihou.service.IBaihouLeadService;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.context.BaihouMiniContext;

/**
 * 小程序留资接口
 * POST /v1/leads/submit
 */
@RestController
@RequestMapping("/v1/leads")
public class BaihouMiniLeadController
{
    @Autowired
    private IBaihouLeadService leadService;

    @PostMapping("/submit")
    public AjaxResult submit(@RequestBody MiniLeadRequest request)
    {
        // 留资不强制登录，未登录 uid 为 null
        Long uid = BaihouMiniContext.isLoggedIn() ? BaihouMiniContext.getUid() : null;
        if (request.getName() == null || request.getName().isBlank())
        {
            return AjaxResult.error("姓名不能为空");
        }
        if (request.getPhone() == null || request.getPhone().isBlank())
        {
            return AjaxResult.error("手机号不能为空");
        }
        BaihouLead lead = leadService.createMiniLead(uid, request);
        return AjaxResult.success(lead.getLeadId());
    }
}
