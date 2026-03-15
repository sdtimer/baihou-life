package com.ruoyi;

import java.lang.reflect.Method;
import com.ruoyi.baihou.mapper.BaihouProductMapper;
import org.apache.ibatis.annotations.Param;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class BaihouProductMapperAnnotationTest
{
    @Test
    void updateProductStatusParametersShouldExposeMyBatisNames() throws NoSuchMethodException
    {
        Method method = BaihouProductMapper.class.getMethod("updateProductStatus", Long.class, String.class);
        Param idParam = (Param) method.getParameters()[0].getAnnotation(Param.class);
        Param statusParam = (Param) method.getParameters()[1].getAnnotation(Param.class);

        assertNotNull(idParam);
        assertNotNull(statusParam);
        assertEquals("id", idParam.value());
        assertEquals("status", statusParam.value());
    }

    @Test
    void batchUpdateProductStatusParametersShouldExposeMyBatisNames() throws NoSuchMethodException
    {
        Method method = BaihouProductMapper.class.getMethod("batchUpdateProductStatus", java.util.List.class, String.class);
        Param idsParam = (Param) method.getParameters()[0].getAnnotation(Param.class);
        Param statusParam = (Param) method.getParameters()[1].getAnnotation(Param.class);

        assertNotNull(idsParam);
        assertNotNull(statusParam);
        assertEquals("ids", idsParam.value());
        assertEquals("status", statusParam.value());
    }
}
