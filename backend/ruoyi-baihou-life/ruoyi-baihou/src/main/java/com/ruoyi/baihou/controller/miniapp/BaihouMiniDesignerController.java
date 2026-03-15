package com.ruoyi.baihou.controller.miniapp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.baihou.domain.BaihouMedia;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.service.IBaihouProductService;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.context.BaihouMiniContext;
import com.ruoyi.common.utils.StringUtils;

/**
 * 小程序设计师接口（占位实现）
 * GET /v1/designer/asset-token
 */
@RestController
@RequestMapping("/v1/designer")
public class BaihouMiniDesignerController
{
    @Autowired
    private IBaihouProductService productService;

    /**
     * 获取素材下载 token（占位，后续实现 OSS 签名）
     */
    @GetMapping("/asset-token")
    public AjaxResult assetToken(HttpServletRequest request,
                                 @RequestParam(name = "product_id", required = false) Long productId,
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
        BaihouProduct product = productService.selectProductById(productId);
        if (product == null)
        {
            return AjaxResult.error(404, "商品不存在");
        }
        List<BaihouMedia> downloadImages = product.getDownloadImages();
        BaihouMedia targetMedia = downloadImages == null ? null : downloadImages.stream()
                .filter(item -> mediaId.equals(item.getMediaId()))
                .findFirst()
                .orElse(null);
        if (targetMedia == null
                || !"designer".equals(targetMedia.getAccessLevel())
                || !"download".equals(targetMedia.getAssetRole()))
        {
            return AjaxResult.error(403, "当前素材不可下载");
        }
        String assetUrl = StringUtils.isNotEmpty(targetMedia.getOriginalUrl()) ? targetMedia.getOriginalUrl() : targetMedia.getUrl();
        if (StringUtils.isEmpty(assetUrl))
        {
            return AjaxResult.error(404, "素材地址不存在");
        }
        if (assetUrl.startsWith("/"))
        {
            assetUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + assetUrl;
        }
        Map<String, Object> data = new HashMap<>();
        data.put("url", assetUrl);
        data.put("expires_in", 300);
        return AjaxResult.success(data);
    }
}
