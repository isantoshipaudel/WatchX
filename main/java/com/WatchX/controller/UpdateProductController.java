package com.WatchX.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import com.WatchX.model.ProductModel;
import com.WatchX.service.AddService;
import com.WatchX.util.ImageUtil;

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
            this.imageUtil = new ImageUtil();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize services", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

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
                // Get the upload directory path
                String uploadDir = request.getServletContext().getRealPath("/resources/images/uploads");
                File uploadDirFile = new File(uploadDir);
                
                // Create directory if it doesn't exist
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }

                // Generate unique filename
                String fileName = imageUtil.generateUniqueFileName(filePart);
                
                // Save the file
                filePart.write(uploadDir + File.separator + fileName);
                
                // Delete old image if it exists and isn't the default
                if (existingProduct.getimage_path() != null && 
                    !existingProduct.getimage_path().equals("resources/images/uploads/default_product.jpg")) {
                    String oldImagePath = request.getServletContext().getRealPath(existingProduct.getimage_path());
                    File oldImage = new File(oldImagePath);
                    if (oldImage.exists()) {
                        oldImage.delete();
                    }
                }
                
                // Update the image path in the product
                existingProduct.setimage_path("resources/images/uploads/" + fileName);
            }

            // Update product in database
            boolean success = productService.updateProduct(existingProduct);

            if (success) {
                session.setAttribute("successMessage", "Product #" + productNo + " updated successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
            } else {
                session.setAttribute("errorMessage", "Failed to update product");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard/products");
            }

        } catch (Exception e) {
            e.printStackTrace();
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