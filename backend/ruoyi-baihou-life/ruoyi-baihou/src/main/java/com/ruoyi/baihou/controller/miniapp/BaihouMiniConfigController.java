package com.ruoyi.baihou.controller.miniapp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.baihou.domain.BaihouRegion;
import com.ruoyi.baihou.service.IBaihouRegionService;
import com.ruoyi.baihou.vo.miniapp.MiniRegionVO;
import com.ruoyi.common.core.domain.AjaxResult;

/**
 * 小程序配置接口（GET /v1/config/regions）
 */
@RestController
@RequestMapping("/v1/config")
public class BaihouMiniConfigController
{
    @Autowired
    private IBaihouRegionService regionService;

    /**
     * 获取启用的区域列表
     * 返回: { data: { regions: [...] } }
     */
    @GetMapping("/regions")
    public AjaxResult regions()
    {
        List<BaihouRegion> all = regionService.selectRegionList();
        List<MiniRegionVO> vos = all.stream()
                .filter(r -> Integer.valueOf(1).equals(r.getIsActive()))
                .map(MiniRegionVO::from)
                .collect(Collectors.toList());
        Map<String, Object> data = new HashMap<>();
        data.put("regions", vos);
        return AjaxResult.success(data);
    }
}
