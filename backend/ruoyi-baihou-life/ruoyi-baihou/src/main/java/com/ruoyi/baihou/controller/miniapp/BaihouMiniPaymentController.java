package com.ruoyi.baihou.controller.miniapp;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.service.IBaihouOrderService;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.context.BaihouMiniContext;

/**
 * 小程序测试态支付接口
 */
@RestController
@RequestMapping("/v1/payment/wechat")
public class BaihouMiniPaymentController
{
    @Autowired
    private IBaihouOrderService orderService;

    @PostMapping("/prepay")
    public AjaxResult prepay(@RequestBody Map<String, Object> payload)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        Long orderId = readOrderId(payload);
        if (orderId == null)
        {
            return AjaxResult.error(400, "order_id 不能为空");
        }
        AjaxResult access = ensureOrderAccess(orderId);
        if (access != null)
        {
            return access;
        }
        return AjaxResult.success(orderService.buildMiniPrepay(BaihouMiniContext.getUid(), orderId));
    }

    @PostMapping("/pay-success")
    public AjaxResult paySuccess(@RequestBody Map<String, Object> payload)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        Long orderId = readOrderId(payload);
        if (orderId == null)
        {
            return AjaxResult.error(400, "order_id 不能为空");
        }
        AjaxResult access = ensureOrderAccess(orderId);
        if (access != null)
        {
            return access;
        }
        return orderService.markMiniOrderPaid(BaihouMiniContext.getUid(), orderId) > 0
                ? AjaxResult.success()
                : AjaxResult.error("支付结果更新失败");
    }

    private Long readOrderId(Map<String, Object> payload)
    {
        Object raw = payload == null ? null : payload.get("order_id");
        if (raw instanceof Number)
        {
            return ((Number) raw).longValue();
        }
        if (raw instanceof String && !((String) raw).isBlank())
        {
            return Long.valueOf((String) raw);
        }
        return null;
    }

    private AjaxResult ensureOrderAccess(Long orderId)
    {
        BaihouOrder order = orderService.selectOrderById(orderId);
        if (order == null)
        {
            return AjaxResult.error(404, "订单不存在");
        }
        if (order.getUserId() == null || !order.getUserId().equals(BaihouMiniContext.getUid()))
        {
            return AjaxResult.error(403, "无权访问该订单");
        }
        return null;
    }
}
