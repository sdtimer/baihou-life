package com.ruoyi;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import com.ruoyi.baihou.controller.miniapp.BaihouMiniAuthController;
import com.ruoyi.baihou.controller.miniapp.BaihouMiniAppointmentController;
import com.ruoyi.baihou.controller.miniapp.BaihouMiniDesignerController;
import com.ruoyi.baihou.controller.miniapp.BaihouMiniOrderController;
import com.ruoyi.baihou.controller.miniapp.BaihouMiniPaymentController;
import com.ruoyi.baihou.controller.miniapp.BaihouMiniProductController;
import com.ruoyi.baihou.domain.BaihouAppointment;
import com.ruoyi.baihou.domain.BaihouMedia;
import com.ruoyi.baihou.domain.BaihouOrder;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.domain.BaihouWxUser;
import com.ruoyi.baihou.dto.miniapp.MiniOrderCreateRequest;
import com.ruoyi.baihou.service.IBaihouAppointmentService;
import com.ruoyi.baihou.service.IBaihouCategoryService;
import com.ruoyi.baihou.service.IBaihouOrderService;
import com.ruoyi.baihou.service.IBaihouProductService;
import com.ruoyi.baihou.service.IBaihouWxUserService;
import com.ruoyi.baihou.vo.miniapp.MiniAppointmentVO;
import com.ruoyi.baihou.vo.miniapp.MiniProductVO;
import com.ruoyi.common.context.BaihouMiniContext;
import com.ruoyi.common.context.BaihouMiniTokenService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

class BaihouMiniControllerTest
{
    @AfterEach
    void tearDown()
    {
        BaihouMiniContext.clear();
    }

    @Test
    void miniLoginShouldReturnExpiresInAndPhone()
    {
        IBaihouWxUserService wxUserService = Mockito.mock(IBaihouWxUserService.class);
        BaihouMiniTokenService tokenService = Mockito.mock(BaihouMiniTokenService.class);

        BaihouWxUser user = new BaihouWxUser();
        user.setUid(10001L);
        user.setRole(1);
        user.setOpenid("openid-test");
        user.setNickname("测试用户");
        user.setPhone("13800001111");
        user.setRegionId("foshan");
        Mockito.when(wxUserService.findOrCreateByCode("mock-code")).thenReturn(user);
        Mockito.when(tokenService.createToken(10001L, 1, "openid-test")).thenReturn("jwt-token");

        BaihouMiniAuthController controller = new BaihouMiniAuthController();
        ReflectionTestUtils.setField(controller, "wxUserService", wxUserService);
        ReflectionTestUtils.setField(controller, "miniTokenService", tokenService);

        @SuppressWarnings("unchecked")
        Map<String, Object> data = (Map<String, Object>) controller.login(request("mock-code")).get("data");
        @SuppressWarnings("unchecked")
        Map<String, Object> userInfo = (Map<String, Object>) data.get("user");

        assertEquals("jwt-token", data.get("token"));
        assertEquals(604800, data.get("expires_in"));
        assertEquals("13800001111", userInfo.get("phone"));
    }

    @Test
    void miniProductListShouldRequireRegionId()
    {
        BaihouMiniProductController controller = new BaihouMiniProductController();
        ReflectionTestUtils.setField(controller, "productService", Mockito.mock(IBaihouProductService.class));
        ReflectionTestUtils.setField(controller, "categoryService", Mockito.mock(IBaihouCategoryService.class));

        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/v2/product/list");
        assertEquals(400, controller.list(request, null, null, null, null, null, null, null, null).get("code"));
    }

    @Test
    void miniProductListShouldHidePricesForGuest()
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        BaihouProduct product = new BaihouProduct(1001L, "测试商品", "BH-001", "on_shelf");
        product.setGuidePrice(new BigDecimal("1280.00"));
        product.setDesignerDiscount(new BigDecimal("0.85"));
        product.setSceneImages(List.of(new BaihouMedia(1L, "scene", "/upload/test-cover.jpg")));
        Mockito.when(productService.selectProductList(Mockito.any(BaihouProduct.class))).thenReturn(List.of(product));

        BaihouMiniProductController controller = new BaihouMiniProductController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        ReflectionTestUtils.setField(controller, "categoryService", Mockito.mock(IBaihouCategoryService.class));

        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/v2/product/list");
        request.setScheme("http");
        request.setServerName("localhost");
        request.setServerPort(8080);

        @SuppressWarnings("unchecked")
        List<MiniProductVO> rows = (List<MiniProductVO>) controller.list(
                request, null, null, null, null, null, null, null, "foshan").get("rows");

