package com.ruoyi.baihou.dto.miniapp;

import java.util.List;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 小程序创建订单请求
 */
public class MiniOrderCreateRequest
{
    @JsonProperty("region_id")
    private String regionId;

    private List<MiniOrderItemCreateRequest> items;

    private String remark;

    public String getRegionId()
    {
        return regionId;
    }

    public void setRegionId(String regionId)
    {
        this.regionId = regionId;
    }

    public List<MiniOrderItemCreateRequest> getItems()
    {
        return items;
    }

    public void setItems(List<MiniOrderItemCreateRequest> items)
    {
        this.items = items;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }
}
