package com.WatchX.service;

import java.sql.*;
import com.WatchX.config.*;

public class DashboardService {
    private Connection dbConn;

    public DashboardService() throws SQLException, ClassNotFoundException {
        this.dbConn = DbConfig.getDbConnection();
    }

    public int getTotalUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM User";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTotalCustomers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM User WHERE role = 'customer'";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTotalProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Product";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTotalOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM `Order`";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public double getTotalRevenue() throws SQLException {
        String sql = "SELECT SUM(CAST(p.unitPrice AS DECIMAL(10,2))) " +
                     "FROM `Order` o " +
                     "JOIN Product p ON o.productNo = p.productNo";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getDouble(1) : 0.0;
        }
    }

    public int getTotalProductsInStock() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Product WHERE isAvailable = true";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTotalCategories() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT category) FROM Product";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public void close() throws SQLException {
        if (dbConn != null) {
            dbConn.close();
        }
    }
}