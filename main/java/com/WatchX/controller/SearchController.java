package com.WatchX.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.WatchX.model.ProductModel;
import com.WatchX.service.AddService;

@WebServlet("/search")
public class SearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AddService productService;

    @Override
    public void init() throws ServletException {
        try {
            productService = new AddService();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ProductService", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String searchQuery = request.getParameter("query");

        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            request.setAttribute("error", "Search term cannot be empty.");
            request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
            return;
        }

        try {
            List<ProductModel> searchResults = productService.searchProducts(searchQuery);
            request.setAttribute("products", searchResults);
            request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error searching products: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        try {
            if (productService != null) {
                productService.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing ProductService: " + e.getMessage());
        }
    }
}
