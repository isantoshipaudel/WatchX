package com.WatchX.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.WatchX.service.AddService;

@WebServlet("/admin/deleteProduct")
public class DeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AddService productService;

    @Override
    public void init() throws ServletException {
        try {
            productService = new AddService();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize AddService", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is admin
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            session.setAttribute("errorMessage", "You don't have permission to perform this action");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String productNoStr = request.getParameter("productNo");
            if (productNoStr == null || productNoStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Product ID is required");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
                return;
            }

            int productNo = Integer.parseInt(productNoStr.trim());
            boolean deleted = productService.deleteProduct(productNo);

            if (deleted) {
                session.setAttribute("successMessage", "Product #" + productNo + " deleted successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to delete product #" + productNo);
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid product ID format");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error deleting product: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
        }
    }

    @Override
    public void destroy() {
        try {
            if (productService != null) {
                productService.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing product service: " + e.getMessage());
        }
    }
}