package com.WatchX.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.WatchX.config.DbConfig;
import com.WatchX.model.UserModel;
/**
 * RegisterService handles the registration of new users for WatchX.
 * It manages database interactions for user registration.
 */
public class RegisterService {
    private Connection dbConn;

    /**
     * Constructor initializes the database connection.
     */
    public RegisterService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Registers a new user in the database.
     *
     * @param userModel the user details to be registered
     * @return Boolean true if success, false if username/email exists, null if DB error
     */
    public Boolean addUser(UserModel userModel) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return null;
        }

        try {
            // Check for duplicate username or email
            if (isUsernameExists(userModel.getUserName())) {
                System.err.println("Username already exists.");
                return false;
            }
            if (isEmailExists(userModel.getEmail())) {
                System.err.println("Email already exists.");
                return false;
            }

            String insertQuery = "INSERT INTO User (firstName, lastName, username, Email, contactNo, address, password) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {
                insertStmt.setString(1, userModel.getFirstName());
                insertStmt.setString(2, userModel.getLastName());
                insertStmt.setString(3, userModel.getUserName());
                insertStmt.setString(4, userModel.getEmail());
                insertStmt.setString(5, userModel.getContactNumber());
                insertStmt.setString(6, userModel.getAddress());
                insertStmt.setString(7, userModel.getPassword());

                return insertStmt.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            System.err.println("Error during user registration: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Checks if a username already exists in the database.
     *
     * @param username the username to check
     * @return true if username exists, false otherwise
     */
    public boolean isUsernameExists(String username) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String query = "SELECT COUNT(*) FROM User WHERE username = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking username existence: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Checks if an email already exists in the database.
     *
     * @param email the email to check
     * @return true if email exists, false otherwise
     */
    public boolean isEmailExists(String email) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return false;
        }

        String query = "SELECT COUNT(*) FROM User WHERE Email = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}
