package com.ruoyi.common.context;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

/**
 * 小程序 JWT 令牌服务（不走 Redis，纯 JWT）
 */
@Component
public class BaihouMiniTokenService
{
    private static final String CLAIM_UID = "uid";
    private static final String CLAIM_ROLE = "role";
    private static final String CLAIM_OPENID = "openid";

    /** 复用若依 token.secret 配置 */
    @Value("${token.secret}")
    private String secret;

    /** 小程序 token 有效期（毫秒），默认 7 天 */
    private static final long EXPIRE_MS = 7L * 24 * 60 * 60 * 1000;

    public String createToken(Long uid, Integer role, String openid)
    {
        Map<String, Object> claims = new HashMap<>();
        claims.put(CLAIM_UID, uid);
        claims.put(CLAIM_ROLE, role);
        claims.put(CLAIM_OPENID, openid);
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRE_MS))
                .signWith(SignatureAlgorithm.HS512, secret)
                .compact();
    }

    /**
     * 解析 token，失败时返回 null
     */
    public Claims parseToken(String token)
    {
        try
        {
            return Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody();
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public Long getUid(Claims claims)
    {
        return claims.get(CLAIM_UID, Long.class);
    }

    public Integer getRole(Claims claims)
    {
        Number role = (Number) claims.get(CLAIM_ROLE);
        return role == null ? null : role.intValue();
    }

    public String getOpenid(Claims claims)
    {
        return claims.get(CLAIM_OPENID, String.class);
    }
}
