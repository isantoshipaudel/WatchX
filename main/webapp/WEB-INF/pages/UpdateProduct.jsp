<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        
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
            --primary: #8b7358;
            --primary-light: #a18b73;
            --primary-dark: #6a563e;
            --secondary: #8b7358;
            --text-primary: #212121;
            --text-secondary: #616161;
            --bg-light: #f5f7fa;
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.08);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.12);
            --shadow-lg: 0 12px 32px rgba(0, 0, 0, 0.14);
            --radius-sm: 8px;
            --radius-md: 16px;
            --radius-lg: 24px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: var(--bg-light);
            color: var(--text-primary);
            min-height: 100vh;
            background-image: linear-gradient(135deg, #f5f7fa 0%, #e8edf5 100%);
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }

        /* Scrollbar styling */
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        
        ::-webkit-scrollbar-track {
            background: rgba(139, 115, 88, 0.05);
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: rgba(139, 115, 88, 0.2);
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: rgba(139, 115, 88, 0.4);
        }
        
        /* Main content - full width */
        .main-content {
            width: 100%;
            max-width: 900px;
            padding: 30px 20px;
            transition: var(--transition);
            animation: fadeIn 0.6s ease;
        }
        
        /* Header with logo */
        .header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            justify-content: space-between;
        }
        
        .logo {
            font-size: 26px;
            font-weight: 700;
            letter-spacing: 2px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            color: var(--primary-dark);
            position: relative;
        }
        
        .logo::before {
            content: "\f017"; /* Watch icon */
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-right: 12px;
            font-size: 28px;
            color: var(--secondary);
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
        }
        
        /* Form Container */
        .form-container {
            background: var(--white);
            border-radius: var(--radius-md);
            padding: 40px;
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
            border-left: 5px solid var(--primary);
            margin-bottom: 30px;
        }
        
        .form-container::after {
            content: '';
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(139, 115, 88, 0.05) 0%, rgba(139, 115, 88, 0.01) 100%);
            top: -100px;
            right: -50px;
            z-index: 0;
        }
        
        .form-container::before {
            content: '';
            position: absolute;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(94, 53, 177, 0.05) 0%, rgba(94, 53, 177, 0.01) 100%);
            bottom: -70px;
            left: 30%;
            z-index: 0;
        }
        
        h1 {
            color: var(--primary-dark);
            margin-bottom: 30px;
            position: relative;
            padding-left: 20px;
            font-weight: 600;
            font-size: 24px;
        }
        
        h1:before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            height: 24px;
            width: 5px;
            background: linear-gradient(to bottom, var(--primary) 0%, var(--primary-dark) 100%);
            border-radius: 10px;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
            z-index: 1;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: var(--primary-dark);
            font-size: 15px;
        }
        
        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-sm);
            background-color: var(--gray-100);
            transition: var(--transition);
            font-size: 15px;
            color: var(--text-primary);
        }
        
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: var(--caramel-main);
            box-shadow: 0 0 0 3px rgba(163, 140, 118, 0.2);
            background-color: var(--white);
        }
        
        input[type="text"]::placeholder,
        input[type="number"]::placeholder,
        textarea::placeholder {
            color: var(--gray-500);
        }
        
        textarea {
            min-height: 120px;
            resize: vertical;
            line-height: 1.6;
        }
        
        /* File Input Styling */
        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            cursor: pointer;
            margin-bottom: 10px;
        }
        
        .file-input-wrapper input[type="file"] {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
            width: 100%;
            height: 100%;
        }
        
        .file-input-label {
            display: inline-flex;
            align-items: center;
            padding: 12px 20px;
            background: linear-gradient(135deg, var(--caramel-light) 0%, var(--caramel-main) 100%);
            color: var(--white);
            border-radius: var(--radius-sm);
            font-weight: 500;
            transition: var(--transition);
            gap: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .file-input-label:hover {
            background: linear-gradient(135deg, var(--caramel-main) 0%, var(--caramel-dark) 100%);
            transform: translateY(-2px);
        }
        
        /* Image Preview */
        .image-preview-container {
            margin: 20px 0;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        
        .image-preview {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: var(--radius-sm);
            border: 2px solid var(--caramel-light);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: var(--transition);
            margin-bottom: 10px;
            background-color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        
        .image-preview-label {
            font-size: 14px;
            color: var(--text-secondary);
            font-weight: 500;
            margin-top: 8px;
        }
        
        /* Buttons */
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 15px;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-width: 120px;
            text-decoration: none;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--caramel-main) 0%, var(--caramel-dark) 100%);
            color: var(--white);
            box-shadow: 0 4px 10px rgba(139, 115, 88, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(139, 115, 88, 0.4);
        }
        
        .btn-secondary {
            background-color: var(--gray-200);
            color: var(--gray-700);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }
        
        .btn-secondary:hover {
            background-color: var(--gray-300);
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn i {
            font-size: 16px;
        }
        
        /* Error message */
        .error {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            padding: 12px 20px;
            border-radius: var(--radius-sm);
            margin-bottom: 25px;
            font-weight: 500;
            border-left: 4px solid var(--danger);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .error::before {
            content: '\f071';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 16px;
        }
        
        /* Success message */
        .success {
            background-color: rgba(40, 167, 69, 0.1);
            color: var(--success);
            padding: 12px 20px;
            border-radius: var(--radius-sm);
            margin-bottom: 25px;
            font-weight: 500;
            border-left: 4px solid var(--success);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .success::before {
            content: '\f058';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 16px;
        }
        
        /* Popup message styling */
        .popup-message {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            min-width: 320px;
            max-width: 400px;
            background-color: var(--white);
            border-radius: var(--radius-sm);
            box-shadow: var(--shadow-md);
            z-index: 9999;
            animation: fadeInDown 0.5s, fadeOutUp 0.5s 4.5s;
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
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .icon-circle.success {
            background: linear-gradient(135deg, #4CAF50 0%, #388E3C 100%);
        }
        
        .icon-circle.error {
            background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
        }
        
        .checkmark, .exclamation {
            font-size: 24px;
        }
        
        .popup-text {
            flex: 1;
        }
        
        .popup-text h3 {
            font-size: 18px;
            margin: 0 0 5px 0;
            color: var(--text-primary);
            font-weight: 600;
        }
        
        .popup-text p {
            margin: 0;
            color: var(--text-secondary);
            font-size: 14px;
        }
        
        .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: none;
            border: none;
            font-size: 20px;
            color: var(--text-secondary);
            cursor: pointer;
            padding: 0;
            line-height: 1;
            transition: var(--transition);
        }
        
        .close-btn:hover {
            color: var(--text-primary);
            transform: scale(1.1);
        }
        
        /* Success and error specific styling */
        .popup-success {
            border-left: 4px solid #4CAF50;
        }
        
        .popup-error {
            border-left: 4px solid #f44336;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes fadeInDown {
            from { opacity: 0; transform: translate(-50%, -20px); }
            to { opacity: 1; transform: translate(-50%, 0); }
        }
        
        @keyframes fadeOutUp {
            from { opacity: 1; transform: translate(-50%, 0); }
            to { opacity: 0; transform: translate(-50%, -20px); }
        }
        
        /* Navigation buttons */
        .nav-buttons {
            display: flex;
            gap: 15px;
        }
        
        .nav-button {
            background-color: var(--white);
            color: var(--primary-dark);
            padding: 10px 15px;
            border-radius: var(--radius-sm);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            font-size: 14px;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }
        
        .nav-button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            color: var(--primary);
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .form-container {
                padding: 25px 20px;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
            
            .header {
                flex-direction: column;
                gap: 15px;
            }
            
            .nav-buttons {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="message_handler.jsp"/>
    <div class="main-content">
        <div class="header">
            <div class="logo">WatchX</div>
            <div class="nav-buttons">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-button">
                    <i class="fas fa-chart-pie"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/dashboard/products" class="nav-button">
                    <i class="fas fa-clock"></i> Products
                </a>
            </div>
        </div>
        
        <div class="form-container">
            <h1>Update Product</h1>
            
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/admin/updateProduct" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productNo" value="${product.productNo}">
                
                <div class="form-group">
                    <label for="productName">Product Name</label>
                    <input type="text" id="productName" name="productName" value="${product.productName}" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" required>${product.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="category">Category</label>
                    <input type="text" id="category" name="category" value="${product.category}" required>
                </div>
                
                <div class="form-group">
                    <label for="unitPrice">Unit Price</label>
                    <input type="text" id="unitPrice" name="unitPrice" value="${product.unitPrice}" required>
                </div>
                
                <div class="form-group">
                    <label for="productImage">Product Image</label>
                    <div class="file-input-wrapper">
                        <label class="file-input-label">
                            <i class="fas fa-upload"></i> Choose Image
                            <input type="file" id="productImage" name="productImage" accept="image/*">
                        </label>
                    </div>
                    <span class="file-name" id="file-name"></span>
                    
                    <c:if test="${not empty product.image_path}">
                        <div class="image-preview-container">
                            <div class="image-preview">
                                <img src="${pageContext.request.contextPath}/${product.image_path}" 
                                     alt="Current Product Image">
                            </div>
                            <span class="image-preview-label">Current Image</span>
                        </div>
                    </c:if>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Product
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/dashboard/products" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Show filename when file is selected
        document.getElementById('productImage').addEventListener('change', function() {
            const fileName = this.files[0]?.name || 'No file selected';
            document.getElementById('file-name').textContent = fileName;
        });
        
    </script>
</body>
</html>