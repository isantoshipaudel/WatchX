package com.WatchX.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import com.WatchX.model.ProductModel;
import com.WatchX.service.AddService;
import com.WatchX.util.*;

@WebServlet("/admin/updateProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class UpdateProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AddService productService;
    private ImageUtil imageUtil;

    @Override
    public void init() throws ServletException {
        try {
            this.productService = new AddService();
            imageUtil = new ImageUtil();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ProductService", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is admin
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String productNoParam = request.getParameter("productNo");
            if (productNoParam == null || productNoParam.trim().isEmpty()) {
                setErrorAndRedirect(request, response, "Product ID is required");
                return;
            }

            int productNo = Integer.parseInt(productNoParam);
            ProductModel product = productService.getProductById(productNo);

            if (product == null) {
                setErrorAndRedirect(request, response, "Product not found");
                return;
            }

            request.setAttribute("product", product);
            forwardToUpdatePage(request, response);

        } catch (NumberFormatException e) {
            setErrorAndRedirect(request, response, "Invalid Product ID format");
        } catch (Exception e) {
            setErrorAndRedirect(request, response, "Error loading product: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ProductModel existingProduct = null;
        try {
            String productNoParam = request.getParameter("productNo");
            if (productNoParam == null || productNoParam.trim().isEmpty()) {
                setErrorAndRedirect(request, response, "Product ID is required");
                return;
            }

            int productNo = Integer.parseInt(productNoParam);
            existingProduct = productService.getProductById(productNo);

            if (existingProduct == null) {
                setErrorAndRedirect(request, response, "Product not found");
                return;
            }

            // Update product details
            existingProduct.setProductName(request.getParameter("productName"));
            existingProduct.setDescription(request.getParameter("description"));
            existingProduct.setCategory(request.getParameter("category"));
            existingProduct.setUnitPrice(request.getParameter("unitPrice"));

            // Handle image upload
            Part filePart = request.getPart("productImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = imageUtil.generateUniqueFileName(filePart);
                String imagePath = "resources/images/uploads/" + fileName;

                if (imageUtil.uploadImage(filePart, "uploads", fileName)) {
                    // Delete old image if not default
                    if (existingProduct.getimage_path() != null &&
                        !existingProduct.getimage_path().equals("uploads/default_product.jpg")) {
                        File oldImage = new File(request.getServletContext().getRealPath("") +
                                        existingProduct.getimage_path());
                        if (oldImage.exists()) oldImage.delete();
                    }
                    existingProduct.setimage_path(imagePath);
                }
            }

            // Update product in database
            boolean success = productService.updateProduct(existingProduct);

            if (success) {
                request.setAttribute("success", "Product updated successfully");
            } else {
                request.setAttribute("error", "Failed to update product");
            }
            request.setAttribute("product", existingProduct);
            forwardToUpdatePage(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error updating product: " + e.getMessage());
            if (existingProduct != null) {
                request.setAttribute("product", existingProduct);
            }
            forwardToUpdatePage(request, response);
        }
    }

    private boolean isAdmin(HttpSession session) {
        return session != null && "admin".equals(session.getAttribute("role"));
    }

    private void forwardToUpdatePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/UpdateProduct.jsp").forward(request, response);
    }

    private void setErrorAndRedirect(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        forwardToUpdatePage(request, response);
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