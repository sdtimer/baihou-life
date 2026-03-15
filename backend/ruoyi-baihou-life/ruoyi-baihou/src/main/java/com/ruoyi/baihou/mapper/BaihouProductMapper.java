package com.ruoyi.baihou.mapper;

import java.util.List;
import com.ruoyi.baihou.domain.BaihouMedia;
import com.ruoyi.baihou.domain.BaihouProduct;
import org.apache.ibatis.annotations.Param;

/**
 * Baihou product mapper.
 */
public interface BaihouProductMapper
{
    List<BaihouProduct> selectProductList(BaihouProduct product);

    BaihouProduct selectProductById(Long id);

    int insertProduct(BaihouProduct product);

    int updateProduct(BaihouProduct product);

    int updateProductStatus(@Param("id") Long id, @Param("status") String status);

    int archiveProduct(Long id);

    int batchUpdateProductStatus(@Param("ids") List<Long> ids, @Param("status") String status);

    int batchArchiveProducts(List<Long> ids);

    int countProductMedia(Long productId);

    List<BaihouMedia> selectProductMediaList(Long productId);
}
