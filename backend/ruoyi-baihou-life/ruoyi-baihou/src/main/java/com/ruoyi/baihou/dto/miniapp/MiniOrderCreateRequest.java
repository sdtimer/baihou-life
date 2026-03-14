package com.ruoyi.baihou.dto.miniapp;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 小程序创建订单请求
 */
public class MiniOrderCreateRequest
{
    @JsonProperty("product_id")
    private Long productId;

    @JsonProperty("region_id")
    private String regionId;

    public Long getProductId()
    {
        return productId;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public String getRegionId()
    {
        return regionId;
    }

    public void setRegionId(String regionId)
    {
        this.regionId = regionId;
    }
}
