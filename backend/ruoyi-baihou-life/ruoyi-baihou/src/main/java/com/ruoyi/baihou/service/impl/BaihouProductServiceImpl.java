package com.ruoyi.baihou.service.impl;

import java.util.ArrayList;
import java.util.List;
import com.ruoyi.baihou.domain.BaihouMedia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.mapper.BaihouProductMapper;
import com.ruoyi.baihou.service.IBaihouProductService;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

/**
 * Baihou product service implementation.
 */
@Service
public class BaihouProductServiceImpl implements IBaihouProductService
{
    @Autowired
    private BaihouProductMapper productMapper;

    @Override
    public List<BaihouProduct> selectProductList(BaihouProduct product)
    {
        return productMapper.selectProductList(product);
    }

    @Override
    public BaihouProduct selectProductById(Long id)
    {
        BaihouProduct product = productMapper.selectProductById(id);
        if (product != null)
        {
            bindProductMedia(product);
        }
        return product;
    }

    @Override
    public int insertProduct(BaihouProduct product)
    {
        if (StringUtils.isEmpty(product.getStatus()))
        {
            product.setStatus("draft");
        }
        if (StringUtils.isEmpty(product.getDelFlag()))
        {
            product.setDelFlag("0");
        }
        return productMapper.insertProduct(product);
    }

    @Override
    public int updateProduct(BaihouProduct product)
    {
        return productMapper.updateProduct(product);
    }

    @Override
    public int updateProductStatus(Long id, String status)
    {
        BaihouProduct current = productMapper.selectProductById(id);
        if (current != null && "archived".equals(current.getStatus()))
        {
            throw new ServiceException("已归档商品不可再变更状态");
        }
        if ("on_shelf".equals(status))
        {
            validateBeforeOnShelf(current);
        }
        return productMapper.updateProductStatus(id, status);
    }

    @Override
    public int archiveProduct(Long id)
    {
        return productMapper.archiveProduct(id);
    }

    @Override
    public int batchUpdateProductStatus(List<Long> ids, String action)
    {
        if ("archive".equals(action))
        {
            return productMapper.batchArchiveProducts(ids);
        }
        if ("on_shelf".equals(action))
        {
            for (Long id : ids)
            {
                validateBeforeOnShelf(productMapper.selectProductById(id));
            }
        }
        return productMapper.batchUpdateProductStatus(ids, action);
    }

    private void validateBeforeOnShelf(BaihouProduct product)
    {
        if (product == null)
        {
            throw new ServiceException("商品不存在");
        }
        if (StringUtils.isEmpty(product.getName()) || StringUtils.isEmpty(product.getSkuCode()) || product.getCategoryId() == null)
        {
            throw new ServiceException("商品基础信息不完整，不能上架");
        }
        if (StringUtils.isEmpty(product.getRegions()) || "[]".equals(product.getRegions()))
        {
            throw new ServiceException("商品缺少可售区域，不能上架");
        }
        if (productMapper.countProductMedia(product.getId()) <= 0)
        {
            throw new ServiceException("商品缺少图片资源，不能上架");
        }
    }

    private void bindProductMedia(BaihouProduct product)
    {
        List<BaihouMedia> mediaList = productMapper.selectProductMediaList(product.getId());
        List<BaihouMedia> sceneImages = new ArrayList<>();
        List<BaihouMedia> elementImages = new ArrayList<>();
        List<BaihouMedia> specImages = new ArrayList<>();
        List<BaihouMedia> sourceFiles = new ArrayList<>();
        for (BaihouMedia media : mediaList)
        {
            if ("scene".equals(media.getType()))
            {
                sceneImages.add(media);
            }
            else if ("element".equals(media.getType()))
            {
                elementImages.add(media);
            }
            else if ("spec".equals(media.getType()))
            {
                specImages.add(media);
            }
            else if ("source".equals(media.getType()))
            {
                sourceFiles.add(media);
            }
        }
        product.setSceneImages(sceneImages);
        product.setElementImages(elementImages);
        product.setSpecImages(specImages);
        product.setSourceFiles(sourceFiles);
    }

    /**
     * 为列表查询的产品绑定第一张 scene 封面图
     */
    @Override
    public void bindCoverImage(BaihouProduct product)
    {
        List<BaihouMedia> mediaList = productMapper.selectProductMediaList(product.getId());
        List<BaihouMedia> sceneImages = new ArrayList<>();
        for (BaihouMedia media : mediaList)
        {
            if ("scene".equals(media.getType()))
            {
                sceneImages.add(media);
                break;
            }
        }
        product.setSceneImages(sceneImages);
    }
}
