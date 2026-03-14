package com.ruoyi;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

class BaihouModuleStructureTest
{
    @Test
    void categoryAndRegionSkeletonShouldExist()
    {
        assertAll(
                () -> assertDoesNotThrow(() -> Class.forName("com.ruoyi.baihou.controller.admin.BaihouCategoryController")),
                () -> assertDoesNotThrow(() -> Class.forName("com.ruoyi.baihou.controller.admin.BaihouRegionController")),
                () -> assertDoesNotThrow(() -> Class.forName("com.ruoyi.baihou.service.IBaihouCategoryService")),
                () -> assertDoesNotThrow(() -> Class.forName("com.ruoyi.baihou.service.IBaihouRegionService")),
                () -> assertDoesNotThrow(() -> Class.forName("com.ruoyi.baihou.mapper.BaihouCategoryMapper")),
                () -> assertDoesNotThrow(() -> Class.forName("com.ruoyi.baihou.mapper.BaihouRegionMapper"))
        );
    }
}
