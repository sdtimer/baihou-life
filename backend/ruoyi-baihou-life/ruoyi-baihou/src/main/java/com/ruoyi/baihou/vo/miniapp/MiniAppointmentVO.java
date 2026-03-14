package com.ruoyi.baihou.vo.miniapp;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.ruoyi.baihou.domain.BaihouAppointment;

/**
 * 小程序预约 VO（snake_case 字段名）
 */
public class MiniAppointmentVO
{
    @JsonProperty("appointment_id")
    private Long appointmentId;

    @JsonProperty("appointment_no")
    private String appointmentNo;

    @JsonProperty("customer_name")
    private String customerName;

    @JsonProperty("customer_phone")
    private String customerPhone;

    @JsonProperty("service_type")
    private String serviceType;

    @JsonProperty("preferred_date")
    private Date preferredDate;

    @JsonProperty("region_id")
    private String regionId;

    private String remark;

    private String status;

    @JsonProperty("create_time")
    private Date createTime;

    public static MiniAppointmentVO from(BaihouAppointment a)
    {
        MiniAppointmentVO vo = new MiniAppointmentVO();
        vo.appointmentId = a.getAppointmentId();
        vo.appointmentNo = a.getAppointmentNo();
        vo.customerName = a.getCustomerName();
        vo.customerPhone = a.getCustomerPhone();
        vo.serviceType = a.getServiceType();
        vo.preferredDate = a.getPreferredDate();
        vo.regionId = a.getRegionId();
        vo.remark = a.getRemark();
        vo.status = a.getStatus();
        vo.createTime = a.getCreateTime();
        return vo;
    }

    public Long getAppointmentId() { return appointmentId; }
    public String getAppointmentNo() { return appointmentNo; }
    public String getCustomerName() { return customerName; }
    public String getCustomerPhone() { return customerPhone; }
    public String getServiceType() { return serviceType; }
    public Date getPreferredDate() { return preferredDate; }
    public String getRegionId() { return regionId; }
    public String getRemark() { return remark; }
    public String getStatus() { return status; }
    public Date getCreateTime() { return createTime; }
}
