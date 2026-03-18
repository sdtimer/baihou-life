package com.ruoyi.baihou.controller.miniapp;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.baihou.domain.BaihouCategory;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.service.IBaihouCategoryService;
import com.ruoyi.baihou.service.IBaihouProductService;
import com.ruoyi.baihou.vo.miniapp.MiniProductVO;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.context.BaihouMiniContext;
import com.ruoyi.common.exception.ServiceException;

/**
 * 小程序商品接口
 * GET /v1/product/categories
 * GET /v1/feed/list
 * GET /v2/product/list
 * GET /v2/product/{id}
 */
@RestController
public class BaihouMiniProductController
{
    @Autowired
    private IBaihouProductService productService;

    @Autowired
    private IBaihouCategoryService categoryService;

    /**
     * 获取分类/空间/场景筛选数据
     * 返回: { data: { categories: [{category_id, category_name, children:[...]}], spaces:[...], scenes:[...] } }
     */
    @GetMapping("/v1/product/categories")
    public AjaxResult categories()
    {
        List<BaihouCategory> all = categoryService.selectCategoryList();
        List<BaihouCategory> active = all.stream()
                .filter(c -> Integer.valueOf(1).equals(c.getIsActive()))
                .collect(Collectors.toList());

        // 构建两层分类树
        List<Map<String, Object>> categoryTree = active.stream()
                .filter(c -> c.getParentId() == null || c.getParentId() == 0L)
                .map(parent -> {
                    List<Map<String, Object>> children = active.stream()
                            .filter(c -> parent.getCategoryId().equals(c.getParentId()))
                            .map(child -> {
                                Map<String, Object> m = new HashMap<>();
                                m.put("category_id", child.getCategoryId());
                                m.put("category_name", child.getCategoryName());
                                return m;
                            })
                            .collect(Collectors.toList());
                    Map<String, Object> m = new HashMap<>();
                    m.put("category_id", parent.getCategoryId());
                    m.put("category_name", parent.getCategoryName());
                    m.put("children", children);
                    return m;
                })
                .collect(Collectors.toList());

        // 静态空间/场景标签（与小程序 mock 数据一致）
        List<Map<String, Object>> spaces = Arrays.asList(
                label("客厅", "living_room"),
                label("厨房", "kitchen"),
                label("卫浴", "bathroom"),
                label("卧室", "bedroom")
        );
        List<Map<String, Object>> scenes = Arrays.asList(
                label("极简", "minimalist"),
                label("治愈", "healing"),
                label("侘寂", "wabi_sabi")
        );

        Map<String, Object> data = new HashMap<>();
        data.put("categories", categoryTree);
        data.put("spaces", spaces);
        data.put("scenes", scenes);
        return AjaxResult.success(data);
    }

    private Map<String, Object> label(String labelText, String value)
    {
        Map<String, Object> m = new HashMap<>();
        m.put("label", labelText);
        m.put("value", value);
        return m;
    }

    /**
     * 首页商品 feed
     */
    @GetMapping("/v1/feed/list")
    public AjaxResult feed(
            HttpServletRequest request,
            @RequestParam(name = "region_id", required = false) String regionId,
            @RequestParam(name = "pageNum", required = false) Integer pageNum,
            @RequestParam(name = "pageSize", required = false) Integer pageSize)
    {
        if (regionId == null || regionId.isBlank())
        {
            return AjaxResult.error(400, "region_id 不能为空");
        }

        BaihouProduct query = new BaihouProduct();
        query.setStatus("on_shelf");
        query.setRegionId(regionId);
        query.setSortBy("default");
        query.setPageNum(pageNum);
        query.setPageSize(pageSize);

        Integer role = BaihouMiniContext.getRole();
        String serverBaseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        List<Map<String, Object>> rows = productService.selectProductList(query).stream()
                .map(product -> {
                    BaihouProduct detail = productService.selectProductById(product.getId());
                    BaihouProduct target = detail != null ? detail : product;
                    MiniProductVO vo = MiniProductVO.from(target, role, serverBaseUrl);
                    Map<String, Object> item = new HashMap<>();
                    item.put("type", "product");
                    item.put("id", vo.getId());
                    item.put("title", vo.getName());
                    item.put("cover_image", vo.getCoverImage());
                    item.put("subtitle", vo.getBrand());
                    item.put("tags", buildFeedTags(target));
                    item.put("price", buildFeedPrice(vo, role));
                    item.put("action", "/pages/product/detail/index?id=" + vo.getId());
                    return item;
                })
                .filter(item -> item.get("cover_image") != null && !String.valueOf(item.get("cover_image")).isBlank())
                .collect(Collectors.toList());

        AjaxResult result = AjaxResult.success();
        result.put("rows", rows);
        result.put("total", rows.size());
        return result;
    }

