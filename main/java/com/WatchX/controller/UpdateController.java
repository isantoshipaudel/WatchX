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
                // Debug: List all available usernames
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

            // 2. Prepare updated user data
            UserModel updatedUser = new UserModel();
            updatedUser.setUserName(req.getParameter("username"));
            updatedUser.setFirstName(req.getParameter("firstName"));
            updatedUser.setLastName(req.getParameter("lastName"));
            updatedUser.setEmail(req.getParameter("Email"));
            updatedUser.setContactNumber(req.getParameter("contactNo"));
            updatedUser.setAddress(req.getParameter("address"));

            // Add password update handling
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");
            
            if (newPassword != null && !newPassword.isEmpty()) {
                if (newPassword.equals(confirmPassword)) {
                    updatedUser.setPassword(newPassword);
                    System.out.println("[DEBUG] Password will be updated");
                } else {
                    System.out.println("[ERROR] Password confirmation mismatch");
                    req.setAttribute("user", updatedUser);
                    req.setAttribute("error", "Password and confirmation do not match");
                    req.getRequestDispatcher("/WEB-INF/pages/Update.jsp").forward(req, resp);
                    return;
                }
            }

            System.out.println("[DEBUG] New profile data:");
            System.out.println(" - Username: " + updatedUser.getUserName());
            System.out.println(" - Email: " + updatedUser.getEmail());
            System.out.println(" - Contact: " + updatedUser.getContactNumber());

            // 3. Perform update
            System.out.println("[DEBUG] Attempting profile update...");
            Boolean result = updateService.updateCustomerInfo(updatedUser, currentUsername);

            if (Boolean.TRUE.equals(result)) {
                System.out.println("[SUCCESS] Profile updated successfully");
                
                // Update session if username changed
                if (!currentUsername.equals(updatedUser.getUserName())) {
                    SessionUtil.setAttribute(req, "username", updatedUser.getUserName());
                    System.out.println("[DEBUG] Updated session username to: " + updatedUser.getUserName());
                }
                
                SessionUtil.setAttribute(req, "message", "Profile updated successfully!");
                resp.sendRedirect(req.getContextPath() + "/update");
            } else {
                System.out.println("[ERROR] Profile update failed");
                req.setAttribute("user", updatedUser);
                req.setAttribute("error", "Update failed. Please check your information.");
                req.getRequestDispatcher("/WEB-INF/pages/Update.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            System.err.println("[CRITICAL ERROR] in doPost(): " + e.getMessage());
            e.printStackTrace();
            out.println("<h3>System Error During Update</h3>");
            out.println("<p>We encountered an error updating your profile.</p>");
            out.println("<p>Error details: " + e.getMessage() + "</p>");
        } finally {
            System.out.println("===== [UpdateController] doPost() END =====");
            out.close();
        }
    }
}