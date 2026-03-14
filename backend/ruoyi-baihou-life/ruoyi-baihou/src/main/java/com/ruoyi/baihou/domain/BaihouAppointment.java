package com.ruoyi.baihou.domain;

import java.util.Date;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou appointment domain.
 */
public class BaihouAppointment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long appointmentId;

    private String appointmentNo;

    private Long userId;

    private String customerName;

    private String customerPhone;

    private String serviceType;

    private Date preferredDate;

    private String preferredTime;

    private String address;

    private String remark;

    private Long productId;

    private String regionId;

    private String status;

    private Long assignedTo;

    private String adminNote;

    public BaihouAppointment()
    {
    }

    public BaihouAppointment(Long appointmentId, String appointmentNo, String status)
    {
        this.appointmentId = appointmentId;
        this.appointmentNo = appointmentNo;
        this.status = status;
    }

    public Long getAppointmentId()
    {
        return appointmentId;
    }

    public void setAppointmentId(Long appointmentId)
    {
        this.appointmentId = appointmentId;
    }

    public String getAppointmentNo()
    {
        return appointmentNo;
    }

    public void setAppointmentNo(String appointmentNo)
    {
        this.appointmentNo = appointmentNo;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getCustomerName()
    {
        return customerName;
    }

    public void setCustomerName(String customerName)
    {
        this.customerName = customerName;
    }

    public String getCustomerPhone()
    {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone)
    {
        this.customerPhone = customerPhone;
    }

    public String getServiceType()
    {
        return serviceType;
    }

    public void setServiceType(String serviceType)
    {
        this.serviceType = serviceType;
    }

    public Date getPreferredDate()
    {
        return preferredDate;
    }

    public void setPreferredDate(Date preferredDate)
    {
        this.preferredDate = preferredDate;
    }

    public String getPreferredTime()
    {
        return preferredTime;
    }

    public void setPreferredTime(String preferredTime)
    {
        this.preferredTime = preferredTime;
    }

    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public Long getProductId()
    {
        return productId;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public String getRegionId()
    {
        return regionId;
    }

    public void setRegionId(String regionId)
    {
        this.regionId = regionId;
    }

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
