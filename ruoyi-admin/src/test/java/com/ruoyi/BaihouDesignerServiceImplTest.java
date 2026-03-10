package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouDesigner;
import com.ruoyi.baihou.mapper.BaihouDesignerMapper;
import com.ruoyi.baihou.mapper.BaihouWxUserMapper;
import com.ruoyi.baihou.service.impl.BaihouDesignerServiceImpl;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;

class BaihouDesignerServiceImplTest
{
    @Test
    void designerListShouldDelegateToMapper()
    {
        BaihouDesignerMapper designerMapper = Mockito.mock(BaihouDesignerMapper.class);
        BaihouWxUserMapper wxUserMapper = Mockito.mock(BaihouWxUserMapper.class);
        List<BaihouDesigner> expected = List.of(new BaihouDesigner(1L, "张三", "13900005678"));
        Mockito.when(designerMapper.selectDesignerList()).thenReturn(expected);

        BaihouDesignerServiceImpl service = new BaihouDesignerServiceImpl();
        ReflectionTestUtils.setField(service, "designerMapper", designerMapper);
        ReflectionTestUtils.setField(service, "wxUserMapper", wxUserMapper);

        assertEquals(expected, service.selectDesignerList());
    }

    @Test
    void insertDesignerShouldBindWxUserByPhoneHash()
    {
        BaihouDesignerMapper designerMapper = Mockito.mock(BaihouDesignerMapper.class);
        BaihouWxUserMapper wxUserMapper = Mockito.mock(BaihouWxUserMapper.class);
        Mockito.when(wxUserMapper.selectUserIdByPhoneHash("hash-13900005678")).thenReturn(1001L);
        Mockito.when(designerMapper.insertDesigner(Mockito.any(BaihouDesigner.class))).thenReturn(1);
        Mockito.when(wxUserMapper.updateUserRole(1001L, 2)).thenReturn(1);

        BaihouDesignerServiceImpl service = new BaihouDesignerServiceImpl();
        ReflectionTestUtils.setField(service, "designerMapper", designerMapper);
        ReflectionTestUtils.setField(service, "wxUserMapper", wxUserMapper);

        BaihouDesigner designer = new BaihouDesigner(1L, "张三", "13900005678");
        designer.setPhoneHash("hash-13900005678");
        assertEquals(1, service.insertDesigner(designer));
        assertEquals(Long.valueOf(1001L), designer.getUserId());
    }

    @Test
    void updateDesignerShouldDelegateToMapper()
    {
        BaihouDesignerMapper designerMapper = Mockito.mock(BaihouDesignerMapper.class);
        BaihouWxUserMapper wxUserMapper = Mockito.mock(BaihouWxUserMapper.class);
        Mockito.when(designerMapper.updateDesigner(Mockito.any(BaihouDesigner.class))).thenReturn(1);

        BaihouDesignerServiceImpl service = new BaihouDesignerServiceImpl();
        ReflectionTestUtils.setField(service, "designerMapper", designerMapper);
        ReflectionTestUtils.setField(service, "wxUserMapper", wxUserMapper);

        BaihouDesigner designer = new BaihouDesigner(1L, "张三更新", "13900005678");
        assertEquals(1, service.updateDesigner(designer));
    }

    @Test
    void toggleDesignerStatusShouldUpdateDesignerAndWxUserStatus()
    {
        BaihouDesignerMapper designerMapper = Mockito.mock(BaihouDesignerMapper.class);
        BaihouWxUserMapper wxUserMapper = Mockito.mock(BaihouWxUserMapper.class);
        BaihouDesigner designer = new BaihouDesigner(1L, "张三", "13900005678");
        designer.setUserId(1001L);
        designer.setStatus("active");
        Mockito.when(designerMapper.selectDesignerById(1L)).thenReturn(designer);
        Mockito.when(designerMapper.updateDesignerStatus(1L, "disabled")).thenReturn(1);
        Mockito.when(wxUserMapper.updateUserStatus(1001L, "disabled")).thenReturn(1);

        BaihouDesignerServiceImpl service = new BaihouDesignerServiceImpl();
        ReflectionTestUtils.setField(service, "designerMapper", designerMapper);
        ReflectionTestUtils.setField(service, "wxUserMapper", wxUserMapper);

        assertEquals(1, service.toggleDesignerStatus(1L));
    }
}
