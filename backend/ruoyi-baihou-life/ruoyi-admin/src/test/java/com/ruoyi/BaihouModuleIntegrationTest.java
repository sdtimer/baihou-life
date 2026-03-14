package com.ruoyi;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

class BaihouModuleIntegrationTest
{
    @Test
    void baihouModuleMarkerShouldBeAvailableToAdmin()
    {
        assertDoesNotThrow(() -> Class.forName("com.ruoyi.baihou.BaihouModuleMarker"));
    }
}