    /**
     * 商品列表（支持 keyword/category_id/space/scene/region_id 筛选）
     */
    @GetMapping("/v2/product/list")
    public AjaxResult list(
            HttpServletRequest request,
            @RequestParam(required = false) String keyword,
            @RequestParam(name = "category_id", required = false) Long categoryId,
            @RequestParam(name = "space", required = false) String space,
            @RequestParam(name = "scene", required = false) String scene,
            @RequestParam(name = "sort_by", required = false) String sortBy,
            @RequestParam(name = "pageNum", required = false) Integer pageNum,
            @RequestParam(name = "pageSize", required = false) Integer pageSize,
            @RequestParam(name = "region_id", required = false) String regionId)
    {
        if (regionId == null || regionId.isBlank())
        {
            return AjaxResult.error(400, "region_id 不能为空");
        }
        BaihouProduct query = new BaihouProduct();
        query.setStatus("on_shelf");
        query.setKeyword(keyword);
        query.setCategoryId(categoryId);
        query.setSpaceTags(space);
        query.setSceneTags(scene);
        query.setRegionId(regionId);
        query.setSortBy(sortBy);
        query.setPageNum(pageNum);
        query.setPageSize(pageSize);

        List<BaihouProduct> products = productService.selectProductList(query);
        Integer role = BaihouMiniContext.getRole();
        String serverBaseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();

        List<MiniProductVO> rows = products.stream()
                .map(p -> {
                    BaihouProduct detail = productService.selectProductById(p.getId());
                    BaihouProduct target = detail != null ? detail : p;
                    return MiniProductVO.from(target, role, serverBaseUrl);
                })
                .collect(Collectors.toList());

        AjaxResult result = AjaxResult.success();
        result.put("rows", rows);
        result.put("total", rows.size());
        return result;
    }

    /**
     * 商品详情
     */
    @GetMapping("/v2/product/{id}")
    public AjaxResult detail(HttpServletRequest request,
                             @PathVariable Long id,
                             @RequestParam(name = "region_id", required = false) String regionId)
    {
        BaihouProduct product = productService.selectProductById(id);
        if (product == null || !"on_shelf".equals(product.getStatus()))
        {
            return AjaxResult.error("商品不存在或已下架");
        }
        if (regionId == null || regionId.isBlank())
        {
            return AjaxResult.error(400, "region_id 不能为空");
        }
        if (!regionMatches(product.getRegions(), regionId))
        {
            return AjaxResult.error(422, "当前区域不可售");
        }
        Integer role = BaihouMiniContext.getRole();
        String serverBaseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        try
        {
            return AjaxResult.success(MiniProductVO.from(product, role, serverBaseUrl));
        }
        catch (ServiceException e)
        {
            return AjaxResult.error(422, e.getMessage());
        }
    }

    private boolean regionMatches(String regions, String regionId)
    {
        if (regions == null || regions.isBlank())
        {
            return false;
        }
        return regions.contains("\"ALL\"") || regions.contains("\"" + regionId + "\"");
    }

    private List<String> buildFeedTags(BaihouProduct product)
    {
        String source = product.getSceneTags();
        if (source == null || source.isBlank())
        {
            source = product.getSpaceTags();
        }
        if (source == null || source.isBlank())
        {
            return List.of();
        }
        String normalized = source.trim();
        if (normalized.startsWith("[") && normalized.endsWith("]"))
        {
            normalized = normalized.substring(1, normalized.length() - 1);
        }

        List<String> tags = new ArrayList<>();
        for (String value : normalized.split(","))
        {
            String cleaned = value.trim().replace("\"", "");
            if (!cleaned.isEmpty())
            {
                tags.add(cleaned);
            }
            if (tags.size() >= 3)
            {
                break;
            }
        }
        return tags;
    }

    private Map<String, Object> buildFeedPrice(MiniProductVO product, Integer role)
    {
        Map<String, Object> price = new HashMap<>();
        if (role == null || Integer.valueOf(0).equals(role))
        {
            price.put("visible", false);
            return price;
        }
        price.put("visible", true);
        price.put("label", Integer.valueOf(2).equals(role) ? "设计师价" : "指导价");
        price.put("amount", Integer.valueOf(2).equals(role) ? product.getDesignerPrice() : product.getGuidePrice());
        price.put("unit", product.getPriceUnit());
        return price;
    }
}
