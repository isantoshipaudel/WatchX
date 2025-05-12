package com.WatchX.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import com.WatchX.model.ProductModel;
import com.WatchX.service.AddService;
import java.util.*;

@WebServlet("/admin/dashboard/products")
public class ProductsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AddService productService;

    @Override
    public void init() throws ServletException {
        try {
            this.productService = new AddService();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ProductService", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<ProductModel> products = productService.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error fetching products", e);
        }
        try {
            String searchTerm = request.getParameter("search");
            List<ProductModel> products;
            
            if (searchTerm != null && !searchTerm.isEmpty()) {
                products = productService.searchProducts(searchTerm);
            } else {
                products = productService.getAllProducts();
            }
            
            request.setAttribute("products", products);
            request.setAttribute("searchTerm", searchTerm); // Preserve search term in form
            request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error fetching products", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("delete".equals(action)) {
                int productNo = Integer.parseInt(request.getParameter("productNo"));
                productService.deleteProduct(productNo);
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products?success=Product+deleted");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard/products?error=" + e.getMessage());
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