package com.ruoyi.baihou.domain;

import java.util.Date;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou banner domain.
 */
public class BaihouBanner extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long bannerId;

    private String title;

    private String imageUrl;

    private String linkType;

    private String linkValue;

    private String regions;

    private Date startTime;

    private Date endTime;

    private Integer sortOrder;

    private Integer isActive;

    public BaihouBanner()
    {
    }

    public BaihouBanner(Long bannerId, String title, String imageUrl)
    {
        this.bannerId = bannerId;
        this.title = title;
        this.imageUrl = imageUrl;
    }

    public Long getBannerId()
    {
        return bannerId;
    }

    public void setBannerId(Long bannerId)
    {
        this.bannerId = bannerId;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getImageUrl()
    {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl)
    {
        this.imageUrl = imageUrl;
    }

    public String getLinkType()
    {
        return linkType;
    }

    public void setLinkType(String linkType)
    {
        this.linkType = linkType;
    }

    public String getLinkValue()
    {
        return linkValue;
    }

    public void setLinkValue(String linkValue)
    {
        this.linkValue = linkValue;
    }

    public String getRegions()
    {
        return regions;
    }

    public void setRegions(String regions)
    {
        this.regions = regions;
    }

    public Date getStartTime()
    {
        return startTime;
    }

    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }

    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    public Integer getSortOrder()
    {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder)
    {
        this.sortOrder = sortOrder;
    }

    public Integer getIsActive()
    {
        return isActive;
    }

    public void setIsActive(Integer isActive)
    {
        this.isActive = isActive;
    }
}
