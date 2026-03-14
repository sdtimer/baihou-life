package com.ruoyi.baihou.controller.miniapp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest;
import com.ruoyi.baihou.service.IBaihouOrderService;
import com.ruoyi.baihou.vo.miniapp.MiniOrderVO;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.context.BaihouMiniContext;

/**
 * 小程序订单接口
     * POST /v1/order/create
     * GET  /v1/order/list
     * GET  /v1/order/{orderId}
     * POST /v1/order/{orderId}/prepay
     * POST /v1/order/{orderId}/pay-success
     */
@RestController
@RequestMapping("/v1/order")
public class BaihouMiniOrderController
{
    @Autowired
    private IBaihouOrderService orderService;

    @PostMapping("/create")
    public AjaxResult create(@RequestBody MiniOrderCreateRequest request)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        Long uid = BaihouMiniContext.getUid();
        BaihouOrder order = orderService.createMiniOrder(uid, request);

        Map<String, Object> data = new HashMap<>();
        data.put("order_id", order.getOrderId());
        data.put("order_no", order.getOrderNo());

        return AjaxResult.success(data);
    }

    @PostMapping("/{orderId}/prepay")
    public AjaxResult prepay(@PathVariable Long orderId)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        return AjaxResult.success(orderService.buildMiniPrepay(BaihouMiniContext.getUid(), orderId));
    }

    @PostMapping("/{orderId}/pay-success")
    public AjaxResult paySuccess(@PathVariable Long orderId)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        return orderService.markMiniOrderPaid(BaihouMiniContext.getUid(), orderId) > 0
                ? AjaxResult.success()
                : AjaxResult.error("支付结果更新失败");
    }

    @GetMapping("/list")
    public AjaxResult list()
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        Long uid = BaihouMiniContext.getUid();
        List<BaihouOrder> orders = orderService.selectOrderListByUserId(uid);
        List<MiniOrderVO> rows = orders.stream().map(MiniOrderVO::from).collect(Collectors.toList());
        return AjaxResult.success(rows);
    }

    @GetMapping("/{orderId}")
    public AjaxResult detail(@PathVariable Long orderId)
    {
        if (!BaihouMiniContext.isLoggedIn())
        {
            return AjaxResult.error(401, "请先登录");
        }
        BaihouOrder order = orderService.selectOrderById(orderId);
        if (order == null || order.getUserId() == null || !order.getUserId().equals(BaihouMiniContext.getUid()))
        {
            return AjaxResult.error("订单不存在");
        }
        return AjaxResult.success(MiniOrderVO.from(order));
    }
}
