package com.ruoyi.baihou.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou category domain.
 */
public class BaihouCategory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long categoryId;

    private Long parentId;

    private String categoryName;

    private String iconUrl;

    private Integer sortOrder;

    private Integer isActive;

    public BaihouCategory()
    {
    }

    public BaihouCategory(Long categoryId, String categoryName)
    {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }

    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    public Long getParentId()
    {
        return parentId;
    }

    public void setParentId(Long parentId)
    {
        this.parentId = parentId;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }

    public String getIconUrl()
    {
        return iconUrl;
    }

    public void setIconUrl(String iconUrl)
    {
        this.iconUrl = iconUrl;
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
