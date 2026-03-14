package com.ruoyi.baihou.service;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouProduct;
import java.util.Collections;

/**
 * Baihou product service.
 */
public interface IBaihouProductService
{
    List<BaihouProduct> selectProductList(BaihouProduct product);

    BaihouProduct selectProductById(Long id);

    int insertProduct(BaihouProduct product);

    int updateProduct(BaihouProduct product);

    int updateProductStatus(Long id, String status);

    int archiveProduct(Long id);

    int batchUpdateProductStatus(List<Long> ids, String action);

    /** 为产品绑定第一张 scene 封面图（列表查询时使用） */
    void bindCoverImage(BaihouProduct product);
}
