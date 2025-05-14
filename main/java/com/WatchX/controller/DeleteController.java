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
            System.out.println("DeleteController initialized");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize AddService", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Enhanced role checking
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        
        if (!"admin".equals(role)) {
            System.out.println("Unauthorized delete attempt: Role = " + role);
            request.setAttribute("error", "You don't have permission to perform this action");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String productNoStr = request.getParameter("productNo");
            if (productNoStr == null || productNoStr.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Product ID is required");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
                return;
            }

            int productNo = Integer.parseInt(productNoStr.trim());
            boolean deleted = productService.deleteProduct(productNo);

            if (deleted) {
            	session.setAttribute("success", "Product " + productNo + " deleted successfully");
                System.out.println("Product " + productNo + " deleted");
            } else {
                request.getSession().setAttribute("error", "Failed to delete product");
                System.out.println("Failed to delete product " + productNo);
            }
            
            // Redirect to the correct dashboard products page
            response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid product ID");
            System.err.println("Invalid product number: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error deleting product: " + e.getMessage());
            System.err.println("Delete error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
        }
    }
}