package com.ruoyi.baihou.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;

/**
 * Baihou appointment mapper.
 */
public interface BaihouAppointmentMapper
{
    List<BaihouAppointment> selectAppointmentList(BaihouAppointment query);

    BaihouAppointment selectAppointmentById(Long appointmentId);

    int updateAppointment(@Param("appointmentId") Long appointmentId, @Param("request") BaihouAppointmentUpdateRequest request);

    int insertAppointment(com.ruoyi.baihou.domain.BaihouAppointment appointment);

    List<BaihouAppointment> selectAppointmentListByUserId(Long userId);

    BaihouAppointment selectAppointmentByUser(@Param("userId") Long userId, @Param("appointmentId") Long appointmentId);
}
