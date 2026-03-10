package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;
import com.ruoyi.baihou.mapper.BaihouAppointmentMapper;
import com.ruoyi.baihou.service.impl.BaihouAppointmentServiceImpl;
import com.ruoyi.common.exception.ServiceException;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class BaihouAppointmentServiceImplTest
{
    @Test
    void appointmentListShouldDelegateToMapper()
    {
        BaihouAppointmentMapper appointmentMapper = Mockito.mock(BaihouAppointmentMapper.class);
        List<BaihouAppointment> expected = List.of(new BaihouAppointment(1L, "APT202603100001", "pending"));
        Mockito.when(appointmentMapper.selectAppointmentList(Mockito.any(BaihouAppointment.class))).thenReturn(expected);

        BaihouAppointmentServiceImpl service = new BaihouAppointmentServiceImpl();
        ReflectionTestUtils.setField(service, "appointmentMapper", appointmentMapper);

        assertEquals(expected, service.selectAppointmentList(new BaihouAppointment()));
    }

    @Test
    void updateAppointmentShouldAllowPendingToConfirmed()
    {
        BaihouAppointmentMapper appointmentMapper = Mockito.mock(BaihouAppointmentMapper.class);
        BaihouAppointment current = new BaihouAppointment(1L, "APT202603100001", "pending");
        Mockito.when(appointmentMapper.selectAppointmentById(1L)).thenReturn(current);
        Mockito.when(appointmentMapper.updateAppointment(Mockito.eq(1L), Mockito.any(BaihouAppointmentUpdateRequest.class))).thenReturn(1);

        BaihouAppointmentServiceImpl service = new BaihouAppointmentServiceImpl();
        ReflectionTestUtils.setField(service, "appointmentMapper", appointmentMapper);

        BaihouAppointmentUpdateRequest request = new BaihouAppointmentUpdateRequest();
        request.setStatus("confirmed");
        request.setAssignedTo(3001L);
        assertEquals(1, service.updateAppointment(1L, request));
    }

    @Test
    void updateAppointmentShouldAllowConfirmedToCancelled()
    {
        BaihouAppointmentMapper appointmentMapper = Mockito.mock(BaihouAppointmentMapper.class);
        BaihouAppointment current = new BaihouAppointment(1L, "APT202603100001", "confirmed");
        Mockito.when(appointmentMapper.selectAppointmentById(1L)).thenReturn(current);
        Mockito.when(appointmentMapper.updateAppointment(Mockito.eq(1L), Mockito.any(BaihouAppointmentUpdateRequest.class))).thenReturn(1);

        BaihouAppointmentServiceImpl service = new BaihouAppointmentServiceImpl();
        ReflectionTestUtils.setField(service, "appointmentMapper", appointmentMapper);

        BaihouAppointmentUpdateRequest request = new BaihouAppointmentUpdateRequest();
        request.setStatus("cancelled");
        assertEquals(1, service.updateAppointment(1L, request));
    }

    @Test
    void updateAppointmentShouldRejectInProgressCancellation()
    {
        BaihouAppointmentMapper appointmentMapper = Mockito.mock(BaihouAppointmentMapper.class);
        BaihouAppointment current = new BaihouAppointment(1L, "APT202603100001", "in_progress");
        Mockito.when(appointmentMapper.selectAppointmentById(1L)).thenReturn(current);

        BaihouAppointmentServiceImpl service = new BaihouAppointmentServiceImpl();
        ReflectionTestUtils.setField(service, "appointmentMapper", appointmentMapper);

        BaihouAppointmentUpdateRequest request = new BaihouAppointmentUpdateRequest();
        request.setStatus("cancelled");
        assertThrows(ServiceException.class, () -> service.updateAppointment(1L, request));
    }

    @Test
    void updateAppointmentShouldRejectCompletedChanges()
    {
        BaihouAppointmentMapper appointmentMapper = Mockito.mock(BaihouAppointmentMapper.class);
        BaihouAppointment current = new BaihouAppointment(1L, "APT202603100001", "completed");
        Mockito.when(appointmentMapper.selectAppointmentById(1L)).thenReturn(current);

        BaihouAppointmentServiceImpl service = new BaihouAppointmentServiceImpl();
        ReflectionTestUtils.setField(service, "appointmentMapper", appointmentMapper);

        BaihouAppointmentUpdateRequest request = new BaihouAppointmentUpdateRequest();
        request.setStatus("cancelled");
        assertThrows(ServiceException.class, () -> service.updateAppointment(1L, request));
    }
}
