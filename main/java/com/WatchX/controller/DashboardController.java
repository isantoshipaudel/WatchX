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
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) 
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

            // Check for any session messages and transfer them to request
            HttpSession session = request.getSession(false);
            if (session != null) {
                String successMsg = (String) session.getAttribute("successMessage");
                if (successMsg != null) {
                    request.setAttribute("successMessage", successMsg);
                    session.removeAttribute("successMessage");
                }
                
                String errorMsg = (String) session.getAttribute("errorMessage");
                if (errorMsg != null) {
                    request.setAttribute("errorMessage", errorMsg);
                    session.removeAttribute("errorMessage");
                }
            }

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
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
