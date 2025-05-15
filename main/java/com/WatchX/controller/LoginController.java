package com.WatchX.controller;

import java.io.IOException;
import com.WatchX.model.UserModel;
import com.WatchX.service.LoginService;
import com.WatchX.util.CookieUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(asyncSupported = true, urlPatterns = { "/login", "/" })
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final LoginService loginService;

    public LoginController() {
        this.loginService = new LoginService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserModel userModel = new UserModel(username, password);
        Boolean loginStatus = loginService.loginUser(userModel);

        if (loginStatus != null && loginStatus) {
            HttpSession session = req.getSession(true); 
            session.setAttribute("user", userModel);
            session.setAttribute("username", username);
            
            // Set role in both session and cookie
            String role = "Santoshi".equalsIgnoreCase(username) ? "admin" : "customer";
            session.setAttribute("role", role);  
            CookieUtil.addCookie(resp, "role", role, 5 * 30);
            
            // Set success message in session
            session.setAttribute("successMessage", "Welcome back, " + username + "!");

            if ("admin".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            handleLoginFailure(req, resp, loginStatus);
        }
    }

    private void handleLoginFailure(HttpServletRequest req, HttpServletResponse resp, Boolean loginStatus)
            throws ServletException, IOException {
        String errorMessage = (loginStatus == null) 
            ? "Our server is under maintenance. Please try again later!"
            : "User details mismatch. Please try again!";
        req.setAttribute("errorMessage", errorMessage);
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }
}