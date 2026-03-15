package com.ruoyi.baihou.dto.miniapp;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 小程序创建订单项请求
 */
public class MiniOrderItemCreateRequest
{
    @JsonProperty("product_id")
    private Long productId;

    private Integer quantity;

    public Long getProductId()
    {
        return productId;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public Integer getQuantity()
    {
        return quantity;
    }

    public void setQuantity(Integer quantity)
    {
        this.quantity = quantity;
    }
}
