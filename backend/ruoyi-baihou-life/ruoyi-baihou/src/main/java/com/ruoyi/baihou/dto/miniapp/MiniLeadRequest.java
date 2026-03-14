package com.ruoyi.baihou.dto.miniapp;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 小程序留资请求
 */
public class MiniLeadRequest
{
    private String name;

    private String phone;

    private String intention;

    @JsonProperty("product_id")
    private Long productId;

    @JsonProperty("product_name")
    private String productName;

    @JsonProperty("region_id")
    private String regionId;

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public String getIntention()
    {
        return intention;
    }

    public void setIntention(String intention)
    {
        this.intention = intention;
    }

    public Long getProductId()
    {
        return productId;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public String getProductName()
    {
        return productName;
    }

    public void setProductName(String productName)
    {
        this.productName = productName;
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
