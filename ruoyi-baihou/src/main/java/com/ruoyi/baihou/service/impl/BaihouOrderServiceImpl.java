package com.ruoyi.baihou.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;
import com.ruoyi.baihou.mapper.BaihouOrderMapper;
import com.ruoyi.baihou.service.IBaihouOrderService;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

/**
 * Baihou order service implementation.
 */
@Service
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
}