        assertNull(rows.get(0).getGuidePrice());
        assertNull(rows.get(0).getDesignerPrice());
    }

    @Test
    void miniDesignerAssetTokenShouldReturnUrl()
    {
        IBaihouProductService productService = Mockito.mock(IBaihouProductService.class);
        BaihouMedia media = new BaihouMedia(5001L, "scene", "/profile/products/demo_hd.jpg");
        media.setAccessLevel("designer");
        media.setAssetRole("download");
        media.setOriginalUrl("/profile/products/demo_hd.jpg");
        BaihouProduct product = new BaihouProduct(1001L, "测试商品", "BH-001", "on_shelf");
        product.setDownloadImages(List.of(media));
        Mockito.when(productService.selectProductById(1001L)).thenReturn(product);

        BaihouMiniContext.set(10001L, 2, "openid");

        BaihouMiniDesignerController controller = new BaihouMiniDesignerController();
        ReflectionTestUtils.setField(controller, "productService", productService);
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/v1/designer/asset-token");
        request.setScheme("http");
        request.setServerName("localhost");
        request.setServerPort(8080);
        @SuppressWarnings("unchecked")
        Map<String, Object> data = (Map<String, Object>) controller.assetToken(request, 1001L, 5001L).get("data");

        assertNotNull(data.get("url"));
        assertEquals(300, data.get("expires_in"));
    }

    @Test
    void miniOrderPrepayShouldValidateOwnerAndPendingPayStatus()
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        BaihouOrder order = new BaihouOrder(2001L, "ORD202603140001", "pending_pay");
        order.setUserId(10001L);
        @SuppressWarnings("unchecked")
        Map<String, Object> payment = Map.of("mode", "mock");
        @SuppressWarnings("unchecked")
        Map<String, Object> prepay = Map.of(
                "order_id", 2001L,
                "order_no", "ORD202603140001",
                "payment", payment);
        Mockito.when(orderService.selectOrderById(2001L)).thenReturn(order);
        Mockito.when(orderService.buildMiniPrepay(10001L, 2001L)).thenReturn(prepay);

        BaihouMiniOrderController controller = new BaihouMiniOrderController();
        ReflectionTestUtils.setField(controller, "orderService", orderService);

        BaihouMiniContext.set(10001L, 1, "openid");
        @SuppressWarnings("unchecked")
        Map<String, Object> data = (Map<String, Object>) controller.prepay(2001L).get("data");

        assertEquals("ORD202603140001", data.get("order_no"));
        assertNotNull(data.get("payment"));
    }

    @Test
    void miniAppointmentDetailShouldRequireOwner()
    {
        IBaihouAppointmentService appointmentService = Mockito.mock(IBaihouAppointmentService.class);
        BaihouAppointment appointment = new BaihouAppointment(3001L, "APT202603140001", "pending");
        appointment.setUserId(10001L);
        Mockito.when(appointmentService.selectAppointmentByUser(10001L, 3001L)).thenReturn(appointment);

        BaihouMiniAppointmentController controller = new BaihouMiniAppointmentController();
        ReflectionTestUtils.setField(controller, "appointmentService", appointmentService);

        BaihouMiniContext.set(10001L, 1, "openid");
        MiniAppointmentVO data = (MiniAppointmentVO) controller.detail(3001L).get("data");

        assertEquals("APT202603140001", data.getAppointmentNo());
    }

    @Test
    void miniOrderDetailShouldReturn403WhenOrderBelongsToOtherUser()
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        BaihouOrder order = new BaihouOrder(2001L, "ORD202603140001", "paid");
        order.setUserId(20002L);
        Mockito.when(orderService.selectOrderById(2001L)).thenReturn(order);

        BaihouMiniOrderController controller = new BaihouMiniOrderController();
        ReflectionTestUtils.setField(controller, "orderService", orderService);

        BaihouMiniContext.set(10001L, 1, "openid");
        assertEquals(403, controller.detail(2001L).get("code"));
    }

    @Test
    void miniOrderDetailShouldReturn404WhenOrderDoesNotExist()
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        Mockito.when(orderService.selectOrderById(2001L)).thenReturn(null);

        BaihouMiniOrderController controller = new BaihouMiniOrderController();
        ReflectionTestUtils.setField(controller, "orderService", orderService);

        BaihouMiniContext.set(10001L, 1, "openid");
        assertEquals(404, controller.detail(2001L).get("code"));
    }

    @Test
    void miniPaymentControllerShouldDelegateToOrderService()
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        BaihouOrder order = new BaihouOrder(2001L, "ORD202603140001", "pending_pay");
        order.setUserId(10001L);
        @SuppressWarnings("unchecked")
        Map<String, Object> payment = Map.of("mode", "mock");
        @SuppressWarnings("unchecked")
        Map<String, Object> prepay = Map.of(
                "order_id", 2001L,
                "order_no", "ORD202603140001",
                "payment", payment);
        Mockito.when(orderService.selectOrderById(2001L)).thenReturn(order);
        Mockito.when(orderService.buildMiniPrepay(10001L, 2001L)).thenReturn(prepay);
        Mockito.when(orderService.markMiniOrderPaid(10001L, 2001L)).thenReturn(1);

        BaihouMiniPaymentController controller = new BaihouMiniPaymentController();
        ReflectionTestUtils.setField(controller, "orderService", orderService);

        BaihouMiniContext.set(10001L, 1, "openid");
        @SuppressWarnings("unchecked")
        Map<String, Object> data = (Map<String, Object>) controller.prepay(Map.of("order_id", 2001L)).get("data");

        assertEquals("ORD202603140001", data.get("order_no"));
        assertEquals(200, controller.paySuccess(Map.of("order_id", 2001L)).get("code"));
    }

    @Test
    void miniPaymentControllerShouldReturn403WhenOrderBelongsToOtherUser()
    {
        IBaihouOrderService orderService = Mockito.mock(IBaihouOrderService.class);
        BaihouOrder order = new BaihouOrder(2001L, "ORD202603140001", "pending_pay");
        order.setUserId(20002L);
        Mockito.when(orderService.selectOrderById(2001L)).thenReturn(order);

        BaihouMiniPaymentController controller = new BaihouMiniPaymentController();
        ReflectionTestUtils.setField(controller, "orderService", orderService);

        BaihouMiniContext.set(10001L, 1, "openid");
        assertEquals(403, controller.prepay(Map.of("order_id", 2001L)).get("code"));
    }

    private com.ruoyi.baihou.dto.miniapp.MiniLoginRequest request(String code)
    {
        com.ruoyi.baihou.dto.miniapp.MiniLoginRequest request = new com.ruoyi.baihou.dto.miniapp.MiniLoginRequest();
        request.setCode(code);
        return request;
    }
}
