<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <style>
        :root {
            --caramel-dark: #8b7358;
            --caramel-main: #a38c76;
            --caramel-light: #c9b8a8;
            --caramel-ultra-light: #f9f7f5;
            --caramel-text: #59381F;
            --white: #FFFFFF;
            --gray-100: #F9F9F9;
            --gray-200: #EFEFEF;
            --gray-300: #E4E4E4;
            --gray-400: #D3D3D3;
            --gray-500: #A9A9A9;
            --gray-600: #737373;
            --gray-700: #4D4D4D;
            --gray-800: #333333;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--gray-100);
            color: var(--caramel-text);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            background-image: linear-gradient(135deg, var(--gray-100) 0%, var(--gray-200) 100%);
        }

        .container {
            background-color: var(--white);
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 650px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .form-header {
            background-color: var(--caramel-main);
            color: var(--white);
            padding: 25px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-image: linear-gradient(to right, var(--caramel-dark), var(--caramel-main));
            position: relative;
            overflow: hidden;
        }

        .form-header::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 150px;
            height: 100%;
            background: linear-gradient(to right, transparent, rgba(255, 255, 255, 0.1));
            transform: skewX(-30deg);
        }

        .form-header h1 {
            font-size: 26px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        .form-content {
            padding: 35px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: var(--caramel-text);
            letter-spacing: 0.3px;
            transition: color 0.3s ease;
        }

        .form-group:focus-within label {
            color: var(--caramel-dark);
        }

        .required::after {
            content: " *";
            color: #d9534f;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid var(--gray-300);
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: var(--gray-100);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--caramel-main);
            box-shadow: 0 0 0 3px rgba(163, 140, 118, 0.2);
            background-color: var(--white);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23a38c76' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: calc(100% - 15px) center;
            padding-right: 40px;
        }

        input[type="file"].form-control {
            padding: 12px;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 35px;
        }

        .btn {
            padding: 14px 28px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .btn-back {
            background-color: var(--gray-200);
            color: var(--gray-700);
            position: relative;
            overflow: hidden;
        }

        .btn-back:hover {
            background-color: var(--gray-300);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .btn-submit {
            background-color: var(--caramel-dark);
            color: var(--white);
            position: relative;
            overflow: hidden;
        }

        .btn-submit:hover {
            background-color: var(--caramel-text);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn:active::after {
            width: 300px;
            height: 300px;
        }

        .error-message {
            color: #d9534f;
            margin-top: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .popup-message {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            min-width: 320px;
            max-width: 400px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            z-index: 9999;
            animation: fadeIn 0.5s, fadeOut 0.5s 4.5s;
            overflow: hidden;
        }

        .popup-content {
            display: flex;
            padding: 20px;
            align-items: center;
            position: relative;
        }

        .popup-icon {
            margin-right: 15px;
        }

        .icon-circle {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 24px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .icon-circle.success {
            background: linear-gradient(135deg, #43A047, #4CAF50);
        }

        .icon-circle.error {
            background: linear-gradient(135deg, #e53935, #f44336);
        }

        .checkmark, .exclamation {
            font-size: 24px;
        }

        .popup-text {
            flex: 1;
        }

        .popup-text h3 {
            font-size: 20px;
            margin: 0 0 5px 0;
            color: #333;
        }

        .popup-text p {
            margin: 0;
            color: #666;
            font-size: 16px;
            line-height: 1.4;
        }

        .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: none;
            border: none;
            font-size: 24px;
            color: #999;
            cursor: pointer;
            padding: 0;
            line-height: 1;
            transition: color 0.3s ease;
        }

        .close-btn:hover {
            color: #333;
        }

        /* Success and error specific styling */
        .popup-success {
            border-bottom: 4px solid #4CAF50;
        }

        .popup-error {
            border-bottom: 4px solid #f44336;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translate(-50%, -20px);
            }
            to {
                opacity: 1;
                transform: translate(-50%, 0);
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
                transform: translate(-50%, 0);
            }
            to {
                opacity: 0;
                transform: translate(-50%, -20px);
            }
        }

        /* Form control focus states */
        .form-control:not(:placeholder-shown) {
            border-color: var(--caramel-light);
        }

        /* Image upload styling */
        input[type="file"].form-control {
            padding: 10px;
        }

        input[type="file"].form-control::file-selector-button {
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            background-color: var(--caramel-light);
            color: var(--white);
            font-weight: 500;
            margin-right: 15px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="file"].form-control::file-selector-button:hover {
            background-color: var(--caramel-dark);
        }
    </style>
</head>
<body>
	<jsp:include page="message_handler.jsp"/>
    <div class="container">
        <div class="form-header">
            <h1>Add New Product</h1>
        </div>
        <form class="form-content" action="${pageContext.request.contextPath}/admin/addProduct" method="POST" enctype="multipart/form-data">
          
            
            <div class="form-group">
                <label for="productNumber" class="required">Product Number</label>
                <input type="text" id="productNumber" name="productNumber" class="form-control" placeholder="Enter product number" required>
            </div>
            
            <div class="form-group">
                <label for="productName" class="required">Product Name</label>
                <input type="text" id="productName" name="productName" class="form-control" placeholder="Enter product name" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="form-control" placeholder="Enter product description"></textarea>
            </div>
            
            <div class="form-group">
                <label for="category" class="required">Category</label>
                <select id="category" name="category" class="form-control" required>
                    <option value="" disabled selected>Select category</option>
                    <option value="Luxury">Luxury</option>
                    <option value="Sport">Sport</option>
                    <option value="Casual">Casual</option>
                    <option value="Smart Watch">Smart Watch</option>
                    <option value="Classic">Classic</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="unitPrice" class="required">Unit Price</label>
                <input type="number" id="unitPrice" name="unitPrice" class="form-control" placeholder="Enter unit price" step="0.01" min="0" required>
            </div>
            
            <div class="form-group">
                <label for="productImage" class="required">Product Image:</label>
                <input type="file" id="productImage" name="productImage" class="form-control" accept="image/*" required>
            </div>
            
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/dashboard/products" class="btn btn-back">Back</a>
                <button type="submit" class="btn btn-submit">Add Product</button>
            </div>
        </form>
    </div>

    <script>
    function showNotification(message, type) {
        const popup = document.createElement('div');
        popup.className = 'popup-message popup-' + type;
        
        const icon = type === 'success' ? '✓' : '!';
        const title = type === 'success' ? 'Success!' : 'Error!';
        const iconClass = type === 'success' ? 'checkmark' : 'exclamation';
        
        popup.innerHTML = 
            '<div class="popup-content">' +
                '<div class="popup-icon">' +
                    '<div class="icon-circle ' + type + '">' +
                        '<span class="' + iconClass + '">' + icon + '</span>' +
                    '</div>' +
                '</div>' +
                '<div class="popup-text">' +
                    '<h3>' + title + '</h3>' +
                    '<p>' + message + '</p>' +
                '</div>' +
                '<button class="close-btn" onclick="this.parentElement.parentElement.remove()">&times;</button>' +
            '</div>';
            
        document.body.appendChild(popup);
        setTimeout(() => {
            popup.style.opacity = '0';
            setTimeout(() => popup.remove(), 300);
        }, 5000);
    }

    // Check for messages on page load
    document.addEventListener('DOMContentLoaded', function() {
        const successMessage = "${sessionScope.successMessage}";
        const errorMessage = "${sessionScope.errorMessage}";
        
        if (successMessage && successMessage !== "") {
            showNotification(successMessage, 'success');
            <% session.removeAttribute("successMessage"); %>
        }
        
        if (errorMessage && errorMessage !== "") {
            showNotification(errorMessage, 'error');
            <% session.removeAttribute("errorMessage"); %>
        }

        // Add subtle animation to form fields when focused
        const formControls = document.querySelectorAll('.form-control');
        formControls.forEach(control => {
            control.addEventListener('focus', function() {
                this.parentElement.classList.add('active');
            });
            
            control.addEventListener('blur', function() {
                this.parentElement.classList.remove('active');
            });
        });
    });
    </script>
</body>
</html>