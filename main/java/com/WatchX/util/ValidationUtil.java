package com.WatchX.util;

import java.util.regex.Pattern;

public class ValidationUtil {
	  // 1. Validate if a field is null or empty
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    // 2. Validate if a string contains only letters
    public static boolean isAlphabetic(String value) {
        return value != null && value.matches("^[a-zA-Z]+$");
    }

    // 3. Validate if a string starts with a letter and is composed of letters and numbers
    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }
    // 1. Validate name fields (2-50 chars, letters, spaces, and hyphens)
    public static boolean isValidName(String name) {
        return name != null && name.matches("^[a-zA-Z\\s-]{2,50}$");
    }

    // 2. Validate username (4-20 chars, alphanumeric + underscore)
    public static boolean isValidUsername(String username) {
        return username != null && username.matches("^[a-zA-Z0-9_]{4,20}$");
    }

    // 3. Validate email address
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    // 4. Validate phone number (Nepali format: 98XXXXXXXX)
    public static boolean isValidPhoneNumber(String number) {
        return number != null && number.matches("^98\\d{8}$");
    }

    // 5. Validate address (5-100 chars, allows letters, numbers, spaces, and basic punctuation)
    public static boolean isValidAddress(String address) {
        return address != null && address.matches("^[a-zA-Z0-9\\s.,-]{5,100}$");
    }

    // 6. Validate password (8+ chars, 1 uppercase, 1 lowercase, 1 number)
    public static boolean isValidPassword(String password) {
        return password != null && password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$");
    }

    // 7. Validate if password and retype password match
    public static boolean doPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    // 8. Validate all registration fields at once
    public static String validateRegistration(
        String firstName, 
        String lastName,
        String username,
        String email,
        String contact,
        String address,
        String password,
        String retypePassword
    ) {
        if (!isValidName(firstName)) {
            return "First name must be 2-50 letters (with spaces or hyphens)";
        }
        
        if (!isValidName(lastName)) {
            return "Last name must be 2-50 letters (with spaces or hyphens)";
        }
        
        if (!isValidUsername(username)) {
            return "Username must be 4-20 characters (letters, numbers, underscores)";
        }
        
        if (!isValidEmail(email)) {
            return "Please enter a valid email address";
        }
        
        if (!isValidPhoneNumber(contact)) {
            return "Phone number must start with 98 and be 10 digits total";
        }
        
        if (!isValidAddress(address)) {
            return "Address must be 5-100 characters";
        }
        
        if (!isValidPassword(password)) {
            return "Password must be 8+ chars with 1 uppercase, 1 lowercase, and 1 number";
        }
        
        return null; // No errors
    }
}