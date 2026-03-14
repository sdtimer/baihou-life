package com.ruoyi;

import com.ruoyi.baihou.job.BaihouOrderAutoCompleteJob;
import com.ruoyi.baihou.job.BaihouOrderTimeoutJob;
import com.ruoyi.baihou.service.IBaihouOrderService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

class BaihouOrderJobTest
{
    @Test
    void timeoutJobShouldInvokeService()
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        BaihouOrderTimeoutJob job = new BaihouOrderTimeoutJob();
        ReflectionTestUtils.setField(job, "orderService", orderService);

        job.execute();

        Mockito.verify(orderService).closeExpiredPendingPayOrders();
    }

    @Test
    void autoCompleteJobShouldInvokeService()
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        BaihouOrderAutoCompleteJob job = new BaihouOrderAutoCompleteJob();
        ReflectionTestUtils.setField(job, "orderService", orderService);

        job.execute();

        Mockito.verify(orderService).autoCompleteShippedOrders();
    }
}
