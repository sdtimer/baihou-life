package com.ruoyi.baihou.controller.miniapp;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.baihou.domain.BaihouWxUser;
import com.ruoyi.baihou.dto.miniapp.MiniLoginRequest;
import com.ruoyi.baihou.service.IBaihouWxUserService;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.context.BaihouMiniTokenService;

/**
 * 小程序认证接口（POST /v1/auth/wechat-login）
 */
@RestController
@RequestMapping("/v1/auth")
public class BaihouMiniAuthController
{
    @Autowired
    private IBaihouWxUserService wxUserService;

    @Autowired
    private BaihouMiniTokenService miniTokenService;

    /**
     * 登录（测试阶段：code 当 openid 使用，跳过真实微信 code2session）
     */
    @PostMapping("/wechat-login")
    public AjaxResult login(@RequestBody MiniLoginRequest request)
    {
        if (request.getCode() == null || request.getCode().isBlank())
        {
            return AjaxResult.error("code 不能为空");
        }

        BaihouWxUser user = wxUserService.findOrCreateByCode(request.getCode());
        String token = miniTokenService.createToken(user.getUid(), user.getRole(), user.getOpenid());

        Map<String, Object> userInfo = new HashMap<>();
        userInfo.put("uid", user.getUid());
        userInfo.put("role", user.getRole());
        userInfo.put("nickname", user.getNickname());
        userInfo.put("avatar_url", user.getAvatarUrl());
        userInfo.put("phone", user.getPhone());
        userInfo.put("region_id", user.getRegionId());

        Map<String, Object> data = new HashMap<>();
        data.put("token", token);
        data.put("expires_in", 604800);
        data.put("user", userInfo);

        return AjaxResult.success(data);
    }
}
