package com.ruoyi.baihou.domain;

/**
 * Baihou product media domain.
 */
public class BaihouMedia
{
    private Long mediaId;

    private Long productId;

    private String type;

    private String url;

    private String thumbnailUrl;

    private String originalUrl;

    private String fileFormat;

    private Long fileSize;

    private String fileName;

    private String accessLevel;

    private String assetRole;

    private Integer sortOrder;

    private Integer isCover;

    private Integer width;

    private Integer height;

    public BaihouMedia()
    {
    }

    public BaihouMedia(Long mediaId, String type, String url)
    {
        this.mediaId = mediaId;
        this.type = type;
        this.url = url;
    }

    public Long getMediaId()
    {
        return mediaId;
    }

    public void setMediaId(Long mediaId)
    {
        this.mediaId = mediaId;
    }

    public Long getProductId()
    {
        return productId;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getUrl()
    {
        return url;
    }

    public void setUrl(String url)
    {
        this.url = url;
    }

    public String getThumbnailUrl()
    {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl)
    {
        this.thumbnailUrl = thumbnailUrl;
    }

    public String getOriginalUrl()
    {
        return originalUrl;
    }

    public void setOriginalUrl(String originalUrl)
    {
        this.originalUrl = originalUrl;
    }

    public String getFileFormat()
    {
        return fileFormat;
    }

    public void setFileFormat(String fileFormat)
    {
        this.fileFormat = fileFormat;
    }

    public Long getFileSize()
    {
        return fileSize;
    }

    public void setFileSize(Long fileSize)
    {
        this.fileSize = fileSize;
    }

    public String getFileName()
    {
        return fileName;
    }

    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }

    public String getAccessLevel()
    {
        return accessLevel;
    }

    public void setAccessLevel(String accessLevel)
    {
        this.accessLevel = accessLevel;
    }

    public String getAssetRole()
    {
        return assetRole;
    }

    public void setAssetRole(String assetRole)
    {
        this.assetRole = assetRole;
    }

    public Integer getSortOrder()
    {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder)
    {
        this.sortOrder = sortOrder;
    }

    public Integer getIsCover()
    {
        return isCover;
    }

    public void setIsCover(Integer isCover)
    {
        this.isCover = isCover;
    }

    public Integer getWidth()
    {
        return width;
    }

    public void setWidth(Integer width)
    {
        this.width = width;
    }

    public Integer getHeight()
    {
        return height;
    }

    public void setHeight(Integer height)
    {
        this.height = height;
    }
}
