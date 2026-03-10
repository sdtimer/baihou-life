package com.ruoyi.baihou.job;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.baihou.service.IBaihouOrderService;

/**
 * Close expired pending-pay orders.
 */
@Component("baihouOrderTimeoutJob")
public class BaihouOrderTimeoutJob
{
    @Autowired
    private IBaihouOrderService orderService;

    public void execute()
    {
        orderService.closeExpiredPendingPayOrders();
    }
}
