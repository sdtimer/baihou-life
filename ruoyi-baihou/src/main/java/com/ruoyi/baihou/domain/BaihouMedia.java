package com.ruoyi.baihou.domain;

/**
 * Baihou product media domain.
 */
public class BaihouMedia
{
    private Long mediaId;

    private String type;

    private String url;

    private String thumbnailUrl;

    private String fileFormat;

    private Long fileSize;

    private String fileName;

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
}
