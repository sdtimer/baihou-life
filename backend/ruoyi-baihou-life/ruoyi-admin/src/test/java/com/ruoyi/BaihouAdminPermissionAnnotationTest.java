package com.ruoyi;

import java.lang.reflect.Method;
import com.ruoyi.baihou.controller.admin.BaihouAppointmentController;
import com.ruoyi.baihou.controller.admin.BaihouBannerController;
import com.ruoyi.baihou.controller.admin.BaihouCategoryController;
import com.ruoyi.baihou.controller.admin.BaihouDesignerController;
import com.ruoyi.baihou.controller.admin.BaihouDesignerGroupController;
import com.ruoyi.baihou.controller.admin.BaihouLeadController;
import com.ruoyi.baihou.controller.admin.BaihouOrderController;
import com.ruoyi.baihou.controller.admin.BaihouProductController;
import com.ruoyi.baihou.controller.admin.BaihouRegionController;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.domain.BaihouBanner;
import com.ruoyi.baihou.domain.BaihouCategory;
import com.ruoyi.baihou.domain.BaihouDesigner;
import com.ruoyi.baihou.domain.BaihouDesignerGroup;
import com.ruoyi.baihou.domain.BaihouLead;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.domain.BaihouRegion;
import com.ruoyi.baihou.dto.BaihouAppointmentUpdateRequest;
import com.ruoyi.baihou.dto.BaihouLeadUpdateRequest;
import com.ruoyi.baihou.dto.BaihouOrderUpdateRequest;
import com.ruoyi.baihou.dto.BaihouProductBatchRequest;
import javax.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.Test;
import org.springframework.security.access.prepost.PreAuthorize;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class BaihouAdminPermissionAnnotationTest
{
    @Test
    void categoryPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouCategoryController.class, "list", "@ss.hasPermi('baihou:category:list')");
        assertPermission(BaihouCategoryController.class, "getInfo", "@ss.hasPermi('baihou:category:list')", Long.class);
        assertPermission(BaihouCategoryController.class, "add", "@ss.hasPermi('baihou:category:add')", BaihouCategory.class);
        assertPermission(BaihouCategoryController.class, "edit", "@ss.hasPermi('baihou:category:edit')", BaihouCategory.class);
        assertPermission(BaihouCategoryController.class, "updateStatus", "@ss.hasPermi('baihou:category:edit')", Long.class, Integer.class);
    }

    @Test
    void regionPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouRegionController.class, "list", "@ss.hasPermi('baihou:region:list')");
        assertPermission(BaihouRegionController.class, "getInfo", "@ss.hasPermi('baihou:region:list')", String.class);
        assertPermission(BaihouRegionController.class, "add", "@ss.hasPermi('baihou:region:add')", BaihouRegion.class);
        assertPermission(BaihouRegionController.class, "edit", "@ss.hasPermi('baihou:region:edit')", BaihouRegion.class);
        assertPermission(BaihouRegionController.class, "updateStatus", "@ss.hasPermi('baihou:region:edit')", String.class, Integer.class);
    }

    @Test
    void productPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouProductController.class, "list", "@ss.hasPermi('baihou:product:list')", BaihouProduct.class);
        assertPermission(BaihouProductController.class, "getInfo", "@ss.hasPermi('baihou:product:query')", Long.class);
        assertPermission(BaihouProductController.class, "add", "@ss.hasPermi('baihou:product:add')", BaihouProduct.class);
        assertPermission(BaihouProductController.class, "batch", "@ss.hasPermi('baihou:product:edit')", BaihouProductBatchRequest.class);
        assertPermission(BaihouProductController.class, "edit", "@ss.hasPermi('baihou:product:edit')", Long.class, BaihouProduct.class);
        assertPermission(BaihouProductController.class, "updateStatus", "@ss.hasPermi('baihou:product:edit')", Long.class, String.class);
        assertPermission(BaihouProductController.class, "remove", "@ss.hasPermi('baihou:product:remove')", Long.class);
    }

    @Test
    void bannerPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouBannerController.class, "list", "@ss.hasPermi('baihou:banner:list')");
        assertPermission(BaihouBannerController.class, "add", "@ss.hasPermi('baihou:banner:add')", BaihouBanner.class);
        assertPermission(BaihouBannerController.class, "edit", "@ss.hasPermi('baihou:banner:edit')", Long.class, BaihouBanner.class);
        assertPermission(BaihouBannerController.class, "remove", "@ss.hasPermi('baihou:banner:remove')", Long.class);
    }

    @Test
    void designerPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouDesignerController.class, "list", "@ss.hasPermi('baihou:designer:list')");
        assertPermission(BaihouDesignerController.class, "add", "@ss.hasPermi('baihou:designer:add')", BaihouDesigner.class);
        assertPermission(BaihouDesignerController.class, "edit", "@ss.hasPermi('baihou:designer:edit')", Long.class, BaihouDesigner.class);
        assertPermission(BaihouDesignerController.class, "toggle", "@ss.hasPermi('baihou:designer:edit')", Long.class);
    }

    @Test
    void designerGroupPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouDesignerGroupController.class, "list", "@ss.hasPermi('baihou:designerGroup:list')");
        assertPermission(BaihouDesignerGroupController.class, "add", "@ss.hasPermi('baihou:designerGroup:add')", BaihouDesignerGroup.class);
        assertPermission(BaihouDesignerGroupController.class, "edit", "@ss.hasPermi('baihou:designerGroup:edit')", Long.class, BaihouDesignerGroup.class);
    }

    @Test
    void leadPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouLeadController.class, "list", "@ss.hasPermi('baihou:lead:list')", BaihouLead.class);
        assertPermission(BaihouLeadController.class, "update", "@ss.hasPermi('baihou:lead:edit')", Long.class, BaihouLeadUpdateRequest.class);
        assertPermission(BaihouLeadController.class, "export", "@ss.hasPermi('baihou:lead:export')", HttpServletResponse.class, BaihouLead.class);
    }

    @Test
    void appointmentPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouAppointmentController.class, "list", "@ss.hasPermi('baihou:appointment:list')", BaihouAppointment.class);
        assertPermission(BaihouAppointmentController.class, "update", "@ss.hasPermi('baihou:appointment:edit')", Long.class, BaihouAppointmentUpdateRequest.class);
    }

    @Test
    void orderPermissionsShouldMatchMenuContract() throws NoSuchMethodException
    {
        assertPermission(BaihouOrderController.class, "list", "@ss.hasPermi('baihou:order:list')", BaihouOrder.class);
        assertPermission(BaihouOrderController.class, "getInfo", "@ss.hasPermi('baihou:order:list')", Long.class);
        assertPermission(BaihouOrderController.class, "update", "@ss.hasPermi('baihou:order:edit')", Long.class, BaihouOrderUpdateRequest.class);
    }

    private void assertPermission(Class<?> controllerClass, String methodName, String expectedValue, Class<?>... parameterTypes)
            throws NoSuchMethodException
    {
        Method method = controllerClass.getMethod(methodName, parameterTypes);
        PreAuthorize annotation = method.getAnnotation(PreAuthorize.class);
        assertNotNull(annotation, controllerClass.getSimpleName() + "." + methodName + " should declare @PreAuthorize");
        assertEquals(expectedValue, annotation.value());
    }
}
