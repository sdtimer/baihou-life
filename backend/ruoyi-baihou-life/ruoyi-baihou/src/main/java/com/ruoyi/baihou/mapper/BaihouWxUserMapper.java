package com.ruoyi.baihou.mapper;

import com.ruoyi.baihou.domain.BaihouWxUser;

/**
 * Baihou wx user mapper.
 */
public interface BaihouWxUserMapper
{
    Long selectUserIdByPhoneHash(String phoneHash);

    int updateUserRole(Long userId, Integer role);

    int updateUserStatus(Long userId, String status);

    BaihouWxUser selectByOpenid(String openid);

    int insertUser(BaihouWxUser user);
}
