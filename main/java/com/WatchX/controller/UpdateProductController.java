package com.WatchX.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import com.WatchX.model.ProductModel;
import com.WatchX.service.AddService;

@WebServlet("/admin/updateProduct")
public class UpdateProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AddService addService;

    @Override
    public void init() throws ServletException {
        try {
            this.addService = new AddService();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize AddService", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productNo = Integer.parseInt(request.getParameter("productNo"));
            ProductModel product = addService.getProductById(productNo);
            
            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products?error=Product+not+found");
            }
        } catch (Exception e) {
            throw new ServletException("Error loading product for edit", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            ProductModel product = new ProductModel(
                Integer.parseInt(request.getParameter("productNo")),
                request.getParameter("productName"),
                request.getParameter("description"),
                request.getParameter("category"),
                request.getParameter("unitPrice"),
                request.getParameter("imageUrl")
            );

            boolean success = addService.updateProduct(product);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products?success=Product+updated");
            } else {
                request.setAttribute("error", "Failed to update product");
                request.setAttribute("product", product);
                request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        try {
            if (addService != null) {
                addService.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing add service: " + e.getMessage());
        }
    }
}