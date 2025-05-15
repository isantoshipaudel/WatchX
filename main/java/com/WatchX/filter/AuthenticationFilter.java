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

    private static final String[] PUBLIC_PAGES = {
        "/login", "/register", "/home", "/", 
        "/collections", "/aboutUs", "/contact"
    };

    private static final String[] CUSTOMER_PAGES = {
        "/account/orders", "/update"
    };

    private static final String[] ADMIN_PAGES = {
        "/admin/dashboard", "/admin/dashboard/products",
        "/admin/users", "/admin/orders", "/admin/addProduct",
        "/admin/updateProduct", "/admin/deleteProduct"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String contextPath = req.getContextPath();
        String uri = req.getRequestURI();
        String normalizedUri = uri.substring(contextPath.length());

        if (isStaticResource(normalizedUri)) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.getAttribute(req, "username") != null;
        String userRole = CookieUtil.getCookieValue(req, "role");

        boolean isAdminPage = isAdminPage(normalizedUri);
        boolean isCustomerPage = isCustomerPage(normalizedUri);
        boolean isPublicPage = isPublicPage(normalizedUri);

        // Admin user logic
        if ("admin".equals(userRole)) {
            if (normalizedUri.equals("/login") || normalizedUri.equals("/register")) {
                res.sendRedirect(contextPath + "/admin/dashboard");
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        // Customer user logic
        else if ("customer".equals(userRole)) {
            if (isAdminPage) {
                res.sendRedirect(contextPath + "/home");
                return;
            }
            if (normalizedUri.equals("/login") || normalizedUri.equals("/register")) {
                res.sendRedirect(contextPath + "/home");
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        // Guest (not logged in)
        else {
            if (isAdminPage || isCustomerPage) {
                res.sendRedirect(contextPath + "/login");
                return;
            }
            chain.doFilter(request, response);
        }
    }

    private boolean isStaticResource(String uri) {
        return uri.endsWith(".png") || uri.endsWith(".jpg") ||
               uri.endsWith(".jpeg") || uri.endsWith(".gif") ||
               uri.endsWith(".css") || uri.endsWith(".js") ||
               uri.startsWith("/css/") || uri.startsWith("/js/") || 
               uri.startsWith("/images/");
    }

    private boolean isPublicPage(String uri) {
        for (String page : PUBLIC_PAGES) {
            if (uri.equals(page) || uri.startsWith(page + "/")) {
                return true;
            }
        }
        return false;
    }

    private boolean isCustomerPage(String uri) {
        for (String page : CUSTOMER_PAGES) {
            if (uri.equals(page) || uri.startsWith(page + "/")) {
                return true;
            }
        }
        return false;
    }

    private boolean isAdminPage(String uri) {
        for (String page : ADMIN_PAGES) {
            if (uri.equals(page) || uri.startsWith(page + "/")) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}
