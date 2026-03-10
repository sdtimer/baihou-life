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
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;
import com.ruoyi.baihou.service.IBaihouOrderService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou order admin controller.
 */
@RestController
@RequestMapping("/admin/orders")
public class BaihouOrderController extends BaseController
{
    @Autowired
    private IBaihouOrderService orderService;

    @PreAuthorize("@ss.hasPermi('baihou:order:list')")
    @GetMapping
    public AjaxResult list(BaihouOrder query)
    {
        return success(orderService.selectOrderList(query));
    }

    @PreAuthorize("@ss.hasPermi('baihou:order:list')")
    @GetMapping("/{orderId}")
    public AjaxResult getInfo(@PathVariable Long orderId)
    {
        return success(orderService.selectOrderById(orderId));
    }

    @PreAuthorize("@ss.hasPermi('baihou:order:edit')")
    @Log(title = "订单管理", businessType = BusinessType.UPDATE)
    @PatchMapping("/{orderId}")
    public AjaxResult update(@PathVariable Long orderId, @RequestBody BaihouOrderUpdateRequest request)
    {
        return toAjax(orderService.updateOrder(orderId, request));
    }
}
