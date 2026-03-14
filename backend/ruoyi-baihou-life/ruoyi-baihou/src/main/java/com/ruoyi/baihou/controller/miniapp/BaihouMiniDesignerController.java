package com.ruoyi.baihou.controller.miniapp;

import java.util.HashMap;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.context.BaihouMiniContext;

/**
 * 小程序设计师接口（占位实现）
 * GET /v1/designer/asset-token
 */
@RestController
@RequestMapping("/v1/designer")
public class BaihouMiniDesignerController
{
    /**
     * 获取素材下载 token（占位，后续实现 OSS 签名）
     */
    @GetMapping("/asset-token")
    public AjaxResult assetToken(@RequestParam(name = "product_id", required = false) Long productId,
                                 @RequestParam(name = "media_id", required = false) Long mediaId)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        Integer role = BaihouMiniContext.getRole();
        if (!Integer.valueOf(2).equals(role))
        {
            return AjaxResult.error(403, "仅设计师可访问");
        }
        if (productId == null || mediaId == null)
        {
            return AjaxResult.error(400, "product_id 和 media_id 不能为空");
        }
        Map<String, Object> data = new HashMap<>();
        data.put("url", "https://mock.baihou.life/assets/" + productId + "/" + mediaId + "?token=mock");
        data.put("expires_in", 300);
        return AjaxResult.success(data);
    }
}
