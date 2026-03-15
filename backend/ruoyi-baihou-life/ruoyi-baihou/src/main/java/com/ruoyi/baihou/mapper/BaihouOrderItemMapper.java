package com.ruoyi.baihou.mapper;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouOrderItem;

/**
 * Baihou order item mapper.
 */
public interface BaihouOrderItemMapper
{
    int batchInsertOrderItems(List<BaihouOrderItem> items);

    List<BaihouOrderItem> selectOrderItemsByOrderId(Long orderId);
}
