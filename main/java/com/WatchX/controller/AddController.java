package com.WatchX.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import com.WatchX.model.ProductModel;
import com.WatchX.service.AddService;

@WebServlet("/admin/addProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100    // 100 MB
)
public class AddController extends HttpServlet {
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
        request.getRequestDispatcher("/WEB-INF/pages/AddProduct.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            // Validate input
            String productNumberStr = request.getParameter("productNumber");
            if (productNumberStr == null || productNumberStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Product number is required.");
                response.sendRedirect(request.getContextPath() + "/admin/addProduct");
                return;
            }

            // Get form parameters
            int productNo = Integer.parseInt(productNumberStr);
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String unitPrice = request.getParameter("unitPrice");
            
            // Validate required fields
            if (productName == null || productName.trim().isEmpty() ||
                category == null || category.trim().isEmpty() ||
                unitPrice == null || unitPrice.trim().isEmpty()) {
                session.setAttribute("errorMessage", "All required fields must be filled out.");
                response.sendRedirect(request.getContextPath() + "/admin/addProduct");
                return;
            }
            
            // Handle file upload
            Part filePart = request.getPart("productImage");
            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("errorMessage", "Product image is required.");
                response.sendRedirect(request.getContextPath() + "/admin/addProduct");
                return;
            }

            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            
            // Get the absolute path to the webapp directory
            String appPath = request.getServletContext().getRealPath("");
            
            // Create uploads directory if it doesn't exist
            String uploadPath = appPath + "resources/images/uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Save the file
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            
            // Relative path to store in DB (for web access)
            String imagePath = "resources/images/uploads/" + fileName;

            // Create product model
            ProductModel product = new ProductModel(
                productNo,
                productName,
                description,
                category,
                unitPrice,
                imagePath
            );

            // Add product to database
            boolean success = productService.addProduct(product);
            if (success) {
                session.setAttribute("successMessage", "Product added successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
            } else {
                session.setAttribute("errorMessage", "Failed to add product. Please try again.");
                response.sendRedirect(request.getContextPath() + "/admin/addProduct");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid product number format. Please enter a valid number.");
            response.sendRedirect(request.getContextPath() + "/admin/addProduct");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/addProduct");
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