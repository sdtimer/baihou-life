package com.ruoyi.baihou.service;

import com.ruoyi.baihou.domain.BaihouWxUser;

/**
 * 小程序用户服务接口
 */
public interface IBaihouWxUserService
{
    /**
     * 根据 code（测试阶段当作 openid 使用）查找或创建用户
     */
    BaihouWxUser findOrCreateByCode(String code);
}
