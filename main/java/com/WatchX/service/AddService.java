package com.WatchX.service;

import com.WatchX.config.DbConfig;
import com.WatchX.model.ProductModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddService {
    private Connection dbConn;

    public AddService() throws SQLException, ClassNotFoundException {
        this.dbConn = DbConfig.getDbConnection();
        if (dbConn == null || dbConn.isClosed()) {
            throw new SQLException("Unable to connect to database");
        }
    }

    public boolean addProduct(ProductModel product) throws SQLException {
        String sql = "INSERT INTO Product (productNo, productName, description, category, unitPrice, image_path) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setInt(1, product.getProductNo());
            stmt.setString(2, product.getProductName());
            stmt.setString(3, product.getDescription());
            stmt.setString(4, product.getCategory());
            stmt.setString(5, product.getUnitPrice());
            stmt.setString(6, product.getimage_path());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateProduct(ProductModel product) throws SQLException {
        String sql = "UPDATE Product SET productName=?, description=?, category=?, unitPrice=?, image_path=? WHERE productNo=?";
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

    public ProductModel getProductById(int productNo) throws SQLException {
        String sql = "SELECT * FROM Product WHERE productNo = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setInt(1, productNo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        }
        return null;
    }

    public List<ProductModel> getAllProducts() throws SQLException {
        String sql = "SELECT * FROM Product ORDER BY productNo DESC";
        List<ProductModel> products = new ArrayList<>();
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        }
        return products;
    }

    public List<ProductModel> searchProducts(String searchTerm) throws SQLException {
        String sql = "SELECT * FROM Product WHERE productName LIKE ? OR description LIKE ? OR category LIKE ? ORDER BY productNo DESC";
        List<ProductModel> products = new ArrayList<>();
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            String like = "%" + searchTerm + "%";
            stmt.setString(1, like);
            stmt.setString(2, like);
            stmt.setString(3, like);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }

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

    private ProductModel mapResultSetToProduct(ResultSet rs) throws SQLException {
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
