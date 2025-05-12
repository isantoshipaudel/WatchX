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

    public void close() throws SQLException {
        if (dbConn != null) {
            dbConn.close();
        }
    }
}