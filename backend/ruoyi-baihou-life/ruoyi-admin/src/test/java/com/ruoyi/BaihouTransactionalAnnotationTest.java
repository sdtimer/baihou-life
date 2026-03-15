package com.ruoyi;

import com.ruoyi.baihou.service.impl.*;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class BaihouTransactionalAnnotationTest {

    @Test
    void productServiceImplShouldBeTransactional() {
        Transactional ann = BaihouProductServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouProductServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouProductServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void bannerServiceImplShouldBeTransactional() {
        Transactional ann = BaihouBannerServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouBannerServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouBannerServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void categoryServiceImplShouldBeTransactional() {
        Transactional ann = BaihouCategoryServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouCategoryServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouCategoryServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void categorySpecDefServiceImplShouldBeTransactional() {
        Transactional ann = BaihouCategorySpecDefServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouCategorySpecDefServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouCategorySpecDefServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void regionServiceImplShouldBeTransactional() {
        Transactional ann = BaihouRegionServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouRegionServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouRegionServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void designerServiceImplShouldBeTransactional() {
        Transactional ann = BaihouDesignerServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouDesignerServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouDesignerServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void designerGroupServiceImplShouldBeTransactional() {
        Transactional ann = BaihouDesignerGroupServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouDesignerGroupServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouDesignerGroupServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void leadServiceImplShouldBeTransactional() {
        Transactional ann = BaihouLeadServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouLeadServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouLeadServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void appointmentServiceImplShouldBeTransactional() {
        Transactional ann = BaihouAppointmentServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouAppointmentServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouAppointmentServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void orderServiceImplShouldBeTransactional() {
        Transactional ann = BaihouOrderServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouOrderServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouOrderServiceImpl @Transactional must have rollbackFor = Exception.class");
    }

    @Test
    void wxUserServiceImplShouldBeTransactional() {
        Transactional ann = BaihouWxUserServiceImpl.class.getAnnotation(Transactional.class);
        assertNotNull(ann, "BaihouWxUserServiceImpl missing @Transactional");
        assertArrayEquals(new Class[]{Exception.class}, ann.rollbackFor(),
            "BaihouWxUserServiceImpl @Transactional must have rollbackFor = Exception.class");
    }
}
