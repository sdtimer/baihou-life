package com.ruoyi.baihou.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import com.ruoyi.baihou.domain.BaihouMedia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.mapper.BaihouProductMapper;
import com.ruoyi.baihou.service.IBaihouProductService;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

/**
 * Baihou product service implementation.
 */
@Service
@Transactional(rollbackFor = Exception.class)
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
        int rows = productMapper.insertProduct(product);
        saveProductMedia(product);
        return rows;
    }

    @Override
    public int updateProduct(BaihouProduct product)
    {
        int rows = productMapper.updateProduct(product);
        saveProductMedia(product);
        return rows;
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
        if (productMapper.countProductDisplayMedia(product.getId()) <= 0)
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
        List<BaihouMedia> downloadImages = new ArrayList<>();
        for (BaihouMedia media : mediaList)
        {
            if ("download".equals(media.getAssetRole()))
            {
                downloadImages.add(media);
            }
            else if ("scene".equals(media.getType()))
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
        product.setDownloadImages(downloadImages);
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
            if ("display".equals(media.getAssetRole()) && "scene".equals(media.getType()))
            {
                sceneImages.add(media);
                if (Integer.valueOf(1).equals(media.getIsCover()))
                {
                    break;
                }
            }
        }
        product.setSceneImages(sceneImages);
    }

    private void saveProductMedia(BaihouProduct product)
    {
        if (product.getId() == null)
        {
            return;
        }
        List<BaihouMedia> mediaList = mergeMediaLists(product);
        productMapper.deleteProductMedia(product.getId());
        if (!mediaList.isEmpty())
        {
            productMapper.insertProductMediaBatch(product.getId(), mediaList);
        }
    }

    private List<BaihouMedia> mergeMediaLists(BaihouProduct product)
    {
        List<BaihouMedia> mediaList = new ArrayList<>();
        mediaList.addAll(normalizeMedia(product.getSceneImages(), "scene", "display", "public", true));
        mediaList.addAll(normalizeMedia(product.getElementImages(), "element", "display", "public", false));
        mediaList.addAll(normalizeMedia(product.getSpecImages(), "spec", "display", "public", false));
        mediaList.addAll(normalizeMedia(product.getSourceFiles(), "source", "display", "designer", false));
        mediaList.addAll(normalizeMedia(product.getDownloadImages(), "scene", "download", "designer", false));
        return mediaList;
    }

    private List<BaihouMedia> normalizeMedia(List<BaihouMedia> mediaList, String defaultType, String assetRole,
                                             String accessLevel, boolean supportsCover)
    {
        List<BaihouMedia> normalized = new ArrayList<>();
        if (mediaList == null || mediaList.isEmpty())
        {
            return normalized;
        }
        int sortOrder = 10;
        boolean hasCover = mediaList.stream().anyMatch(item -> Integer.valueOf(1).equals(item.getIsCover()));
        for (BaihouMedia media : mediaList)
        {
            if (media == null || (StringUtils.isEmpty(media.getUrl()) && StringUtils.isEmpty(media.getOriginalUrl())))
            {
                continue;
            }
            BaihouMedia target = new BaihouMedia();
            target.setType(StringUtils.isNotEmpty(media.getType()) ? media.getType() : defaultType);
            target.setUrl(media.getUrl());
            target.setThumbnailUrl(StringUtils.isNotEmpty(media.getThumbnailUrl()) ? media.getThumbnailUrl() : media.getUrl());
            target.setOriginalUrl(StringUtils.isNotEmpty(media.getOriginalUrl()) ? media.getOriginalUrl() : media.getUrl());
            target.setFileFormat(resolveFileFormat(media.getFileFormat(), media.getOriginalUrl(), media.getUrl(), media.getFileName()));
            target.setFileSize(media.getFileSize());
            target.setFileName(StringUtils.isNotEmpty(media.getFileName()) ? media.getFileName() : resolveFileName(media.getOriginalUrl(), media.getUrl()));
            target.setAccessLevel(StringUtils.isNotEmpty(media.getAccessLevel()) ? media.getAccessLevel() : accessLevel);
            target.setAssetRole(assetRole);
            target.setSortOrder(media.getSortOrder() != null ? media.getSortOrder() : sortOrder);
            target.setIsCover(supportsCover
                    ? (Integer.valueOf(1).equals(media.getIsCover()) || (!hasCover && normalized.isEmpty()) ? 1 : 0)
                    : 0);
            target.setWidth(media.getWidth());
            target.setHeight(media.getHeight());
            normalized.add(target);
            sortOrder += 10;
        }
        return normalized;
    }

    private String resolveFileName(String originalUrl, String url)
    {
        String target = StringUtils.isNotEmpty(originalUrl) ? originalUrl : url;
        if (StringUtils.isEmpty(target))
        {
            return "media-file";
        }
        String[] segments = target.split("/");
        return segments[segments.length - 1];
    }

    private String resolveFileFormat(String fileFormat, String originalUrl, String url, String fileName)
    {
        if (StringUtils.isNotEmpty(fileFormat))
        {
            return fileFormat;
        }
        return Arrays.asList(fileName, originalUrl, url).stream()
                .filter(StringUtils::isNotEmpty)
                .map(value -> {
                    int idx = value.lastIndexOf(".");
                    return idx > -1 && idx < value.length() - 1 ? value.substring(idx + 1).toLowerCase() : "";
                })
                .filter(StringUtils::isNotEmpty)
                .findFirst()
                .orElse("");
    }
}
