package com.ruoyi.baihou.dto;

/**
 * Baihou lead update request.
 */
public class BaihouLeadUpdateRequest
{
    private String status;

    private Long assignedTo;

    private String followNote;

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
}
