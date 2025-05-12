package com.WatchX.service;

import java.sql.*;
import java.util.*;
import com.WatchX.config.*;
import com.WatchX.model.ProductModel;

public class AddService {
    private Connection dbConn;

    public AddService() throws SQLException, ClassNotFoundException {
        this.dbConn = DbConfig.getDbConnection();
        
        // Verify connection
        if (this.dbConn == null || this.dbConn.isClosed()) {
            throw new SQLException("Failed to establish database connection");
        }
    }

    // Add a new product
    public boolean addProduct(ProductModel product) throws SQLException {
        String sql = "INSERT INTO Product (productNo, productName, description, category, unitPrice, image_path) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        System.out.println("Executing SQL: " + sql); // Debug log
        System.out.println("With parameters: " + product); // Debug log
        
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setInt(1, product.getProductNo());
            stmt.setString(2, product.getProductName());
            stmt.setString(3, product.getDescription());
            stmt.setString(4, product.getCategory());
            stmt.setString(5, product.getUnitPrice());
            stmt.setString(6, product.getimage_path());
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Debug log
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage()); // Debug log
            throw e;
        }
    }

    // Update an existing product
    public boolean updateProduct(ProductModel product) throws SQLException {
        String sql = "UPDATE Product SET " +
                     "productName = ?, " +
                     "description = ?, " +
                     "category = ?, " +
                     "unitPrice = ?, " +
                     "image_path = ? " +
                     "WHERE productNo = ?";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getDescription());
            stmt.setString(3, product.getCategory());
            stmt.setString(4, product.getUnitPrice());
            stmt.setString(5, product.getimage_path());
            stmt.setInt(6, product.getProductNo());
            
            return stmt.executeUpdate() > 0;
        }
    }

    // Get product by ID
    public ProductModel getProductById(int productNo) throws SQLException {
        String sql = "SELECT * FROM Product WHERE productNo = ?";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setInt(1, productNo);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new ProductModel(
                        rs.getInt("productNo"),
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getString("unitPrice"),
                        rs.getString("image_path")
                    );
                }
            }
        }
        return null;
    }

    // Get all products
    public List<ProductModel> getAllProducts() throws SQLException {
        List<ProductModel> products = new ArrayList<>();
        String sql = "SELECT * FROM Product ORDER BY productNo DESC";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                products.add(new ProductModel(
                    rs.getInt("productNo"),
                    rs.getString("productName"),
                    rs.getString("description"),
                    rs.getString("category"),
                    rs.getString("unitPrice"),
                    rs.getString("image_path")
                ));
            }
        }
        return products;
    }

    // Search products
    public List<ProductModel> searchProducts(String searchTerm) throws SQLException {
        List<ProductModel> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE " +
                     "productName LIKE ? OR " +
                     "description LIKE ? OR " +
                     "category LIKE ? " +
                     "ORDER BY productNo DESC";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            String likeTerm = "%" + searchTerm + "%";
            stmt.setString(1, likeTerm);
            stmt.setString(2, likeTerm);
            stmt.setString(3, likeTerm);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(new ProductModel(
                        rs.getInt("productNo"),
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getString("unitPrice"),
                        rs.getString("image_path")
                    ));
                }
            }
        }
        return products;
    }

    // Delete a product
    public boolean deleteProduct(int productNo) throws SQLException {
        String sql = "DELETE FROM Product WHERE productNo = ?";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setInt(1, productNo);
            return stmt.executeUpdate() > 0;
        }
    }

    public void close() throws SQLException {
        if (dbConn != null && !dbConn.isClosed()) {
            dbConn.close();
        }
    }
}