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
            // Transfer session messages to request attributes
            HttpSession session = request.getSession(false);
            if (session != null) {
                String successMessage = (String) session.getAttribute("successMessage");
                String errorMessage = (String) session.getAttribute("errorMessage");
                
                if (successMessage != null) {
                    request.setAttribute("successMessage", successMessage);
                    session.removeAttribute("successMessage");
                }
                if (errorMessage != null) {
                    request.setAttribute("errorMessage", errorMessage);
                    session.removeAttribute("errorMessage");
                }
            }

            String searchTerm = request.getParameter("search");
            List<ProductModel> products;
            
            if (searchTerm != null && !searchTerm.isEmpty()) {
                products = productService.searchProducts(searchTerm);
            } else {
                products = productService.getAllProducts();
            }
            
            request.setAttribute("products", products);
            request.setAttribute("searchTerm", searchTerm);
            request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error fetching products: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        try {
            if ("delete".equals(action)) {
                int productNo = Integer.parseInt(request.getParameter("productNo"));
                boolean deleted = productService.deleteProduct(productNo);
                
                if (deleted) {
                    session.setAttribute("successMessage", "Product #" + productNo + " was deleted successfully");
                } else {
                    session.setAttribute("errorMessage", "Failed to delete product #" + productNo);
                }
            }
            // Redirect to refresh the page
            response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
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