package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;
import com.ruoyi.baihou.mapper.BaihouOrderMapper;
import com.ruoyi.baihou.service.impl.BaihouOrderServiceImpl;
import com.ruoyi.common.exception.ServiceException;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class BaihouOrderServiceImplTest
{
    @Test
    void orderListShouldDelegateToMapper()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        List<BaihouOrder> expected = List.of(new BaihouOrder(1L, "ORD202603100001", "paid"));
        Mockito.when(orderMapper.selectOrderList(Mockito.any(BaihouOrder.class))).thenReturn(expected);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);

        assertEquals(expected, service.selectOrderList(new BaihouOrder()));
    }

    @Test
    void orderDetailShouldDelegateToMapper()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrder expected = new BaihouOrder(1L, "ORD202603100001", "processing");
        Mockito.when(orderMapper.selectOrderById(1L)).thenReturn(expected);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);

        assertEquals(expected, service.selectOrderById(1L));
    }

    @Test
    void updateOrderShouldAllowPaidToProcessing()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrder current = new BaihouOrder(1L, "ORD202603100001", "paid");
        Mockito.when(orderMapper.selectOrderById(1L)).thenReturn(current);
        Mockito.when(orderMapper.updateOrder(Mockito.eq(1L), Mockito.any(BaihouOrderUpdateRequest.class))).thenReturn(1);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);

        BaihouOrderUpdateRequest request = new BaihouOrderUpdateRequest();
        request.setStatus("processing");
        assertEquals(1, service.updateOrder(1L, request));
    }

    @Test
    void updateOrderShouldRequireTrackingNoWhenShipping()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrder current = new BaihouOrder(1L, "ORD202603100001", "processing");
        Mockito.when(orderMapper.selectOrderById(1L)).thenReturn(current);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);

        BaihouOrderUpdateRequest request = new BaihouOrderUpdateRequest();
        request.setStatus("shipped");
        assertThrows(ServiceException.class, () -> service.updateOrder(1L, request));
    }

    @Test
    void updateOrderShouldRejectClosedChanges()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrder current = new BaihouOrder(1L, "ORD202603100001", "closed");
        Mockito.when(orderMapper.selectOrderById(1L)).thenReturn(current);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);

        BaihouOrderUpdateRequest request = new BaihouOrderUpdateRequest();
        request.setStatus("completed");
        assertThrows(ServiceException.class, () -> service.updateOrder(1L, request));
    }

    @Test
    void closeExpiredPendingPayOrdersShouldDelegateToMapper()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        Mockito.when(orderMapper.closeExpiredPendingPayOrders()).thenReturn(2);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);

        assertEquals(2, service.closeExpiredPendingPayOrders());
    }

    @Test
    void autoCompleteShippedOrdersShouldDelegateToMapper()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        Mockito.when(orderMapper.autoCompleteShippedOrders()).thenReturn(3);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);

        assertEquals(3, service.autoCompleteShippedOrders());
    }
}
