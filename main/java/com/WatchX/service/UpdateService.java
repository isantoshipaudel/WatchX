package com.WatchX.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import com.WatchX.config.DbConfig;
import com.WatchX.model.UserModel;
import com.WatchX.util.PasswordUtil;

public class UpdateService {
    private Connection dbConn;

    public UpdateService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
            System.out.println("[UpdateService] Database connection established");
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("[UpdateService] DB connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public Boolean updateCustomerInfo(UserModel userModel, String currentUsername) {
        if (dbConn == null) {
            System.err.println("[UpdateService] No database connection");
            return null;
        }

        try {
            dbConn.setAutoCommit(false);
            System.out.println("[UpdateService] Starting update for: " + currentUsername);

            // Check if new username exists (if changed)
            if (!userModel.getUserName().equals(currentUsername)) {
                System.out.println("[UpdateService] Checking new username availability");
                if (isUsernameExists(userModel.getUserName())) {
                    System.err.println("[UpdateService] Username already exists");
                    dbConn.rollback();
                    return false;
                }
            }

            // Check email uniqueness
            System.out.println("[UpdateService] Checking email uniqueness");
            if (isEmailExistsForOtherUser(userModel.getEmail(), currentUsername)) {
                System.err.println("[UpdateService] Email in use by another user");
                dbConn.rollback();
                return false;
            }

            // Build dynamic query based on whether password is being updated
            StringBuilder updateQuery = new StringBuilder(
                "UPDATE User SET firstName=?, lastName=?, username=?, " +
                "address=?, contactNo=?, Email=?"
            );

            // Add password to update if provided
            boolean updatePassword = userModel.getPassword() != null && !userModel.getPassword().isEmpty();
            if (updatePassword) {
                updateQuery.append(", password=?");
                System.out.println("[UpdateService] Password will be updated");
            }

            updateQuery.append(" WHERE username=?");

            try (PreparedStatement stmt = dbConn.prepareStatement(updateQuery.toString())) {
                int paramIndex = 1;
                stmt.setString(paramIndex++, userModel.getFirstName());
                stmt.setString(paramIndex++, userModel.getLastName());
                stmt.setString(paramIndex++, userModel.getUserName());
                stmt.setString(paramIndex++, userModel.getAddress());
                stmt.setString(paramIndex++, userModel.getContactNumber());
                stmt.setString(paramIndex++, userModel.getEmail());
                stmt.setString(7, currentUsername);
                // Add password parameter if updating
                if (updatePassword) {
                    String encryptedPassword = PasswordUtil.encrypt(userModel.getUserName(), userModel.getPassword());
                    if (encryptedPassword == null) {
                        System.err.println("[UpdateService] Password encryption failed");
                        dbConn.rollback();
                        return false;
                    }
                    stmt.setString(paramIndex++, encryptedPassword);
                }

                stmt.setString(paramIndex, currentUsername);

                int rowsAffected = stmt.executeUpdate();
                System.out.println("[UpdateService] Rows affected: " + rowsAffected);
                
                if (rowsAffected == 0) {
                    System.err.println("[UpdateService] No rows updated");
                    dbConn.rollback();
                    return false;
                }

                dbConn.commit();
                System.out.println("[UpdateService] Update successful");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("[UpdateService] Update error: " + e.getMessage());
            try { dbConn.rollback(); } catch (SQLException ex) {}
            e.printStackTrace();
            return null;
        } finally {
            try { dbConn.setAutoCommit(true); } catch (SQLException e) {}
        }
    }

    public Boolean updatePasswordOnly(String username, String newPassword) {
        if (dbConn == null) {
            System.err.println("[UpdateService] No database connection");
            return null;
        }

        try {
            dbConn.setAutoCommit(false);
            System.out.println("[UpdateService] Starting password update for: " + username);

            String encryptedPassword = PasswordUtil.encrypt(username, newPassword);
            if (encryptedPassword == null) {
                System.err.println("[UpdateService] Password encryption failed");
                dbConn.rollback();
                return false;
            }

            String updateQuery = "UPDATE User SET password=? WHERE username=?";

            try (PreparedStatement stmt = dbConn.prepareStatement(updateQuery)) {
                stmt.setString(1, encryptedPassword);
                stmt.setString(2, username);

                int rowsAffected = stmt.executeUpdate();
                System.out.println("[UpdateService] Rows affected by password update: " + rowsAffected);
                
                if (rowsAffected == 0) {
                    System.err.println("[UpdateService] No rows updated - user may not exist");
                    dbConn.rollback();
                    return false;
                }

                dbConn.commit();
                System.out.println("[UpdateService] Password update successful");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("[UpdateService] Password update error: " + e.getMessage());
            try { dbConn.rollback(); } catch (SQLException ex) {}
            e.printStackTrace();
            return null;
        } finally {
            try { dbConn.setAutoCommit(true); } catch (SQLException e) {}
        }
    }

    public UserModel getUserByUsername(String username) {
        if (dbConn == null) {
            System.err.println("[UpdateService] No database connection");
            return null;
        }

        System.out.println("[UpdateService] Fetching user: " + username);
        String query = "SELECT userNo, firstName, lastName, username, Email, contactNo, address, password " +
                     "FROM User WHERE username = ?";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    UserModel user = new UserModel();
                    user.setUserNo(rs.getInt("userNo"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setUserName(rs.getString("username"));
                    user.setEmail(rs.getString("Email"));
                    user.setContactNumber(rs.getString("contactNo"));
                    user.setAddress(rs.getString("address"));
                    user.setPassword(rs.getString("password")); // Store encrypted password
                    
                    System.out.println("[UpdateService] Found user: " + user.getUserName());
                    return user;
                }
                System.out.println("[UpdateService] No user found with username: " + username);
            }
        } catch (SQLException e) {
            System.err.println("[UpdateService] Fetch error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean verifyCurrentPassword(String username, String currentPassword) {
        if (dbConn == null) {
            System.err.println("[UpdateService] No database connection");
            return false;
        }

        String query = "SELECT password FROM User WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedEncryptedPassword = rs.getString("password");
                    return PasswordUtil.validateCredentials(username, currentPassword, storedEncryptedPassword);
                }
                return false;
            }
        } catch (SQLException e) {
            System.err.println("[UpdateService] Password verification error: " + e.getMessage());
            return false;
        }
    }

    private boolean isUsernameExists(String username) {
        String query = "SELECT COUNT(*) FROM User WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("[UpdateService] Username check error: " + e.getMessage());
            return false;
        }
    }

    private boolean isEmailExistsForOtherUser(String email, String username) {
        String query = "SELECT COUNT(*) FROM User WHERE Email = ? AND username != ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("[UpdateService] Email check error: " + e.getMessage());
            return false;
        }
    }

    public void debugListAllUsernames() {
        try (Statement st = dbConn.createStatement();
             ResultSet rs = st.executeQuery("SELECT username FROM User")) {
            System.out.println("[UpdateService] All usernames in database:");
            while (rs.next()) {
                System.out.println(" - " + rs.getString("username"));
            }
        } catch (SQLException e) {
            System.err.println("[UpdateService] Error listing usernames: " + e.getMessage());
        }
    }

    public void close() {
        try {
            if (dbConn != null && !dbConn.isClosed()) {
                dbConn.close();
                System.out.println("[UpdateService] DB connection closed");
            }
        } catch (SQLException e) {
            System.err.println("[UpdateService] Close error: " + e.getMessage());
        }
    }
}