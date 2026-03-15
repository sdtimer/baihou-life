package com.ruoyi.baihou.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou lead domain.
 */
public class BaihouLead extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Excel(name = "线索ID")
    private Long leadId;

    private Long userId;

    @Excel(name = "商品ID")
    private Long productId;

    @Excel(name = "品类ID")
    private Long categoryId;

    @Excel(name = "商品名称")
    private String productName;

    @Excel(name = "客户姓名")
    private String name;

    @Excel(name = "手机号")
    private String phone;

    @Excel(name = "区域")
    private String regionId;

    @Excel(name = "状态")
    private String status;

    @Excel(name = "分配给")
    private Long assignedTo;

    @Excel(name = "跟进记录")
    private String followNote;

    private String startDate;

    private String endDate;

    public BaihouLead()
    {
    }

    public BaihouLead(Long leadId, String regionId, String status)
    {
        this.leadId = leadId;
        this.regionId = regionId;
        this.status = status;
    }

    public Long getLeadId()
    {
        return leadId;
    }

    public void setLeadId(Long leadId)
    {
        this.leadId = leadId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
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

    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

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

    public String getRegionId()
    {
        return regionId;
    }

    public void setRegionId(String regionId)
    {
        this.regionId = regionId;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Long getAssignedTo()
    {
        return assignedTo;
    }

    public void setAssignedTo(Long assignedTo)
    {
        this.assignedTo = assignedTo;
    }

    public String getFollowNote()
    {
        return followNote;
    }

    public void setFollowNote(String followNote)
    {
        this.followNote = followNote;
    }

    public String getStartDate()
    {
        return startDate;
    }

    public void setStartDate(String startDate)
    {
        this.startDate = startDate;
    }

    public String getEndDate()
    {
        return endDate;
    }

    public void setEndDate(String endDate)
    {
        this.endDate = endDate;
    }
}
