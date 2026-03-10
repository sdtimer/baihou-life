package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;

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
}
