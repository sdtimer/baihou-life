package com.ruoyi;

import com.ruoyi.baihou.service.impl.*;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.assertNotNull;

class BaihouTransactionalAnnotationTest {

    @Test
    void productServiceImplShouldBeTransactional() {
        assertNotNull(BaihouProductServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouProductServiceImpl missing @Transactional");
    }

    @Test
    void bannerServiceImplShouldBeTransactional() {
        assertNotNull(BaihouBannerServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouBannerServiceImpl missing @Transactional");
    }

    @Test
    void categoryServiceImplShouldBeTransactional() {
        assertNotNull(BaihouCategoryServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouCategoryServiceImpl missing @Transactional");
    }

    @Test
    void categorySpecDefServiceImplShouldBeTransactional() {
        assertNotNull(BaihouCategorySpecDefServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouCategorySpecDefServiceImpl missing @Transactional");
    }

    @Test
    void regionServiceImplShouldBeTransactional() {
        assertNotNull(BaihouRegionServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouRegionServiceImpl missing @Transactional");
    }

    @Test
    void designerServiceImplShouldBeTransactional() {
        assertNotNull(BaihouDesignerServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouDesignerServiceImpl missing @Transactional");
    }

    @Test
    void designerGroupServiceImplShouldBeTransactional() {
        assertNotNull(BaihouDesignerGroupServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouDesignerGroupServiceImpl missing @Transactional");
    }

    @Test
    void leadServiceImplShouldBeTransactional() {
        assertNotNull(BaihouLeadServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouLeadServiceImpl missing @Transactional");
    }

    @Test
    void appointmentServiceImplShouldBeTransactional() {
        assertNotNull(BaihouAppointmentServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouAppointmentServiceImpl missing @Transactional");
    }

    @Test
    void orderServiceImplShouldBeTransactional() {
        assertNotNull(BaihouOrderServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouOrderServiceImpl missing @Transactional");
    }

    @Test
    void wxUserServiceImplShouldBeTransactional() {
        assertNotNull(BaihouWxUserServiceImpl.class.getAnnotation(Transactional.class),
            "BaihouWxUserServiceImpl missing @Transactional");
    }
}
