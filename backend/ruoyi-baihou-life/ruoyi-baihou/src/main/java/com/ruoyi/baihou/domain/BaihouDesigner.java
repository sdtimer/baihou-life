package com.ruoyi.baihou.domain;

import java.math.BigDecimal;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou designer domain.
 */
public class BaihouDesigner extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long designerId;

    private Long userId;

    private String name;

    private String phone;

    private String phoneHash;

    private String company;

    private Long groupId;

    private BigDecimal discount;

    private String status;

    private Integer downloadCount;

    public BaihouDesigner()
    {
    }

    public BaihouDesigner(Long designerId, String name, String phone)
    {
        this.designerId = designerId;
        this.name = name;
        this.phone = phone;
    }

    public Long getDesignerId()
    {
        return designerId;
    }

    public void setDesignerId(Long designerId)
    {
        this.designerId = designerId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
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

    public String getPhoneHash()
    {
        return phoneHash;
    }

    public void setPhoneHash(String phoneHash)
    {
        this.phoneHash = phoneHash;
    }

    public String getCompany()
    {
        return company;
    }

    public void setCompany(String company)
    {
        this.company = company;
    }

    public Long getGroupId()
    {
        return groupId;
    }

    public void setGroupId(Long groupId)
    {
        this.groupId = groupId;
    }

    public BigDecimal getDiscount()
    {
        return discount;
    }

    public void setDiscount(BigDecimal discount)
    {
        this.discount = discount;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Integer getDownloadCount()
    {
        return downloadCount;
    }

    public void setDownloadCount(Integer downloadCount)
    {
        this.downloadCount = downloadCount;
    }
}
