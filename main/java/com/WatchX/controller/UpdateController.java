package com.WatchX.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.WatchX.model.UserModel;
import com.WatchX.service.UpdateService;
import com.WatchX.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update")
public class UpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UpdateService updateService = new UpdateService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Set response content type first
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        
        try {
            System.out.println("\n===== [UpdateController] doGet() START =====");
            
            // 1. Verify user session
            String username = SessionUtil.getLoggedInUsername(req);
            if (username == null || username.isEmpty()) {
                System.out.println("[ERROR] No active user session found");
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            System.out.println("[DEBUG] Current session username: " + username);

            // 2. Fetch user data
            System.out.println("[DEBUG] Attempting to fetch user from database...");
            UserModel dbUser = updateService.getUserByUsername(username);
            
            if (dbUser == null) {
                System.out.println("[ERROR] User not found in database for username: " + username);
                req.setAttribute("error", "User profile not found");
                updateService.debugListAllUsernames();
            } else {
                System.out.println("[SUCCESS] Retrieved user data:");
                System.out.println(" - Name: " + dbUser.getFirstName() + " " + dbUser.getLastName());
                System.out.println(" - Email: " + dbUser.getEmail());
                System.out.println(" - Contact: " + dbUser.getContactNumber());
                
                req.setAttribute("user", dbUser);
            }

            // 3. Forward to JSP
            System.out.println("[DEBUG] Forwarding to Update.jsp");
            String jspPath = "/WEB-INF/pages/Update.jsp";
            System.out.println("[DEBUG] JSP Path: " + 
                getServletContext().getRealPath(jspPath));
            
            req.getRequestDispatcher(jspPath).forward(req, resp);
            
        } catch (Exception e) {
            System.err.println("[CRITICAL ERROR] in doGet(): " + e.getMessage());
            e.printStackTrace();
            out.println("<h3>System Error</h3>");
            out.println("<p>We encountered an error loading your profile.</p>");
            out.println("<p>Error details: " + e.getMessage() + "</p>");
        } finally {
            System.out.println("===== [UpdateController] doGet() END =====");
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession();
        
        try {
            System.out.println("\n===== [UpdateController] doPost() START =====");
            
            // 1. Verify session
            String currentUsername = SessionUtil.getLoggedInUsername(req);
            if (currentUsername == null || currentUsername.isEmpty()) {
                System.out.println("[ERROR] No active session for update");
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            System.out.println("[DEBUG] Updating profile for: " + currentUsername);

            // 2. Get form parameters
            String firstName = req.getParameter("firstName").trim();
            String lastName = req.getParameter("lastName").trim();
            String email = req.getParameter("Email").trim();
            String contactNo = req.getParameter("contactNo").trim();
            String address = req.getParameter("address").trim();
            String username = req.getParameter("username").trim();
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            // 3. Validate all inputs
            StringBuilder errorMessage = new StringBuilder();

            // Validate first name
            if (firstName.isEmpty()) {
                errorMessage.append("First name is required. ");
            } else if (firstName.matches(".*\\d+.*")) {
                errorMessage.append("First name should not contain numbers. ");
            }

            // Validate last name
            if (lastName.isEmpty()) {
                errorMessage.append("Last name is required. ");
            } else if (lastName.matches(".*\\d+.*")) {
                errorMessage.append("Last name should not contain numbers. ");
            }

            // Validate email
            if (email.isEmpty()) {
                errorMessage.append("Email is required. ");
            } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                errorMessage.append("Invalid email format. ");
            }

            // Validate contact number
            if (contactNo.isEmpty()) {
                errorMessage.append("Contact number is required. ");
            } else if (!contactNo.matches("\\d{10}")) {
                errorMessage.append("Contact number must be exactly 10 digits. ");
            }

            // Validate username
            if (username.isEmpty()) {
                errorMessage.append("Username is required. ");
            }

            // Validate password if being updated
            if (newPassword != null && !newPassword.isEmpty()) {
                if (!newPassword.equals(confirmPassword)) {
                    errorMessage.append("Password and confirmation do not match. ");
                } else if (newPassword.length() < 6) {
                    errorMessage.append("Password must be at least 6 characters long. ");
                }
            }

            // If there are validation errors, return to the form
            if (errorMessage.length() > 0) {
                System.out.println("[ERROR] Validation failed: " + errorMessage.toString());
                
                // Create user model to preserve form data
                UserModel formData = new UserModel();
                formData.setUserName(username);
                formData.setFirstName(firstName);
                formData.setLastName(lastName);
                formData.setEmail(email);
                formData.setContactNumber(contactNo);
                formData.setAddress(address);
                
                req.setAttribute("user", formData);
                session.setAttribute("errorMessage", errorMessage.toString().trim());
                req.getRequestDispatcher("/WEB-INF/pages/Update.jsp").forward(req, resp);
                return;
            }

            // 4. Create updated user model
            UserModel updatedUser = new UserModel();
            updatedUser.setUserName(username);
            updatedUser.setFirstName(firstName);
            updatedUser.setLastName(lastName);
            updatedUser.setEmail(email);
            updatedUser.setContactNumber(contactNo);
            updatedUser.setAddress(address);
            
            // Set password if it's being updated
            if (newPassword != null && !newPassword.isEmpty()) {
                updatedUser.setPassword(newPassword);
                System.out.println("[DEBUG] Password will be updated");
            }

            System.out.println("[DEBUG] New profile data:");
            System.out.println(" - Username: " + updatedUser.getUserName());
            System.out.println(" - Email: " + updatedUser.getEmail());
            System.out.println(" - Contact: " + updatedUser.getContactNumber());

            // 5. Perform update
            System.out.println("[DEBUG] Attempting profile update...");
            Boolean result = updateService.updateCustomerInfo(updatedUser, currentUsername);

            if (Boolean.TRUE.equals(result)) {
                System.out.println("[SUCCESS] Profile updated successfully");
                
                // Update session if username changed
                if (!currentUsername.equals(updatedUser.getUserName())) {
                    SessionUtil.setAttribute(req, "username", updatedUser.getUserName());
                    System.out.println("[DEBUG] Updated session username to: " + updatedUser.getUserName());
                }
                
                // Set success message in session
                session.setAttribute("successMessage", "Profile updated successfully!");
                
                // Redirect to home page
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            } else {
                System.out.println("[ERROR] Profile update failed");
                req.setAttribute("user", updatedUser);
                session.setAttribute("errorMessage", "Update failed. Please try again.");
                req.getRequestDispatcher("/WEB-INF/pages/Update.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            System.err.println("[CRITICAL ERROR] in doPost(): " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "System error occurred. Please try again later.");
            resp.sendRedirect(req.getContextPath() + "/update");
        } finally {
            System.out.println("===== [UpdateController] doPost() END =====");
            out.close();
        }
    }
}