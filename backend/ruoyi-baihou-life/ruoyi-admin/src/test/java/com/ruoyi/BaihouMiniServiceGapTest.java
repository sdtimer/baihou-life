package com.ruoyi;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.domain.BaihouOrderItem;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.dto.miniapp.MiniAppointmentCreateRequest;
import com.ruoyi.baihou.dto.miniapp.MiniLeadRequest;
import com.ruoyi.baihou.dto.miniapp.MiniOrderItemCreateRequest;
import com.ruoyi.baihou.mapper.BaihouAppointmentMapper;
import com.ruoyi.baihou.mapper.BaihouLeadMapper;
import com.ruoyi.baihou.mapper.BaihouOrderMapper;
import com.ruoyi.baihou.mapper.BaihouOrderItemMapper;
import com.ruoyi.baihou.mapper.BaihouProductMapper;
import com.ruoyi.baihou.service.impl.BaihouAppointmentServiceImpl;
import com.ruoyi.baihou.service.impl.BaihouLeadServiceImpl;
import com.ruoyi.baihou.service.impl.BaihouOrderServiceImpl;
import com.ruoyi.common.exception.ServiceException;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;
import com.ruoyi.common.context.BaihouMiniContext;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class BaihouMiniServiceGapTest
{
    @Test
    void createMiniLeadShouldRejectRecentDuplicateLead()
    {
        BaihouLeadMapper leadMapper = Mockito.mock(BaihouLeadMapper.class);
        Mockito.when(leadMapper.countRecentDuplicateLead(10001L, 20001L, "13800001111")).thenReturn(1);

        BaihouLeadServiceImpl service = new BaihouLeadServiceImpl();
        ReflectionTestUtils.setField(service, "leadMapper", leadMapper);

        MiniLeadRequest request = new MiniLeadRequest();
        request.setPhone("13800001111");
        request.setName("张三");
        request.setProductId(20001L);
        request.setRegionId("foshan");

        assertThrows(ServiceException.class, () -> service.createMiniLead(10001L, request));
    }

    @Test
    void createMiniAppointmentShouldRejectPastDateAndInvalidPhone()
    {
        BaihouAppointmentMapper appointmentMapper = Mockito.mock(BaihouAppointmentMapper.class);

        BaihouAppointmentServiceImpl service = new BaihouAppointmentServiceImpl();
        ReflectionTestUtils.setField(service, "appointmentMapper", appointmentMapper);

        MiniAppointmentCreateRequest request = new MiniAppointmentCreateRequest();
        request.setCustomerName("李四");
        request.setCustomerPhone("123");
        request.setServiceType("measure");
        request.setPreferredDate(LocalDate.now().minusDays(1).toString());
        request.setRegionId("foshan");

        assertThrows(ServiceException.class, () -> service.createMiniAppointment(10001L, request));
    }

    @Test
    void selectAppointmentByUserShouldExposeDetailLookup()
    {
        BaihouAppointmentMapper appointmentMapper = Mockito.mock(BaihouAppointmentMapper.class);
        BaihouAppointment appointment = new BaihouAppointment(3001L, "APT202603140001", "pending");
        appointment.setUserId(10001L);
        Mockito.when(appointmentMapper.selectAppointmentByUser(10001L, 3001L)).thenReturn(appointment);

        BaihouAppointmentServiceImpl service = new BaihouAppointmentServiceImpl();
        ReflectionTestUtils.setField(service, "appointmentMapper", appointmentMapper);

        assertEquals(appointment, service.selectAppointmentByUser(10001L, 3001L));
    }

    @Test
    void createMiniOrderShouldRejectCrossRegionProduct()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouProduct product = new BaihouProduct(1001L, "测试商品", "BH-001", "on_shelf");
        product.setGuidePrice(new BigDecimal("1280.00"));
        product.setRegions("[\"chengdu\"]");
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(product);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest request = new com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest();
        request.setRegionId("foshan");
        request.setItems(List.of(item(1001L, 1)));

        assertThrows(ServiceException.class, () -> service.createMiniOrder(10001L, request));
    }

    @Test
    void createMiniOrderShouldPersistOrderItemsAndSummaryForCustomer()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouProduct productA = new BaihouProduct(1001L, "测试商品A", "BH-001", "on_shelf");
        productA.setGuidePrice(new BigDecimal("1280.00"));
        productA.setDesignerDiscount(new BigDecimal("0.85"));
        productA.setRegions("[\"foshan\"]");
        BaihouProduct productB = new BaihouProduct(1002L, "测试商品B", "BH-002", "on_shelf");
        productB.setGuidePrice(new BigDecimal("860.00"));
        productB.setDesignerDiscount(new BigDecimal("0.80"));
        productB.setRegions("[\"foshan\"]");
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(productA);
        Mockito.when(productMapper.selectProductById(1002L)).thenReturn(productB);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest request = new com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest();
        request.setRegionId("foshan");
        request.setItems(List.of(item(1001L, 1), item(1002L, 2)));
        request.setRemark("测试多商品订单");

        BaihouMiniContext.set(10001L, 1, "openid");
        service.createMiniOrder(10001L, request);

        ArgumentCaptor<BaihouOrder> orderCaptor = ArgumentCaptor.forClass(BaihouOrder.class);
        Mockito.verify(orderMapper).insertOrder(orderCaptor.capture());
        BaihouOrder created = orderCaptor.getValue();
        assertEquals("测试商品A 等2件", created.getProductSummary());
        assertEquals(3, created.getItemCount());
        assertEquals(new BigDecimal("3000.00"), created.getPayAmount());

        @SuppressWarnings("unchecked")
        ArgumentCaptor<List<BaihouOrderItem>> itemCaptor = ArgumentCaptor.forClass(List.class);
        Mockito.verify(orderItemMapper).batchInsertOrderItems(itemCaptor.capture());
        List<BaihouOrderItem> createdItems = itemCaptor.getValue();
        assertEquals(2, createdItems.size());
        assertEquals("测试商品A", createdItems.get(0).getProductName());
        assertEquals(1, createdItems.get(0).getQuantity().intValue());
        assertEquals(new BigDecimal("1280.00"), createdItems.get(0).getLineAmount());
        assertEquals("测试商品B", createdItems.get(1).getProductName());
        assertEquals(2, createdItems.get(1).getQuantity().intValue());
        assertEquals(new BigDecimal("1720.00"), createdItems.get(1).getLineAmount());
        BaihouMiniContext.clear();
    }

    @Test
    void createMiniOrderShouldApplyDesignerDiscountToEachOrderItem()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouProduct productA = new BaihouProduct(1001L, "测试商品A", "BH-001", "on_shelf");
        productA.setGuidePrice(new BigDecimal("1280.00"));
        productA.setDesignerDiscount(new BigDecimal("0.85"));
        productA.setRegions("[\"foshan\"]");
        BaihouProduct productB = new BaihouProduct(1002L, "测试商品B", "BH-002", "on_shelf");
        productB.setGuidePrice(new BigDecimal("860.00"));
        productB.setDesignerDiscount(new BigDecimal("0.80"));
        productB.setRegions("[\"foshan\"]");
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(productA);
        Mockito.when(productMapper.selectProductById(1002L)).thenReturn(productB);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest request = new com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest();
        request.setRegionId("foshan");
        request.setItems(List.of(item(1001L, 1), item(1002L, 2)));

        BaihouMiniContext.set(10001L, 2, "openid");
        service.createMiniOrder(10001L, request);

        ArgumentCaptor<BaihouOrder> orderCaptor = ArgumentCaptor.forClass(BaihouOrder.class);
        Mockito.verify(orderMapper).insertOrder(orderCaptor.capture());
        BaihouOrder created = orderCaptor.getValue();
        assertEquals(new BigDecimal("2464.00"), created.getPayAmount());
        assertEquals(created.getPayAmount(), created.getTotalAmount());

        @SuppressWarnings("unchecked")
        ArgumentCaptor<List<BaihouOrderItem>> itemCaptor = ArgumentCaptor.forClass(List.class);
        Mockito.verify(orderItemMapper).batchInsertOrderItems(itemCaptor.capture());
        List<BaihouOrderItem> createdItems = itemCaptor.getValue();
        assertEquals(new BigDecimal("1088.00"), createdItems.get(0).getUnitPrice());
        assertEquals(new BigDecimal("1088.00"), createdItems.get(0).getLineAmount());
        assertEquals(new BigDecimal("688.00"), createdItems.get(1).getUnitPrice());
        assertEquals(new BigDecimal("1376.00"), createdItems.get(1).getLineAmount());
        BaihouMiniContext.clear();
    }

    @Test
    void buildMiniPrepayShouldRequirePendingPayOrder()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouOrder order = new BaihouOrder();
        order.setOrderId(2001L);
        order.setOrderNo("ORD202603140001");
        order.setUserId(10001L);
        order.setStatus("paid");
        Mockito.when(orderMapper.selectOrderById(2001L)).thenReturn(order);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertThrows(ServiceException.class, () -> service.buildMiniPrepay(10001L, 2001L));
    }

    @Test
    void markMiniOrderPaidShouldUpdateStatus()
    {
        BaihouOrderMapper orderMapper = Mockito.mock(BaihouOrderMapper.class);
        BaihouOrderItemMapper orderItemMapper = Mockito.mock(BaihouOrderItemMapper.class);
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouOrder order = new BaihouOrder();
        order.setOrderId(2001L);
        order.setStatus("pending_pay");
        order.setUserId(10001L);
        Mockito.when(orderMapper.selectOrderById(2001L)).thenReturn(order);
        Mockito.when(orderMapper.updateMiniOrderStatus(2001L, "paid")).thenReturn(1);

        BaihouOrderServiceImpl service = new BaihouOrderServiceImpl();
        ReflectionTestUtils.setField(service, "orderMapper", orderMapper);
        ReflectionTestUtils.setField(service, "orderItemMapper", orderItemMapper);
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertEquals(1, service.markMiniOrderPaid(10001L, 2001L));
    }

    private MiniOrderItemCreateRequest item(Long productId, Integer quantity)
    {
        MiniOrderItemCreateRequest item = new MiniOrderItemCreateRequest();
        item.setProductId(productId);
        item.setQuantity(quantity);
        return item;
    }
}
