package com.ruoyi.baihou.domain;

import java.math.BigDecimal;
import java.util.List;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou product domain.
 */
public class BaihouProduct extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long id;

    private String name;

    private String skuCode;

    private String brand;

    private String model;

    private Long categoryId;

    private BigDecimal guidePrice;

    private String priceUnit;

    private BigDecimal designerDiscount;

    private String regions;

    private String spaceTags;

    private String sceneTags;

    private String specParams;

    private String description;

    private String status;

    private Integer sortOrder;

    private String delFlag;

    private String keyword;

    private String regionId;

    private String sortBy;

    private Integer pageNum;

    private Integer pageSize;

    private List<BaihouMedia> sceneImages;

    private List<BaihouMedia> elementImages;

    private List<BaihouMedia> specImages;

    private List<BaihouMedia> sourceFiles;

    public BaihouProduct()
    {
    }

    public BaihouProduct(Long id, String name, String skuCode, String status)
    {
        this.id = id;
        this.name = name;
        this.skuCode = skuCode;
        this.status = status;
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getSkuCode()
    {
        return skuCode;
    }

    public void setSkuCode(String skuCode)
    {
        this.skuCode = skuCode;
    }

    public String getBrand()
    {
        return brand;
    }

    public void setBrand(String brand)
    {
        this.brand = brand;
    }

    public String getModel()
    {
        return model;
    }

    public void setModel(String model)
    {
        this.model = model;
    }

    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    public BigDecimal getGuidePrice()
    {
        return guidePrice;
    }

    public void setGuidePrice(BigDecimal guidePrice)
    {
        this.guidePrice = guidePrice;
    }

    public String getPriceUnit()
    {
        return priceUnit;
    }

    public void setPriceUnit(String priceUnit)
    {
        this.priceUnit = priceUnit;
    }

    public BigDecimal getDesignerDiscount()
    {
        return designerDiscount;
    }

    public void setDesignerDiscount(BigDecimal designerDiscount)
    {
        this.designerDiscount = designerDiscount;
    }

    public String getRegions()
    {
        return regions;
    }

    public void setRegions(String regions)
    {
        this.regions = regions;
    }

    public String getSpaceTags()
    {
        return spaceTags;
    }

    public void setSpaceTags(String spaceTags)
    {
        this.spaceTags = spaceTags;
    }

    public String getSceneTags()
    {
        return sceneTags;
    }

    public void setSceneTags(String sceneTags)
    {
        this.sceneTags = sceneTags;
    }

    public String getSpecParams()
    {
        return specParams;
    }

    public void setSpecParams(String specParams)
    {
        this.specParams = specParams;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Integer getSortOrder()
    {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder)
    {
        this.sortOrder = sortOrder;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getKeyword()
    {
        return keyword;
    }

    public void setKeyword(String keyword)
    {
        this.keyword = keyword;
    }

    public String getRegionId()
    {
        return regionId;
    }

    public void setRegionId(String regionId)
    {
        this.regionId = regionId;
    }

    public String getSortBy()
    {
        return sortBy;
    }

    public void setSortBy(String sortBy)
    {
        this.sortBy = sortBy;
    }

    public Integer getPageNum()
    {
        return pageNum;
    }

    public void setPageNum(Integer pageNum)
    {
        this.pageNum = pageNum;
    }

    public Integer getPageSize()
    {
        return pageSize;
    }

    public void setPageSize(Integer pageSize)
    {
        this.pageSize = pageSize;
    }

    public List<BaihouMedia> getSceneImages()
    {
        return sceneImages;
    }

    public void setSceneImages(List<BaihouMedia> sceneImages)
    {
        this.sceneImages = sceneImages;
    }

    public List<BaihouMedia> getElementImages()
    {
        return elementImages;
    }

    public void setElementImages(List<BaihouMedia> elementImages)
    {
        this.elementImages = elementImages;
    }

    public List<BaihouMedia> getSpecImages()
    {
        return specImages;
    }

    public void setSpecImages(List<BaihouMedia> specImages)
    {
        this.specImages = specImages;
    }

    public List<BaihouMedia> getSourceFiles()
    {
        return sourceFiles;
    }

    public void setSourceFiles(List<BaihouMedia> sourceFiles)
    {
        this.sourceFiles = sourceFiles;
    }
}
