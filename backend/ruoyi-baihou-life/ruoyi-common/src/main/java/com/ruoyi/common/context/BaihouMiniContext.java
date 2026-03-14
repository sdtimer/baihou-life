package com.ruoyi.common.context;

/**
 * 小程序当前用户上下文（ThreadLocal）
 */
public class BaihouMiniContext
{
    private static final ThreadLocal<Long> UID_HOLDER = new ThreadLocal<>();
    private static final ThreadLocal<Integer> ROLE_HOLDER = new ThreadLocal<>();
    private static final ThreadLocal<String> OPENID_HOLDER = new ThreadLocal<>();

    public static void set(Long uid, Integer role, String openid)
    {
        UID_HOLDER.set(uid);
        ROLE_HOLDER.set(role);
        OPENID_HOLDER.set(openid);
    }

    public static Long getUid()
    {
        return UID_HOLDER.get();
    }

    public static Integer getRole()
    {
        return ROLE_HOLDER.get();
    }

    public static String getOpenid()
    {
        return OPENID_HOLDER.get();
    }

    public static boolean isLoggedIn()
    {
        return UID_HOLDER.get() != null;
    }

    public static void clear()
    {
        UID_HOLDER.remove();
        ROLE_HOLDER.remove();
        OPENID_HOLDER.remove();
    }
}
