package com.ruoyi.baihou.job;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.baihou.service.IBaihouOrderService;

/**
 * Auto-complete shipped orders after grace period.
 */
@Component("baihouOrderAutoCompleteJob")
public class BaihouOrderAutoCompleteJob
{
    @Autowired
    private IBaihouOrderService orderService;

    public void execute()
    {
        orderService.autoCompleteShippedOrders();
    }
}
