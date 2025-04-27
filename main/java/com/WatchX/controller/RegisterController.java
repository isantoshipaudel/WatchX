package com.WatchX.controller;

import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.WatchX.model.UserModel;
import com.WatchX.service.RegisterService;
import com.WatchX.util.PasswordUtil;
import com.WatchX.util.ValidationUtil;

/**
 * RegisterController handles user registration requests for WatchX and processes form
 * submissions for new account creation.
 */
@WebServlet(urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final RegisterService registerService = new RegisterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Validate and extract user model
            String validationMessage = validateRegistrationForm(req);
            if (validationMessage != null) {
                handleError(req, resp, validationMessage);
                return;
            }

            UserModel userModel = extractUserModel(req);
            Boolean isAdded = registerService.addUser(userModel);

            if (isAdded == null) {
                handleError(req, resp, "Our server is under maintenance. Please try again later!");
            } else if (isAdded) {
                handleSuccess(req, resp, "Your account has been successfully created!", "/WEB-INF/pages/login.jsp");
            } else {
                handleError(req, resp, "Could not register your account. Please try again later!");
            }
        } catch (Exception e) {
            handleError(req, resp, "An unexpected error occurred. Please try again later!");
            e.printStackTrace(); // Log the exception
        }
    }

    private String validateRegistrationForm(HttpServletRequest req) {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String contact = req.getParameter("contact");
        String address = req.getParameter("address");
        String password = req.getParameter("password");

        // Check for null or empty fields first
        if (ValidationUtil.isNullOrEmpty(firstName))
            return "First name is required.";
        if (ValidationUtil.isNullOrEmpty(lastName))
            return "Last name is required.";
        if (ValidationUtil.isNullOrEmpty(username))
            return "Username is required.";
        if (ValidationUtil.isNullOrEmpty(email))
            return "Email is required.";
        if (ValidationUtil.isNullOrEmpty(contact))
            return "Contact number is required.";
        if (ValidationUtil.isNullOrEmpty(address))
            return "Address is required.";
        if (ValidationUtil.isNullOrEmpty(password))
            return "Password is required.";

        // Validate fields
        if (!ValidationUtil.isAlphanumericStartingWithLetter(username))
            return "Username must start with a letter and contain only letters and numbers.";
        if (!ValidationUtil.isValidEmail(email))
            return "Invalid email format.";
        if (!ValidationUtil.isValidPhoneNumber(contact))
            return "Phone number must be 10 digits and start with 98.";
        if (!ValidationUtil.isValidPassword(password))
            return "Password must be at least 8 characters long, with 1 uppercase letter, 1 number, and 1 symbol.";

        return null; // All validations passed
    }

    private UserModel extractUserModel(HttpServletRequest req) throws Exception {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String contact = req.getParameter("contact");
        String address = req.getParameter("address");
        String password = req.getParameter("password");

        // Encrypt password before storing
        password = PasswordUtil.encrypt(username, password);

        return new UserModel(firstName, lastName, username, email, contact, address, password);
    }

    private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectPage)
            throws ServletException, IOException {
        req.setAttribute("success", message);
        req.getRequestDispatcher(redirectPage).forward(req, resp);
    }

    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.setAttribute("firstName", req.getParameter("firstName"));
        req.setAttribute("lastName", req.getParameter("lastName"));
        req.setAttribute("username", req.getParameter("username"));
        req.setAttribute("email", req.getParameter("email"));
        req.setAttribute("contact", req.getParameter("contact"));
        req.setAttribute("address", req.getParameter("address"));
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }
}