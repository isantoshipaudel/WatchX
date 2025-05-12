package com.WatchX.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.WatchX.config.DbConfig;
import com.WatchX.model.UserModel;
import com.WatchX.util.PasswordUtil;

/**
 * Service class for handling login operations for WatchX application.
 * Connects to the database, verifies user credentials, and returns login status.
 */
public class LoginService {
    private Connection dbConn;
    private boolean isConnectionError = false;

    /**
     * Constructor initializes the database connection.
     * Sets the connection error flag if the connection fails.
     */
    public LoginService() {
        try {
            dbConn = DbConfig.getDbConnection();
            if (dbConn == null) {
                isConnectionError = true;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("[LoginService] Database connection error: " + ex.getMessage());
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    /**
     * Validates the user credentials against the database records.
     *
     * @param userModel the UserModel object containing user credentials
     * @return true if the user credentials are valid, false otherwise; null if a
     *         connection error occurs
     */
    public Boolean loginUser(UserModel userModel) {
        if (isConnectionError || dbConn == null) {
            System.err.println("[LoginService] Database connection error");
            return null;
        }

        if (userModel == null || userModel.getUserName() == null || userModel.getPassword() == null) {
            System.err.println("[LoginService] Invalid user model");
            return false;
        }

        String query = "SELECT username, password FROM User WHERE username = ? OR email = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, userModel.getUserName());
            stmt.setString(2, userModel.getUserName());
            
            try (ResultSet result = stmt.executeQuery()) {
                if (result.next()) {
                    return validatePassword(result, userModel);
                }
                System.out.println("[LoginService] No user found with username/email: " + userModel.getUserName());
                return false;
            }
        } catch (SQLException e) {
            System.err.println("[LoginService] Database error: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Validates the password retrieved from the database.
     *
     * @param result    the ResultSet containing the username and password from
     *                  the database
     * @param userModel the UserModel object containing user credentials
     * @return true if the passwords match, false otherwise
     * @throws SQLException if a database access error occurs
     */
    private boolean validatePassword(ResultSet result, UserModel userModel) throws SQLException {
        String dbUsername = result.getString("username");
        String dbPassword = result.getString("password");
        
        if (dbUsername == null || dbPassword == null) {
            System.err.println("[LoginService] Null username or password in database");
            return false;
        }

        String decryptedPassword = PasswordUtil.decrypt(dbPassword, dbUsername);
        if (decryptedPassword == null) {
            System.err.println("[LoginService] Password decryption failed for user: " + dbUsername);
            return false;
        }

        return decryptedPassword.equals(userModel.getPassword());
    }

    /**
     * Closes the database connection.
     */
    public void close() {
        try {
            if (dbConn != null && !dbConn.isClosed()) {
                dbConn.close();
                System.out.println("[LoginService] Database connection closed");
            }
        } catch (SQLException e) {
            System.err.println("[LoginService] Error closing connection: " + e.getMessage());
        }
    }
}