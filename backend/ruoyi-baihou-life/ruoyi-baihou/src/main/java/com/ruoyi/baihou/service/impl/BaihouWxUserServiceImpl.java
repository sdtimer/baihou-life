package com.ruoyi.baihou.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.baihou.domain.BaihouWxUser;
import com.ruoyi.baihou.mapper.BaihouWxUserMapper;
import com.ruoyi.baihou.service.IBaihouWxUserService;

/**
 * 小程序用户服务实现（测试阶段：code 直接用作 openid）
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BaihouWxUserServiceImpl implements IBaihouWxUserService
{
    @Autowired
    private BaihouWxUserMapper wxUserMapper;

    @Override
    public BaihouWxUser findOrCreateByCode(String code)
    {
        // 测试阶段：跳过真实微信 code2session，直接用 code 当 openid
        String openid = code;
        BaihouWxUser user = wxUserMapper.selectByOpenid(openid);
        if (user == null)
        {
            user = new BaihouWxUser();
            user.setOpenid(openid);
            user.setRole(1);
            user.setStatus("active");
            // 插入后 uid 由 useGeneratedKeys 回填
            wxUserMapper.insertUser(user);
            // 用 uid 后 4 位设置昵称（插入后 uid 已回填）
            String suffix = String.format("%04d", user.getUid() % 10000);
            user.setNickname("用户" + suffix);
        }
        return user;
    }
}
