package com.ruoyi.baihou.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou category spec definition domain.
 */
public class BaihouCategorySpecDef extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long specDefId;

    private Long categoryId;

    private String specKey;

    private String specLabel;

    /** text / number / select */
    private String inputType;

    /** JSON array string for select options */
    private String options;

    private String unit;

    private Integer isRequired;

    private Integer sortOrder;

    public Long getSpecDefId()
    {
        return specDefId;
    }

    public void setSpecDefId(Long specDefId)
    {
        this.specDefId = specDefId;
    }

    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    public String getSpecKey()
    {
        return specKey;
    }

    public void setSpecKey(String specKey)
    {
        this.specKey = specKey;
    }

    public String getSpecLabel()
    {
        return specLabel;
    }

    public void setSpecLabel(String specLabel)
    {
        this.specLabel = specLabel;
    }

    public String getInputType()
    {
        return inputType;
    }

    public void setInputType(String inputType)
    {
        this.inputType = inputType;
    }

    public String getOptions()
    {
        return options;
    }

    public void setOptions(String options)
    {
        this.options = options;
    }

    public String getUnit()
    {
        return unit;
    }

    public void setUnit(String unit)
    {
        this.unit = unit;
    }

    public Integer getIsRequired()
    {
        return isRequired;
    }

    public void setIsRequired(Integer isRequired)
    {
        this.isRequired = isRequired;
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
