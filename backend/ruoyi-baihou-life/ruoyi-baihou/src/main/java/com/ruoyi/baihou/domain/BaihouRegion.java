package com.ruoyi.baihou.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou region domain.
 */
public class BaihouRegion extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private String regionId;

    private String regionName;

    private String province;

    private Double centerLat;

    private Double centerLng;

    private Integer isActive;

    private Integer sortOrder;

    public BaihouRegion()
    {
    }

    public BaihouRegion(String regionId, String regionName)
    {
        this.regionId = regionId;
        this.regionName = regionName;
    }

    public String getRegionId()
    {
        return regionId;
    }

    public void setRegionId(String regionId)
    {
        this.regionId = regionId;
    }

    public String getRegionName()
    {
        return regionName;
    }

    public void setRegionName(String regionName)
    {
        this.regionName = regionName;
    }

    public String getProvince()
    {
        return province;
    }

    public void setProvince(String province)
    {
        this.province = province;
    }

    public Double getCenterLat()
    {
        return centerLat;
    }

    public void setCenterLat(Double centerLat)
    {
        this.centerLat = centerLat;
    }

    public Double getCenterLng()
    {
        return centerLng;
    }

    public void setCenterLng(Double centerLng)
    {
        this.centerLng = centerLng;
    }

    public Integer getIsActive()
    {
        return isActive;
    }

    public void setIsActive(Integer isActive)
    {
        this.isActive = isActive;
    }

    public Integer getSortOrder()
    {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder)
    {
        this.sortOrder = sortOrder;
    }
}
