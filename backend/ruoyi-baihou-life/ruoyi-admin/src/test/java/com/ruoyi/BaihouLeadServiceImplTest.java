package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.dto.BaihouLeadUpdateRequest;
import com.ruoyi.baihou.mapper.BaihouLeadMapper;
import com.ruoyi.baihou.service.impl.BaihouLeadServiceImpl;
import com.ruoyi.common.exception.ServiceException;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class BaihouLeadServiceImplTest
{
    @Test
    void leadListShouldDelegateToMapper()
    {
        BaihouLeadMapper leadMapper = Mockito.mock(BaihouLeadMapper.class);
        BaihouLead lead = new BaihouLead(1L, "foshan", "new");
        lead.setPhone("13812341234");
        List<BaihouLead> expected = List.of(lead);
        Mockito.when(leadMapper.selectLeadList(Mockito.any(BaihouLead.class))).thenReturn(expected);

        BaihouLeadServiceImpl service = new BaihouLeadServiceImpl();
        ReflectionTestUtils.setField(service, "leadMapper", leadMapper);

        List<BaihouLead> result = service.selectLeadList(new BaihouLead());
        assertEquals(expected, result);
        assertEquals("138****1234", result.get(0).getPhone());
    }

    @Test
    void leadExportShouldDelegateToMapper()
    {
        BaihouLeadMapper leadMapper = Mockito.mock(BaihouLeadMapper.class);
        BaihouLead lead = new BaihouLead(1L, "foshan", "following");
        lead.setPhone("13912345678");
        List<BaihouLead> expected = List.of(lead);
        Mockito.when(leadMapper.selectLeadList(Mockito.any(BaihouLead.class))).thenReturn(expected);

        BaihouLeadServiceImpl service = new BaihouLeadServiceImpl();
        ReflectionTestUtils.setField(service, "leadMapper", leadMapper);

        List<BaihouLead> result = service.exportLeadList(new BaihouLead());
        assertEquals(expected, result);
        assertEquals("139****5678", result.get(0).getPhone());
    }

    @Test
    void updateLeadShouldAllowNewToFollowing()
    {
        BaihouLeadMapper leadMapper = Mockito.mock(BaihouLeadMapper.class);
        BaihouLead current = new BaihouLead(1L, "foshan", "new");
        Mockito.when(leadMapper.selectLeadById(1L)).thenReturn(current);
        Mockito.when(leadMapper.updateLead(Mockito.eq(1L), Mockito.any(BaihouLeadUpdateRequest.class))).thenReturn(1);

        BaihouLeadServiceImpl service = new BaihouLeadServiceImpl();
        ReflectionTestUtils.setField(service, "leadMapper", leadMapper);

        BaihouLeadUpdateRequest request = new BaihouLeadUpdateRequest();
        request.setStatus("following");
        request.setAssignedTo(2001L);
        assertEquals(1, service.updateLead(1L, request));
    }

    @Test
    void updateLeadShouldRejectConvertedChanges()
    {
        BaihouLeadMapper leadMapper = Mockito.mock(BaihouLeadMapper.class);
        BaihouLead current = new BaihouLead(1L, "foshan", "converted");
        Mockito.when(leadMapper.selectLeadById(1L)).thenReturn(current);

        BaihouLeadServiceImpl service = new BaihouLeadServiceImpl();
        ReflectionTestUtils.setField(service, "leadMapper", leadMapper);

        BaihouLeadUpdateRequest request = new BaihouLeadUpdateRequest();
        request.setStatus("abandoned");
        assertThrows(ServiceException.class, () -> service.updateLead(1L, request));
    }

    @Test
    void updateLeadShouldRejectInvalidTransition()
    {
        BaihouLeadMapper leadMapper = Mockito.mock(BaihouLeadMapper.class);
        BaihouLead current = new BaihouLead(1L, "foshan", "new");
        Mockito.when(leadMapper.selectLeadById(1L)).thenReturn(current);

        BaihouLeadServiceImpl service = new BaihouLeadServiceImpl();
        ReflectionTestUtils.setField(service, "leadMapper", leadMapper);

        BaihouLeadUpdateRequest request = new BaihouLeadUpdateRequest();
        request.setStatus("converted");
        assertThrows(ServiceException.class, () -> service.updateLead(1L, request));
    }
}
