package com.ruoyi.baihou.domain;

import java.math.BigDecimal;

/**
 * Baihou designer group domain.
 */
public class BaihouDesignerGroup
{
    private Long groupId;

    private String groupName;

    private BigDecimal defaultDiscount;

    public BaihouDesignerGroup()
    {
    }

    public BaihouDesignerGroup(Long groupId, String groupName)
    {
        this.groupId = groupId;
        this.groupName = groupName;
    }

    public Long getGroupId()
    {
        return groupId;
    }

    public void setGroupId(Long groupId)
    {
        this.groupId = groupId;
    }

    public String getGroupName()
    {
        return groupName;
    }

    public void setGroupName(String groupName)
    {
        this.groupName = groupName;
    }

    public BigDecimal getDefaultDiscount()
    {
        return defaultDiscount;
    }

    public void setDefaultDiscount(BigDecimal defaultDiscount)
    {
        this.defaultDiscount = defaultDiscount;
    }
}
