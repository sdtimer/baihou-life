package com.ruoyi.baihou.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;
import com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest;
import com.ruoyi.baihou.mapper.BaihouOrderMapper;
import com.ruoyi.baihou.mapper.BaihouProductMapper;
import com.ruoyi.baihou.service.IBaihouOrderService;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.context.BaihouMiniContext;

/**
 * Baihou order service implementation.
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BaihouOrderServiceImpl implements IBaihouOrderService
{
    private static final Map<String, Set<String>> ALLOWED_TRANSITIONS = Map.of(
            "pending_pay", Set.of("closed"),
            "paid", Set.of("processing", "closed"),
            "processing", Set.of("shipped", "closed"),
            "shipped", Set.of("completed"),
            "completed", Set.of(),
            "closed", Set.of());

    @Autowired
    private BaihouOrderMapper orderMapper;

    @Autowired
    private BaihouProductMapper productMapper;

    @Override
    public List<BaihouOrder> selectOrderList(BaihouOrder query)
    {
        return orderMapper.selectOrderList(query);
    }

    @Override
    public BaihouOrder selectOrderById(Long orderId)
    {
        return orderMapper.selectOrderById(orderId);
    }

    @Override
    public int updateOrder(Long orderId, BaihouOrderUpdateRequest request)
    {
        BaihouOrder current = orderMapper.selectOrderById(orderId);
        if (current == null)
        {
            throw new ServiceException("订单不存在");
        }
        validateTransition(current.getStatus(), request);
        return orderMapper.updateOrder(orderId, request);
    }

    @Override
    public int closeExpiredPendingPayOrders()
    {
        return orderMapper.closeExpiredPendingPayOrders();
    }

    @Override
    public int autoCompleteShippedOrders()
    {
        return orderMapper.autoCompleteShippedOrders();
    }

    @Override
    public BaihouOrder createMiniOrder(Long uid, MiniOrderCreateRequest request)
    {
        BaihouProduct product = productMapper.selectProductById(request.getProductId());
        if (product == null || !"on_shelf".equals(product.getStatus()))
        {
            throw new ServiceException("商品不存在或已下架");
        }
        if (request.getRegionId() == null || request.getRegionId().isBlank())
        {
            throw new ServiceException("区域不能为空");
        }
        if (!regionMatches(product.getRegions(), request.getRegionId()))
        {
            throw new ServiceException("当前区域不可售");
        }

        BigDecimal price = resolveMiniOrderPrice(product, BaihouMiniContext.getRole());
        String orderNo = "ORD" + System.currentTimeMillis();

        BaihouOrder order = new BaihouOrder();
        order.setOrderNo(orderNo);
        order.setUserId(uid);
        order.setRegionId(request.getRegionId());
        order.setProductId(product.getId());
        order.setProductName(product.getName());
        order.setUnitPrice(price);
        order.setTotalAmount(price);
        order.setPayAmount(price);
        order.setStatus("pending_pay");
        // 30 分钟后过期
        order.setExpiresAt(new Date(System.currentTimeMillis() + 30L * 60 * 1000));

        orderMapper.insertOrder(order);
        return order;
    }

    @Override
    public List<BaihouOrder> selectOrderListByUserId(Long userId)
    {
        return orderMapper.selectOrderListByUserId(userId);
    }

    @Override
    public Map<String, Object> buildMiniPrepay(Long uid, Long orderId)
    {
        BaihouOrder order = requireMiniOrderOwner(uid, orderId);
        if (!"pending_pay".equals(order.getStatus()))
        {
            throw new ServiceException("当前订单不可发起支付");
        }
        Map<String, Object> payment = new HashMap<>();
        payment.put("timeStamp", String.valueOf(System.currentTimeMillis() / 1000));
        payment.put("nonceStr", "mock-" + orderId);
        payment.put("package", "prepay_id=mock_" + orderId);
        payment.put("signType", "RSA");
        payment.put("paySign", "mock-sign-" + orderId);
        payment.put("mode", "mock");

        Map<String, Object> data = new HashMap<>();
        data.put("order_id", order.getOrderId());
        data.put("order_no", order.getOrderNo());
        data.put("payment", payment);
        return data;
    }

    @Override
    public int markMiniOrderPaid(Long uid, Long orderId)
    {
        BaihouOrder order = requireMiniOrderOwner(uid, orderId);
        if (!"pending_pay".equals(order.getStatus()))
        {
            throw new ServiceException("当前订单状态不可更新为已支付");
        }
        return orderMapper.updateMiniOrderStatus(orderId, "paid");
    }

    private void validateTransition(String currentStatus, BaihouOrderUpdateRequest request)
    {
        String nextStatus = request.getStatus();
        if (nextStatus == null || nextStatus.isBlank() || nextStatus.equals(currentStatus))
        {
            return;
        }
        Set<String> allowedTargets = ALLOWED_TRANSITIONS.get(currentStatus);
        if (allowedTargets == null || !allowedTargets.contains(nextStatus))
        {
            throw new ServiceException("订单状态流转非法");
        }
        if ("shipped".equals(nextStatus) && StringUtils.isEmpty(request.getTrackingNo()))
        {
            throw new ServiceException("发货必须填写物流单号");
        }
    }

    private BigDecimal resolveMiniOrderPrice(BaihouProduct product, Integer role)
    {
        BigDecimal guidePrice = product.getGuidePrice() != null ? product.getGuidePrice() : BigDecimal.ZERO;
        if (Integer.valueOf(2).equals(role) && product.getDesignerDiscount() != null)
        {
            return guidePrice.multiply(product.getDesignerDiscount()).setScale(2, RoundingMode.HALF_UP);
        }
        return guidePrice.setScale(2, RoundingMode.HALF_UP);
    }

    private boolean regionMatches(String regions, String regionId)
    {
        if (regions == null || regions.isBlank())
        {
            return false;
        }
        return regions.contains("\"ALL\"") || regions.contains("\"" + regionId + "\"");
    }

    private BaihouOrder requireMiniOrderOwner(Long uid, Long orderId)
    {
        BaihouOrder order = orderMapper.selectOrderById(orderId);
        if (order == null || order.getUserId() == null || !order.getUserId().equals(uid))
        {
            throw new ServiceException("订单不存在");
        }
        return order;
    }
}
