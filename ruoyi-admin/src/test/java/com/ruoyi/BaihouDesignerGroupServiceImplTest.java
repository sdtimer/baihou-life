package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouDesignerGroup;
import com.ruoyi.baihou.mapper.BaihouDesignerGroupMapper;
import com.ruoyi.baihou.service.impl.BaihouDesignerGroupServiceImpl;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;

class BaihouDesignerGroupServiceImplTest
{
    @Test
    void groupListShouldDelegateToMapper()
    {
        BaihouDesignerGroupMapper groupMapper = Mockito.mock(BaihouDesignerGroupMapper.class);
        List<BaihouDesignerGroup> expected = List.of(new BaihouDesignerGroup(1L, "核心设计师"));
        Mockito.when(groupMapper.selectGroupList()).thenReturn(expected);

        BaihouDesignerGroupServiceImpl service = new BaihouDesignerGroupServiceImpl();
        ReflectionTestUtils.setField(service, "designerGroupMapper", groupMapper);

        assertEquals(expected, service.selectGroupList());
    }

    @Test
    void groupInsertShouldDelegateToMapper()
    {
        BaihouDesignerGroupMapper groupMapper = Mockito.mock(BaihouDesignerGroupMapper.class);
        Mockito.when(groupMapper.insertGroup(Mockito.any(BaihouDesignerGroup.class))).thenReturn(1);

        BaihouDesignerGroupServiceImpl service = new BaihouDesignerGroupServiceImpl();
        ReflectionTestUtils.setField(service, "designerGroupMapper", groupMapper);

        assertEquals(1, service.insertGroup(new BaihouDesignerGroup()));
    }

    @Test
    void groupUpdateShouldDelegateToMapper()
    {
        BaihouDesignerGroupMapper groupMapper = Mockito.mock(BaihouDesignerGroupMapper.class);
        Mockito.when(groupMapper.updateGroup(Mockito.any(BaihouDesignerGroup.class))).thenReturn(1);

        BaihouDesignerGroupServiceImpl service = new BaihouDesignerGroupServiceImpl();
        ReflectionTestUtils.setField(service, "designerGroupMapper", groupMapper);

        BaihouDesignerGroup group = new BaihouDesignerGroup(1L, "核心设计师更新");
        assertEquals(1, service.updateGroup(group));
    }
}
