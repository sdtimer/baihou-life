package com.ruoyi.baihou.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;

/**
 * Baihou order mapper.
 */
public interface BaihouOrderMapper
{
    List<BaihouOrder> selectOrderList(BaihouOrder query);

    BaihouOrder selectOrderById(Long orderId);

    int updateOrder(@Param("orderId") Long orderId, @Param("request") BaihouOrderUpdateRequest request);

    int closeExpiredPendingPayOrders();

    int autoCompleteShippedOrders();

    int insertOrder(BaihouOrder order);

    List<BaihouOrder> selectOrderListByUserId(Long userId);

    int updateMiniOrderStatus(@Param("orderId") Long orderId, @Param("status") String status);
}
