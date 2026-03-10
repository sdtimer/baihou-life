package com.ruoyi.baihou.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;
import com.ruoyi.baihou.mapper.BaihouAppointmentMapper;
import com.ruoyi.baihou.service.IBaihouAppointmentService;
import com.ruoyi.common.exception.ServiceException;

/**
 * Baihou appointment service implementation.
 */
@Service
public class BaihouAppointmentServiceImpl implements IBaihouAppointmentService
{
    private static final Map<String, Set<String>> ALLOWED_TRANSITIONS = Map.of(
            "pending", Set.of("confirmed", "cancelled"),
            "confirmed", Set.of("in_progress", "cancelled"),
            "in_progress", Set.of("completed"),
            "completed", Set.of(),
            "cancelled", Set.of());

    @Autowired
    private BaihouAppointmentMapper appointmentMapper;

    @Override
    public List<BaihouAppointment> selectAppointmentList(BaihouAppointment query)
    {
        return appointmentMapper.selectAppointmentList(query);
    }

    @Override
    public int updateAppointment(Long appointmentId, BaihouAppointmentUpdateRequest request)
    {
        BaihouAppointment current = appointmentMapper.selectAppointmentById(appointmentId);
        if (current == null)
        {
            throw new ServiceException("预约不存在");
        }
        validateTransition(current.getStatus(), request.getStatus());
        return appointmentMapper.updateAppointment(appointmentId, request);
    }

    private void validateTransition(String currentStatus, String nextStatus)
    {
        if (nextStatus == null || nextStatus.isBlank() || nextStatus.equals(currentStatus))
        {
            return;
        }
        Set<String> allowedTargets = ALLOWED_TRANSITIONS.get(currentStatus);
        if (allowedTargets == null || !allowedTargets.contains(nextStatus))
        {
            throw new ServiceException("预约状态流转非法");
        }
    }
}
