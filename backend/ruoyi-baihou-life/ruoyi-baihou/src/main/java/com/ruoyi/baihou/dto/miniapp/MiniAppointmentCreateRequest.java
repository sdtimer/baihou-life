package com.ruoyi.baihou.dto.miniapp;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 小程序创建预约请求
 */
public class MiniAppointmentCreateRequest
{
    @JsonProperty("customer_name")
    private String customerName;

    @JsonProperty("customer_phone")
    private String customerPhone;

    @JsonProperty("service_type")
    private String serviceType;

    @JsonProperty("preferred_date")
    private String preferredDate;

    private String remark;

    @JsonProperty("region_id")
    private String regionId;

    public String getCustomerName()
    {
        return customerName;
    }

    public void setCustomerName(String customerName)
    {
        this.customerName = customerName;
    }

    public String getCustomerPhone()
    {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone)
    {
        this.customerPhone = customerPhone;
    }

    public String getServiceType()
    {
        return serviceType;
    }

    public void setServiceType(String serviceType)
    {
        this.serviceType = serviceType;
    }

    public String getPreferredDate()
    {
        return preferredDate;
    }

    public void setPreferredDate(String preferredDate)
    {
        this.preferredDate = preferredDate;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
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
