package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.domain.BaihouOrderItem;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;
import com.ruoyi.baihou.mapper.BaihouOrderMapper;
import com.ruoyi.baihou.mapper.BaihouOrderItemMapper;
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
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        List<BaihouOrder> expected = List.of(new BaihouOrder(1L, "ORD202603100001", "paid"));
        Mockito.when(orderMapper.selectOrderList(Mockito.any(BaihouOrder.class))).thenReturn(expected);
        Mockito.when(orderItemMapper.selectOrderItemsByOrderId(1L))
                .thenReturn(List.of(new BaihouOrderItem(11L, 1L, 1001L, "测试商品", 1)));

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);

        List<BaihouOrder> actual = service.selectOrderList(new BaihouOrder());
        assertEquals("测试商品", actual.get(0).getProductSummary());
        assertEquals(1, actual.get(0).getItemCount());
    }

    @Test
    void orderDetailShouldEnrichItemsFromMapper()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouOrder expected = new BaihouOrder(1L, "ORD202603100001", "processing");
        Mockito.when(orderMapper.selectOrderById(1L)).thenReturn(expected);
        Mockito.when(orderItemMapper.selectOrderItemsByOrderId(1L))
                .thenReturn(List.of(
                        new BaihouOrderItem(11L, 1L, 1001L, "测试商品A", 1),
                        new BaihouOrderItem(12L, 1L, 1002L, "测试商品B", 2)));

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);

        BaihouOrder actual = service.selectOrderById(1L);
        assertEquals(expected, actual);
        assertEquals(2, actual.getItems().size());
        assertEquals("测试商品A 等2件", actual.getProductSummary());
        assertEquals(3, actual.getItemCount());
    }

    @Test
    void updateOrderShouldAllowPaidToProcessing()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouOrder current = new BaihouOrder(1L, "ORD202603100001", "paid");
        Mockito.when(orderMapper.selectOrderById(1L)).thenReturn(current);
        Mockito.when(orderMapper.updateOrder(Mockito.eq(1L), Mockito.any(BaihouOrderUpdateRequest.class))).thenReturn(1);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);

        BaihouOrderUpdateRequest request = new BaihouOrderUpdateRequest();
        request.setStatus("processing");
        assertEquals(1, service.updateOrder(1L, request));
    }

    @Test
    void updateOrderShouldRequireTrackingNoWhenShipping()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouOrder current = new BaihouOrder(1L, "ORD202603100001", "processing");
        Mockito.when(orderMapper.selectOrderById(1L)).thenReturn(current);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);

        BaihouOrderUpdateRequest request = new BaihouOrderUpdateRequest();
        request.setStatus("shipped");
        assertThrows(ServiceException.class, () -> service.updateOrder(1L, request));
    }

    @Test
    void updateOrderShouldRejectClosedChanges()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouOrder current = new BaihouOrder(1L, "ORD202603100001", "closed");
        Mockito.when(orderMapper.selectOrderById(1L)).thenReturn(current);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);

        BaihouOrderUpdateRequest request = new BaihouOrderUpdateRequest();
        request.setStatus("completed");
        assertThrows(ServiceException.class, () -> service.updateOrder(1L, request));
    }

    @Test
    void closeExpiredPendingPayOrdersShouldDelegateToMapper()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        Mockito.when(orderMapper.closeExpiredPendingPayOrders()).thenReturn(2);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);

        assertEquals(2, service.closeExpiredPendingPayOrders());
    }

    @Test
    void autoCompleteShippedOrdersShouldDelegateToMapper()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        Mockito.when(orderMapper.autoCompleteShippedOrders()).thenReturn(3);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);

        assertEquals(3, service.autoCompleteShippedOrders());
    }
}
