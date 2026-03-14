package com.ruoyi.baihou.service.impl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;
import com.ruoyi.baihou.dto.miniapp.MiniAppointmentCreateRequest;
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

    @Override
    public BaihouAppointment createMiniAppointment(Long uid, MiniAppointmentCreateRequest request)
    {
        validateMiniAppointment(request);

        String appointmentNo = "APT" + System.currentTimeMillis();
        BaihouAppointment appointment = new BaihouAppointment();
        appointment.setAppointmentNo(appointmentNo);
        appointment.setUserId(uid);
        appointment.setCustomerName(request.getCustomerName());
        appointment.setCustomerPhone(request.getCustomerPhone());
        appointment.setServiceType(request.getServiceType());
        appointment.setRemark(request.getRemark());
        appointment.setRegionId(request.getRegionId());
        appointment.setStatus("pending");

        if (request.getPreferredDate() != null && !request.getPreferredDate().isBlank())
        {
            try
            {
                Date preferred = new SimpleDateFormat("yyyy-MM-dd").parse(request.getPreferredDate());
                appointment.setPreferredDate(preferred);
            }
            catch (Exception ignored)
            {
            }
        }

        appointmentMapper.insertAppointment(appointment);
        return appointment;
    }

    @Override
    public List<BaihouAppointment> selectAppointmentListByUserId(Long userId)
    {
        return appointmentMapper.selectAppointmentListByUserId(userId);
    }

    @Override
    public BaihouAppointment selectAppointmentByUser(Long userId, Long appointmentId)
    {
        return appointmentMapper.selectAppointmentByUser(userId, appointmentId);
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

    private void validateMiniAppointment(MiniAppointmentCreateRequest request)
    {
        if (request.getCustomerName() == null || request.getCustomerName().isBlank())
        {
            throw new ServiceException("姓名不能为空");
        }
        if (request.getCustomerPhone() == null || !request.getCustomerPhone().matches("^1\\d{10}$"))
        {
            throw new ServiceException("手机号格式不正确");
        }
        if (request.getServiceType() == null
                || !Set.of("measure", "delivery", "install").contains(request.getServiceType()))
        {
            throw new ServiceException("服务类型不合法");
        }
        if (request.getPreferredDate() == null || request.getPreferredDate().isBlank())
        {
            throw new ServiceException("预约日期不能为空");
        }
        LocalDate preferredDate;
        try
        {
            preferredDate = LocalDate.parse(request.getPreferredDate());
        }
        catch (Exception e)
        {
            throw new ServiceException("预约日期格式不正确");
        }
        if (preferredDate.isBefore(LocalDate.now(ZoneId.systemDefault())))
        {
            throw new ServiceException("预约日期不能早于今天");
        }
        if (request.getRegionId() == null || request.getRegionId().isBlank())
        {
            throw new ServiceException("区域不能为空");
        }
    }
}
