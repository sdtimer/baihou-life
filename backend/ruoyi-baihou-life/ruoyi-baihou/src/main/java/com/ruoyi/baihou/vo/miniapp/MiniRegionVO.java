package com.ruoyi.baihou.vo.miniapp;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ruoyi.baihou.domain.BaihouRegion;

/**
 * 小程序区域 VO（snake_case 字段名）
 */
public class MiniRegionVO
{
    @JsonProperty("region_id")
    private String regionId;

    @JsonProperty("region_name")
    private String regionName;

    private String province;

    @JsonProperty("is_active")
    private boolean active;

    @JsonProperty("sort_order")
    private Integer sortOrder;

    public static MiniRegionVO from(BaihouRegion r)
    {
        MiniRegionVO vo = new MiniRegionVO();
        vo.regionId = r.getRegionId();
        vo.regionName = r.getRegionName();
        vo.province = r.getProvince();
        vo.active = Integer.valueOf(1).equals(r.getIsActive());
        vo.sortOrder = r.getSortOrder();
        return vo;
    }

    public String getRegionId() { return regionId; }
    public String getRegionName() { return regionName; }
    public String getProvince() { return province; }
    public boolean isActive() { return active; }
    public Integer getSortOrder() { return sortOrder; }
}
