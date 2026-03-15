package com.ruoyi;

import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.domain.BaihouLead;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

class BaihouPageSizeLimitTest {

    @Test
    void productPageSizeShouldBeCapAt100() {
        BaihouProduct product = new BaihouProduct();
        product.setPageSize(999999);
        assertEquals(100, product.getPageSize(), "pageSize should be capped at 100");
    }

    @Test
    void productPageSizeShouldKeepSmallValue() {
        BaihouProduct product = new BaihouProduct();
        product.setPageSize(20);
        assertEquals(20, product.getPageSize());
    }

    @Test
    void productPageSizeNullShouldStayNull() {
        BaihouProduct product = new BaihouProduct();
        product.setPageSize(null);
        assertNull(product.getPageSize());
    }

    @Test
    void leadPageSizeShouldBeCapAt100() {
        BaihouLead lead = new BaihouLead();
        lead.setPageSize(500);
        assertEquals(100, lead.getPageSize(), "pageSize should be capped at 100");
    }
}
