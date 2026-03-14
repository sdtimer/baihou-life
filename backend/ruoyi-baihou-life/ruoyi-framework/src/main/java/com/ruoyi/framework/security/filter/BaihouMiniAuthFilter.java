package com.ruoyi.framework.security.filter;

import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import com.ruoyi.common.context.BaihouMiniContext;
import com.ruoyi.common.context.BaihouMiniTokenService;
import io.jsonwebtoken.Claims;

/**
 * 小程序 JWT 解析过滤器：解析 Authorization header 并注入 BaihouMiniContext。
 * 不干扰若依的 SecurityContext，/v1/** /v2/** 路径通过 Security 的 permitAll() 放行后，
 * 需要认证的接口在 controller 内部检查 BaihouMiniContext.isLoggedIn()。
 */
@Component
public class BaihouMiniAuthFilter extends OncePerRequestFilter
{
    private static final String HEADER = "Authorization";
    private static final String BEARER_PREFIX = "Bearer ";

    @Autowired
    private BaihouMiniTokenService miniTokenService;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException
    {
        try
        {
            String uri = request.getRequestURI();
            if (uri.startsWith("/v1/") || uri.startsWith("/v2/"))
            {
                String header = request.getHeader(HEADER);
                if (header != null && header.startsWith(BEARER_PREFIX))
                {
                    String token = header.substring(BEARER_PREFIX.length());
                    Claims claims = miniTokenService.parseToken(token);
                    if (claims != null)
                    {
                        Long uid = miniTokenService.getUid(claims);
                        Integer role = miniTokenService.getRole(claims);
                        String openid = miniTokenService.getOpenid(claims);
                        BaihouMiniContext.set(uid, role, openid);
                    }
                }
            }
            filterChain.doFilter(request, response);
        }
        finally
        {
            BaihouMiniContext.clear();
        }
    }
}
