package com.ruoyi.baihou.vo.miniapp;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.ruoyi.baihou.domain.BaihouMedia;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.common.utils.StringUtils;

/**
 * 小程序商品 VO（snake_case 字段名）
 */
public class MiniProductVO
{
    private Long id;

    private String name;

    @JsonProperty("sku_code")
    private String skuCode;

    private String brand;

    private String model;

    @JsonProperty("category_id")
    private Long categoryId;

    @JsonProperty("guide_price")
    private BigDecimal guidePrice;

    @JsonProperty("price_unit")
    private String priceUnit;

    @JsonProperty("designer_price")
    private BigDecimal designerPrice;

    @JsonProperty("designer_discount")
    private BigDecimal designerDiscount;

    private String regions;

    @JsonProperty("space_tags")
    private String spaceTags;

    @JsonProperty("scene_tags")
    private String sceneTags;

    @JsonProperty("spec_params")
    private String specParams;

    private String description;

    private String status;

    @JsonProperty("sort_order")
    private Integer sortOrder;

    /** 封面图片完整 URL（小程序卡片展示用） */
    @JsonProperty("cover_image")
    private String coverImage;

    @JsonProperty("scene_images")
    private List<BaihouMedia> sceneImages;

    @JsonProperty("element_images")
    private List<BaihouMedia> elementImages;

    @JsonProperty("spec_images")
    private List<BaihouMedia> specImages;

    @JsonProperty("source_files")
    private List<BaihouMedia> sourceFiles;

    /**
     * 从 BaihouProduct 转换，role=2（设计师）时显示折扣价
     */
    public static MiniProductVO from(BaihouProduct p, Integer role, String serverBaseUrl)
    {
        MiniProductVO vo = new MiniProductVO();
        vo.id = p.getId();
        vo.name = p.getName();
        vo.skuCode = p.getSkuCode();
        vo.brand = p.getBrand();
        vo.model = p.getModel();
        vo.categoryId = p.getCategoryId();
        vo.guidePrice = Integer.valueOf(0).equals(role) || role == null ? null : p.getGuidePrice();
        vo.priceUnit = p.getPriceUnit();
        vo.designerDiscount = p.getDesignerDiscount();
        vo.regions = p.getRegions();
        vo.spaceTags = p.getSpaceTags();
        vo.sceneTags = p.getSceneTags();
        vo.specParams = p.getSpecParams();
        vo.description = p.getDescription();
        vo.status = p.getStatus();
        vo.sortOrder = p.getSortOrder();
        vo.sceneImages = p.getSceneImages();
        vo.elementImages = p.getElementImages();
        vo.specImages = p.getSpecImages();
        vo.sourceFiles = Integer.valueOf(2).equals(role) ? p.getSourceFiles() : null;

        // 计算 cover_image：取第一张 scene 图，相对路径自动拼完整 URL
        if (p.getSceneImages() != null && !p.getSceneImages().isEmpty())
        {
            String rawUrl = p.getSceneImages().get(0).getUrl();
            if (StringUtils.isNotEmpty(rawUrl) && rawUrl.startsWith("/") && StringUtils.isNotEmpty(serverBaseUrl))
            {
                vo.coverImage = serverBaseUrl + rawUrl;
            }
            else
            {
                vo.coverImage = rawUrl;
            }
        }

        // 计算 designer_price = guide_price × designer_discount
        if (Integer.valueOf(2).equals(role)
                && p.getGuidePrice() != null
                && p.getDesignerDiscount() != null)
        {
            vo.designerPrice = p.getGuidePrice()
                    .multiply(p.getDesignerDiscount())
                    .setScale(2, RoundingMode.HALF_UP);
        }
        return vo;
    }

    public Long getId() { return id; }
    public String getName() { return name; }
    public String getSkuCode() { return skuCode; }
    public String getBrand() { return brand; }
    public String getModel() { return model; }
    public Long getCategoryId() { return categoryId; }
    public BigDecimal getGuidePrice() { return guidePrice; }
    public String getPriceUnit() { return priceUnit; }
    public BigDecimal getDesignerPrice() { return designerPrice; }
    public BigDecimal getDesignerDiscount() { return designerDiscount; }
    public String getRegions() { return regions; }
    public String getSpaceTags() { return spaceTags; }
    public String getSceneTags() { return sceneTags; }
    public String getSpecParams() { return specParams; }
    public String getDescription() { return description; }
    public String getStatus() { return status; }
    public Integer getSortOrder() { return sortOrder; }
    public String getCoverImage() { return coverImage; }
    public List<BaihouMedia> getSceneImages() { return sceneImages; }
    public List<BaihouMedia> getElementImages() { return elementImages; }
    public List<BaihouMedia> getSpecImages() { return specImages; }
    public List<BaihouMedia> getSourceFiles() { return sourceFiles; }
}
