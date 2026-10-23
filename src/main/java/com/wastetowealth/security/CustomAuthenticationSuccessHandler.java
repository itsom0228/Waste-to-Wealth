package com.wastetowealth.security;

import com.wastetowealth.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private final UserService userService;

    public CustomAuthenticationSuccessHandler(UserService userService) {
        this.userService = userService;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        // Record last login timestamp safely
        try {
            userService.updateLastLogin(authentication.getName());
        } catch (Exception ignored) {}

        for (GrantedAuthority authority : authentication.getAuthorities()) {
            String role = authority.getAuthority();
            if ("ROLE_ADMIN".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            } else if ("ROLE_FARMER".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/farmer/dashboard");
                return;
            } else if ("ROLE_BUYER".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/buyer/dashboard");
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/");
    }
}
