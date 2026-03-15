package com.ruoyi.baihou.vo.miniapp;

import java.math.BigDecimal;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.ruoyi.baihou.domain.BaihouOrderItem;

/**
 * 小程序订单项 VO
 */
public class MiniOrderItemVO
{
    @JsonProperty("item_id")
    private Long itemId;

    @JsonProperty("product_id")
    private Long productId;

    @JsonProperty("product_name")
    private String productName;

    private Integer quantity;

    @JsonProperty("unit_price")
    private BigDecimal unitPrice;

    @JsonProperty("line_amount")
    private BigDecimal lineAmount;

    public static MiniOrderItemVO from(BaihouOrderItem item)
    {
        MiniOrderItemVO vo = new MiniOrderItemVO();
        vo.itemId = item.getItemId();
        vo.productId = item.getProductId();
        vo.productName = item.getProductName();
        vo.quantity = item.getQuantity();
        vo.unitPrice = item.getUnitPrice();
        vo.lineAmount = item.getLineAmount();
        return vo;
    }

    public Long getItemId() { return itemId; }
    public Long getProductId() { return productId; }
    public String getProductName() { return productName; }
    public Integer getQuantity() { return quantity; }
    public BigDecimal getUnitPrice() { return unitPrice; }
    public BigDecimal getLineAmount() { return lineAmount; }
}
