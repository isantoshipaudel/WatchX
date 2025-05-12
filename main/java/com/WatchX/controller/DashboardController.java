package com.WatchX.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.WatchX.service.DashboardService;

@WebServlet("/admin/dashboard")
public class DashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        try {
            this.dashboardService = new DashboardService();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize DashboardService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get statistics from service
            int totalUsers = dashboardService.getTotalUsers();
            int totalCustomers = dashboardService.getTotalCustomers();
            int totalProducts = dashboardService.getTotalProducts();
            int totalOrders = dashboardService.getTotalOrders();

            // Set data as request attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);

            // Forward to dashboard JSP (make sure the path is correct and has leading slash)
            System.out.println("Forwarding to /WEB-INF/pages/dashboard.jsp"); // Debug line
            request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // Log actual error
            throw new ServletException("Error processing dashboard request", e);
        }
    }

    @Override
    public void destroy() {
        try {
            if (dashboardService != null) {
                dashboardService.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing DashboardService: " + e.getMessage());
        }
    }
}
