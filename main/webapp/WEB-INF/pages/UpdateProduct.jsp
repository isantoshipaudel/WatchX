<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
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
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--caramel-ultra-light);
            color: var(--caramel-text);
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--white);
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: var(--caramel-dark);
            margin-bottom: 1.5rem;
            text-align: center;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--caramel-dark);
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--caramel-light);
            border-radius: 4px;
            background-color: var(--gray-100);
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: var(--caramel-main);
            box-shadow: 0 0 0 3px rgba(163, 140, 118, 0.2);
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .image-preview {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid var(--caramel-light);
            margin-bottom: 1rem;
            display: block;
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
        }

        .btn-primary {
            background-color: var(--caramel-main);
            color: var(--white);
        }

        .btn-primary:hover {
            background-color: var(--caramel-dark);
        }

        .btn-secondary {
            background-color: var(--gray-400);
            color: var(--gray-800);
        }

        .btn-secondary:hover {
            background-color: var(--gray-500);
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 4px;
        }

        .alert-success {
            background-color: rgba(40, 167, 69, 0.1);
            color: var(--success);
            border: 1px solid var(--success);
        }

        .alert-danger {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            border: 1px solid var(--danger);
        }

        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            margin-bottom: 1rem;
        }

        .file-input-wrapper input[type="file"] {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }

        .file-input-label {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: var(--gray-200);
            color: var(--gray-800);
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .file-input-label:hover {
            background-color: var(--gray-300);
        }
        .error { color: red; }
        .success { color: green; }
        .image-preview {
            max-width: 200px;
            max-height: 200px;
            margin: 10px 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: inline-block;
            width: 120px;
        }
    </style>
</head>
<body>
    <h1>Update Product</h1>
    
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/admin/updateProduct" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productNo" value="${product.productNo}">
        
        <div class="form-group">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" value="${product.productName}" required>
        </div>
        
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea id="description" name="description" required>${product.description}</textarea>
        </div>
        
        <div class="form-group">
            <label for="category">Category:</label>
            <input type="text" id="category" name="category" value="${product.category}" required>
        </div>
        
        <div class="form-group">
            <label for="unitPrice">Unit Price:</label>
            <input type="text" id="unitPrice" name="unitPrice" value="${product.unitPrice}" required>
        </div>
        
        <div class="form-group">
            <label for="productImage">Product Image:</label>
            <input type="file" id="productImage" name="productImage" accept="image/*">
            
            <c:if test="${not empty product.image_path}">
                <div class="image-preview">
                    <img src="${pageContext.request.contextPath}/${product.image_path}" 
                         alt="Current Product Image">
                    <p>Current Image</p>
                </div>
            </c:if>
        </div>
        
        <div class="form-group">
            <button type="submit">Update Product</button>
            <a href="${pageContext.request.contextPath}/admin/dashboard/products">Cancel</a>
        </div>
    </form>
</body>
</html>