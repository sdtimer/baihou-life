package com.ruoyi.baihou.dto;

/**
 * Baihou order update request.
 */
public class BaihouOrderUpdateRequest
{
    private String status;

    private String trackingNo;

    private String adminNote;

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getTrackingNo()
    {
        return trackingNo;
    }

    public void setTrackingNo(String trackingNo)
    {
        this.trackingNo = trackingNo;
    }

    public String getAdminNote()
    {
        return adminNote;
    }

    public void setAdminNote(String adminNote)
    {
        this.adminNote = adminNote;
    }
}
