package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;

/**
 * Baihou appointment service.
 */
public interface IBaihouAppointmentService
{
    List<BaihouAppointment> selectAppointmentList(BaihouAppointment query);

    int updateAppointment(Long appointmentId, BaihouAppointmentUpdateRequest request);
}
