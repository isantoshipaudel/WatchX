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
        try {
            // Get form parameters
            int productNo = Integer.parseInt(request.getParameter("productNumber"));
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String unitPrice = request.getParameter("unitPrice");
            
            // Handle file upload
            Part filePart = request.getPart("productImage");
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
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products?success=true");
            } else {
                request.setAttribute("error", "Failed to add product. Please try again.");
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid product number format. Please enter a valid number.");
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            doGet(request, response);
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