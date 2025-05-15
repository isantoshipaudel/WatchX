package com.WatchX.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;

public class CookieUtil {
    
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
        if (response == null || name == null) {
            return;
        }
        
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }
    
    public static Cookie getCookie(HttpServletRequest request, String name) {
        if (request == null || name == null || request.getCookies() == null) {
            return null;
        }
        return Arrays.stream(request.getCookies())
                .filter(cookie -> name.equals(cookie.getName()))
                .findFirst()
                .orElse(null);
    }
    
    public static void deleteCookie(HttpServletResponse response, String name) {
        if (response == null || name == null) {
            return;
        }
        
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }
    
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie cookie = getCookie(request, name);
        return cookie != null ? cookie.getValue() : null;
    }
}