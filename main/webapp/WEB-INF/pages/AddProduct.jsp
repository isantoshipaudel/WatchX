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
        }

        .container {
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 650px;
            overflow: hidden;
        }

        .form-header {
            background-color: var(--caramel-main);
            color: var(--white);
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-header h1 {
            font-size: 24px;
            font-weight: 600;
        }

        .form-content {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--caramel-text);
        }

        .required::after {
            content: " *";
            color: #d9534f;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--gray-300);
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--caramel-main);
            box-shadow: 0 0 0 3px rgba(163, 140, 118, 0.2);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-back {
            background-color: var(--gray-300);
            color: var(--gray-700);
        }

        .btn-back:hover {
            background-color: var(--gray-400);
        }

        .btn-submit {
            background-color: var(--caramel-dark);
            color: var(--white);
        }

        .btn-submit:hover {
            background-color: var(--caramel-text);
        }

        .error-message {
            color: #d9534f;
            margin-top: 5px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-header">
            <h1>Add New Product</h1>
        </div>
        <form class="form-content" action="${pageContext.request.contextPath}/admin/addProduct" method="POST" enctype="multipart/form-data">
            <%-- Error message display --%>
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <div class="form-group">
                <label for="productNumber">Product Number</label>
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
</body>
</html>