package com.WatchX.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.WatchX.util.CookieUtil;
import com.WatchX.util.SessionUtil;

@WebFilter(asyncSupported = true, urlPatterns = "/*")
public class AuthenticationFilter implements Filter {
    // Page URLs
    private static final String LOGIN = "/login";
    private static final String REGISTER = "/register";
    private static final String HOME = "/home";
    private static final String ROOT = "/";
    private static final String DASHBOARD = "/admin/dashboard";
    private static final String PRODUCT_MANAGEMENT = "/admin/dashboard/products";
    private static final String USER_MANAGEMENT = "/admin/users";
    private static final String ORDER_MANAGEMENT = "/admin/orders";
    private static final String ADD_Products = "/admin/addProduct"; 
    private static final String PRODUCT_DETAILS = "/collections";
    private static final String ABOUT = "/aboutUs";
    private static final String CONTACT = "/contact";
    private static final String USER_ORDERS = "/account/orders";
    private static final String UPDATE = "/update";
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic, if required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        
        // Allow access to static resources
        if (uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".css") || uri.endsWith(".js")) {
            chain.doFilter(request, response);
            return;
        }
        
        boolean isLoggedIn = SessionUtil.getAttribute(req, "username") != null;
        String userRole = CookieUtil.getCookie(req, "role") != null ? 
                          CookieUtil.getCookie(req, "role").getValue() : null;

        if ("admin".equals(userRole)) {
            if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
                res.sendRedirect(req.getContextPath() + DASHBOARD);
            } else if (uri.endsWith(HOME) || uri.endsWith(ROOT) ||
                       uri.endsWith(ADD_Products) || uri.endsWith(PRODUCT_MANAGEMENT) || 
                       uri.endsWith(ABOUT) || uri.endsWith(CONTACT)) {
                chain.doFilter(request, response);
            } else {
                // Let admin access other allowed pages or restrict if needed
                chain.doFilter(request, response);
            }
        } else if ("customer".equals(userRole)) {
            // Regular user is logged in
            if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
                res.sendRedirect(req.getContextPath() + HOME);
            } else if (uri.endsWith(HOME) || uri.endsWith(ROOT) || 
                    uri.endsWith(PRODUCT_DETAILS) || uri.endsWith(ABOUT) || uri.endsWith(CONTACT) ||
                    uri.endsWith(USER_ORDERS) || uri.endsWith(UPDATE)) {
                chain.doFilter(request, response);
            } else {
                //res.sendRedirect(req.getContextPath() + HOME);
            	 chain.doFilter(request, response);
            }
        } else {
            // Not logged in
            if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER) || uri.endsWith(HOME) || 
                    uri.endsWith(ROOT) || uri.endsWith(PRODUCT_DETAILS) || 
                    uri.endsWith(ABOUT) || uri.endsWith(CONTACT)) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + LOGIN);
            }
        }
    }

    @Override
    public void destroy() {
        // Cleanup logic, if required
    }
}