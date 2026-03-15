package com.ruoyi;

import com.ruoyi.baihou.domain.BaihouDesigner;
import com.ruoyi.baihou.domain.BaihouProduct;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class BaihouBeanValidationTest {

    private static final Validator validator =
        Validation.buildDefaultValidatorFactory().getValidator();

    @Test
    void productStatusShouldRejectArbitraryString() {
        BaihouProduct p = new BaihouProduct();
        p.setStatus("hacked");
        Set<ConstraintViolation<BaihouProduct>> violations = validator.validateProperty(p, "status");
        assertFalse(violations.isEmpty(), "arbitrary status should fail validation");
    }

    @Test
    void productStatusShouldAllowOnShelf() {
        BaihouProduct p = new BaihouProduct();
        p.setStatus("on_shelf");
        Set<ConstraintViolation<BaihouProduct>> violations = validator.validateProperty(p, "status");
        assertTrue(violations.isEmpty(), "on_shelf is valid status");
    }

    @Test
    void designerPhoneShouldRejectInvalidFormat() {
        BaihouDesigner d = new BaihouDesigner();
        d.setPhone("12345");
        Set<ConstraintViolation<BaihouDesigner>> violations = validator.validateProperty(d, "phone");
        assertFalse(violations.isEmpty(), "short phone should fail validation");
    }

    @Test
    void designerPhoneShouldAllowValidPhone() {
        BaihouDesigner d = new BaihouDesigner();
        d.setPhone("13800138000");
        Set<ConstraintViolation<BaihouDesigner>> violations = validator.validateProperty(d, "phone");
        assertTrue(violations.isEmpty(), "valid phone should pass");
    }

    @Test
    void designerPhoneShouldAllowNull() {
        BaihouDesigner d = new BaihouDesigner();
        d.setPhone(null);
        Set<ConstraintViolation<BaihouDesigner>> violations = validator.validateProperty(d, "phone");
        assertTrue(violations.isEmpty(), "null phone is allowed (optional field)");
    }
}
