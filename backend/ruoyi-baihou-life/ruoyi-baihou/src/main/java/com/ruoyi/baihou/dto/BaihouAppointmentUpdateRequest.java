package com.ruoyi.baihou.dto;

/**
 * Baihou appointment update request.
 */
public class BaihouAppointmentUpdateRequest
{
    private String status;

    private Long assignedTo;

    private String adminNote;

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

    public String getAdminNote()
    {
        return adminNote;
    }

    public void setAdminNote(String adminNote)
    {
        this.adminNote = adminNote;
    }
}
