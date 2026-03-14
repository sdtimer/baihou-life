package com.ruoyi.baihou.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;
import com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest;

/**
 * Baihou order service.
 */
public interface IBaihouOrderService
{
    List<BaihouOrder> selectOrderList(BaihouOrder query);

    BaihouOrder selectOrderById(Long orderId);

    int updateOrder(Long orderId, BaihouOrderUpdateRequest request);

    int closeExpiredPendingPayOrders();

    int autoCompleteShippedOrders();

    BaihouOrder createMiniOrder(Long uid, MiniOrderCreateRequest request);

    List<BaihouOrder> selectOrderListByUserId(Long userId);

    Map<String, Object> buildMiniPrepay(Long uid, Long orderId);

    int markMiniOrderPaid(Long uid, Long orderId);
}
