package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;
import com.ruoyi.baihou.dto.miniapp.MiniAppointmentCreateRequest;

/**
 * Baihou appointment service.
 */
public interface IBaihouAppointmentService
{
    List<BaihouAppointment> selectAppointmentList(BaihouAppointment query);

    int updateAppointment(Long appointmentId, BaihouAppointmentUpdateRequest request);

    BaihouAppointment createMiniAppointment(Long uid, MiniAppointmentCreateRequest request);

    List<BaihouAppointment> selectAppointmentListByUserId(Long userId);

    BaihouAppointment selectAppointmentByUser(Long userId, Long appointmentId);
}
