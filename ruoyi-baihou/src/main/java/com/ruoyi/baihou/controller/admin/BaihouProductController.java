package com.ruoyi.baihou.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.baihou.dto.BaihouProductBatchRequest;
import com.ruoyi.baihou.domain.BaihouProduct;
import com.ruoyi.baihou.service.IBaihouProductService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Baihou product admin controller.
 */
@RestController
@RequestMapping("/admin/products")
public class BaihouProductController extends BaseController
{
    @Autowired
    private IBaihouProductService productService;

    @PreAuthorize("@ss.hasPermi('baihou:product:list')")
    @GetMapping
    public AjaxResult list(BaihouProduct product)
    {
        return success(productService.selectProductList(product));
    }

    @PreAuthorize("@ss.hasPermi('baihou:product:query')")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(productService.selectProductById(id));
    }

    @PreAuthorize("@ss.hasPermi('baihou:product:add')")
    @Log(title = "商品管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BaihouProduct product)
    {
        return toAjax(productService.insertProduct(product));
    }

    @PreAuthorize("@ss.hasPermi('baihou:product:edit')")
    @Log(title = "商品管理", businessType = BusinessType.UPDATE)
    @PostMapping("/batch")
    public AjaxResult batch(@RequestBody BaihouProductBatchRequest request)
    {
        return toAjax(productService.batchUpdateProductStatus(request.getIds(), request.getAction()));
    }

    @PreAuthorize("@ss.hasPermi('baihou:product:edit')")
    @Log(title = "商品管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{id}")
    public AjaxResult edit(@PathVariable Long id, @RequestBody BaihouProduct product)
    {
        product.setId(id);
        return toAjax(productService.updateProduct(product));
    }

    @PreAuthorize("@ss.hasPermi('baihou:product:edit')")
    @Log(title = "商品管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{id}/status/{status}")
    public AjaxResult updateStatus(@PathVariable Long id, @PathVariable String status)
    {
        return toAjax(productService.updateProductStatus(id, status));
    }

    @PreAuthorize("@ss.hasPermi('baihou:product:remove')")
    @Log(title = "商品管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(productService.archiveProduct(id));
    }
}
