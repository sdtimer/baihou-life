package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouCategory;
import com.ruoyi.baihou.domain.BaihouRegion;
import com.ruoyi.baihou.mapper.BaihouCategoryMapper;
import com.ruoyi.baihou.mapper.BaihouRegionMapper;
import com.ruoyi.baihou.service.impl.BaihouCategoryServiceImpl;
import com.ruoyi.baihou.service.impl.BaihouRegionServiceImpl;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;

class BaihouServiceImplTest
{
    @Test
    void categoryServiceShouldDelegateToMapper()
    {
        BaihouCategoryMapper categoryMapper = Mockito.mock(BaihouCategoryMapper.class);
        List<BaihouCategory> expected = List.of(new BaihouCategory(1L, "客厅"));
        Mockito.when(categoryMapper.selectCategoryList()).thenReturn(expected);

        BaihouCategoryServiceImpl service = new BaihouCategoryServiceImpl();
        ReflectionTestUtils.setField(service, "categoryMapper", categoryMapper);

        assertEquals(expected, service.selectCategoryList());
    }

    @Test
    void categoryInsertShouldDelegateToMapper()
    {
        BaihouCategoryMapper categoryMapper = Mockito.mock(BaihouCategoryMapper.class);
        BaihouCategory category = new BaihouCategory(10L, "卫浴");
        Mockito.when(categoryMapper.insertCategory(category)).thenReturn(1);

        BaihouCategoryServiceImpl service = new BaihouCategoryServiceImpl();
        ReflectionTestUtils.setField(service, "categoryMapper", categoryMapper);

        assertEquals(1, service.insertCategory(category));
    }

    @Test
    void categoryUpdateShouldDelegateToMapper()
    {
        BaihouCategoryMapper categoryMapper = Mockito.mock(BaihouCategoryMapper.class);
        BaihouCategory category = new BaihouCategory(1L, "主材馆");
        Mockito.when(categoryMapper.updateCategory(category)).thenReturn(1);

        BaihouCategoryServiceImpl service = new BaihouCategoryServiceImpl();
        ReflectionTestUtils.setField(service, "categoryMapper", categoryMapper);

        assertEquals(1, service.updateCategory(category));
    }

    @Test
    void categorySelectByIdShouldDelegateToMapper()
    {
        BaihouCategoryMapper categoryMapper = Mockito.mock(BaihouCategoryMapper.class);
        BaihouCategory expected = new BaihouCategory(1L, "主材");
        Mockito.when(categoryMapper.selectCategoryById(1L)).thenReturn(expected);

        BaihouCategoryServiceImpl service = new BaihouCategoryServiceImpl();
        ReflectionTestUtils.setField(service, "categoryMapper", categoryMapper);

        assertEquals(expected, service.selectCategoryById(1L));
    }

    @Test
    void categoryDisableShouldAlsoOffShelfProducts()
    {
        BaihouCategoryMapper categoryMapper = Mockito.mock(BaihouCategoryMapper.class);
        Mockito.when(categoryMapper.updateCategoryStatus(1L, 0)).thenReturn(1);

        BaihouCategoryServiceImpl service = new BaihouCategoryServiceImpl();
        ReflectionTestUtils.setField(service, "categoryMapper", categoryMapper);

        assertEquals(1, service.updateCategoryStatus(1L, 0));
        verify(categoryMapper).updateProductsOffShelfByCategoryId(1L);
    }

    @Test
    void regionServiceShouldDelegateToMapper()
    {
        BaihouRegionMapper regionMapper = Mockito.mock(BaihouRegionMapper.class);
        List<BaihouRegion> expected = List.of(new BaihouRegion("shanghai", "上海"));
        Mockito.when(regionMapper.selectRegionList()).thenReturn(expected);

        BaihouRegionServiceImpl service = new BaihouRegionServiceImpl();
        ReflectionTestUtils.setField(service, "regionMapper", regionMapper);

        assertEquals(expected, service.selectRegionList());
    }

    @Test
    void regionInsertShouldDelegateToMapper()
    {
        BaihouRegionMapper regionMapper = Mockito.mock(BaihouRegionMapper.class);
        BaihouRegion region = new BaihouRegion("hangzhou", "杭州");
        Mockito.when(regionMapper.insertRegion(region)).thenReturn(1);

        BaihouRegionServiceImpl service = new BaihouRegionServiceImpl();
        ReflectionTestUtils.setField(service, "regionMapper", regionMapper);

        assertEquals(1, service.insertRegion(region));
    }

    @Test
    void regionUpdateShouldDelegateToMapper()
    {
        BaihouRegionMapper regionMapper = Mockito.mock(BaihouRegionMapper.class);
        BaihouRegion region = new BaihouRegion("shanghai", "上海市");
        Mockito.when(regionMapper.updateRegion(region)).thenReturn(1);

        BaihouRegionServiceImpl service = new BaihouRegionServiceImpl();
        ReflectionTestUtils.setField(service, "regionMapper", regionMapper);

        assertEquals(1, service.updateRegion(region));
    }

    @Test
    void regionSelectByIdShouldDelegateToMapper()
    {
        BaihouRegionMapper regionMapper = Mockito.mock(BaihouRegionMapper.class);
        BaihouRegion expected = new BaihouRegion("shanghai", "上海");
        Mockito.when(regionMapper.selectRegionById("shanghai")).thenReturn(expected);

        BaihouRegionServiceImpl service = new BaihouRegionServiceImpl();
        ReflectionTestUtils.setField(service, "regionMapper", regionMapper);

        assertEquals(expected, service.selectRegionById("shanghai"));
    }

    @Test
    void regionStatusShouldDelegateToMapper()
    {
        BaihouRegionMapper regionMapper = Mockito.mock(BaihouRegionMapper.class);
        Mockito.when(regionMapper.updateRegionStatus("shanghai", 0)).thenReturn(1);

        BaihouRegionServiceImpl service = new BaihouRegionServiceImpl();
        ReflectionTestUtils.setField(service, "regionMapper", regionMapper);

        assertEquals(1, service.updateRegionStatus("shanghai", 0));
    }
}
