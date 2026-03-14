package com.ruoyi;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouMedia;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.mapper.BaihouProductMapper;
import com.ruoyi.baihou.service.impl.BaihouProductServiceImpl;
import com.ruoyi.common.exception.ServiceException;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class BaihouProductServiceImplTest
{
    @Test
    void productListShouldDelegateToMapper()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        List<BaihouProduct> expected = List.of(new BaihouProduct(1001L, "测试商品", "BH-001", "draft"));
        Mockito.when(productMapper.selectProductList(Mockito.any(BaihouProduct.class))).thenReturn(expected);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertEquals(expected, service.selectProductList(new BaihouProduct()));
    }

    @Test
    void productInfoShouldDelegateToMapper()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouProduct expected = new BaihouProduct(1001L, "测试商品", "BH-001", "draft");
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(expected);
        Mockito.when(productMapper.selectProductMediaList(1001L)).thenReturn(List.of(
                new BaihouMedia(5001L, "scene", "https://cdn.example.com/scene.jpg"),
                new BaihouMedia(5002L, "element", "https://cdn.example.com/element.jpg"),
                new BaihouMedia(5003L, "spec", "https://cdn.example.com/spec.jpg"),
                new BaihouMedia(5004L, "source", null)));

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        BaihouProduct actual = service.selectProductById(1001L);
        assertEquals(expected, actual);
        assertEquals(1, actual.getSceneImages().size());
        assertEquals(1, actual.getElementImages().size());
        assertEquals(1, actual.getSpecImages().size());
        assertEquals(1, actual.getSourceFiles().size());
    }

    @Test
    void productStatusShouldDelegateToMapper()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouProduct product = new BaihouProduct(1001L, "测试商品", "BH-001", "draft");
        product.setCategoryId(4L);
        product.setRegions("[\"chengdu\"]");
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(product);
        Mockito.when(productMapper.countProductMedia(1001L)).thenReturn(1);
        Mockito.when(productMapper.updateProductStatus(1001L, "on_shelf")).thenReturn(1);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertEquals(1, service.updateProductStatus(1001L, "on_shelf"));
    }

    @Test
    void productInsertShouldSetDefaultStatusAndDelFlag()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        Mockito.when(productMapper.insertProduct(Mockito.any(BaihouProduct.class))).thenReturn(1);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        BaihouProduct product = new BaihouProduct();
        product.setName("测试商品");
        product.setSkuCode("BH-001");
        product.setCategoryId(4L);

        assertEquals(1, service.insertProduct(product));
        assertEquals("draft", product.getStatus());
        assertEquals("0", product.getDelFlag());
    }

    @Test
    void productUpdateShouldDelegateToMapper()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        Mockito.when(productMapper.updateProduct(Mockito.any(BaihouProduct.class))).thenReturn(1);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        BaihouProduct product = new BaihouProduct(1001L, "更新商品", "BH-001", "draft");
        assertEquals(1, service.updateProduct(product));
    }

    @Test
    void archivedProductShouldRejectStatusChange()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(new BaihouProduct(1001L, "测试商品", "BH-001", "archived"));

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertThrows(ServiceException.class, () -> service.updateProductStatus(1001L, "on_shelf"));
    }

    @Test
    void productArchiveShouldDelegateToMapper()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        Mockito.when(productMapper.archiveProduct(1001L)).thenReturn(1);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertEquals(1, service.archiveProduct(1001L));
    }

    @Test
    void productBatchOffShelfShouldDelegateToMapper()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        Mockito.when(productMapper.batchUpdateProductStatus(List.of(1001L, 1002L), "off_shelf")).thenReturn(2);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertEquals(2, service.batchUpdateProductStatus(List.of(1001L, 1002L), "off_shelf"));
    }

    @Test
    void productBatchArchiveShouldDelegateToArchiveMapper()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        Mockito.when(productMapper.batchArchiveProducts(List.of(1001L, 1002L))).thenReturn(2);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertEquals(2, service.batchUpdateProductStatus(List.of(1001L, 1002L), "archive"));
    }

    @Test
    void onShelfShouldRejectWhenRegionMissing()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouProduct product = new BaihouProduct(1001L, "测试商品", "BH-001", "draft");
        product.setCategoryId(4L);
        product.setRegions("[]");
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(product);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertThrows(ServiceException.class, () -> service.updateProductStatus(1001L, "on_shelf"));
    }

    @Test
    void onShelfShouldRejectWhenMediaMissing()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouProduct product = new BaihouProduct(1001L, "测试商品", "BH-001", "draft");
        product.setCategoryId(4L);
        product.setRegions("[\"chengdu\"]");
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(product);
        Mockito.when(productMapper.countProductMedia(1001L)).thenReturn(0);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertThrows(ServiceException.class, () -> service.updateProductStatus(1001L, "on_shelf"));
    }

    @Test
    void onShelfShouldPassWhenRequiredFieldsComplete()
    {
        BaihouProductMapper productMapper = Mockito.mock(BaihouProductMapper.class);
        BaihouProduct product = new BaihouProduct(1001L, "测试商品", "BH-001", "draft");
        product.setCategoryId(4L);
        product.setRegions("[\"chengdu\"]");
        Mockito.when(productMapper.selectProductById(1001L)).thenReturn(product);
        Mockito.when(productMapper.countProductMedia(1001L)).thenReturn(2);
        Mockito.when(productMapper.updateProductStatus(1001L, "on_shelf")).thenReturn(1);

        BaihouProductServiceImpl service = new BaihouProductServiceImpl();
        ReflectionTestUtils.setField(service, "productMapper", productMapper);

        assertEquals(1, service.updateProductStatus(1001L, "on_shelf"));
    }
}
