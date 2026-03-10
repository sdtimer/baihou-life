package com.ruoyi.baihou.mapper;

/**
 * Baihou wx user mapper.
 */
public interface BaihouWxUserMapper
{
    Long selectUserIdByPhoneHash(String phoneHash);

    int updateUserRole(Long userId, Integer role);

    int updateUserStatus(Long userId, String status);
}
