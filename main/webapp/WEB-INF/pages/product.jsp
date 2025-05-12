<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
HttpSession userSession = request.getSession(false);
String currentUser = (String) (userSession != null ? userSession.getAttribute("username") : null);
pageContext.setAttribute("currentUser", currentUser);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Management | WatchX</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
      font-family: 'Inter', 'Helvetica Neue', Arial, sans-serif;
    }
    
    body {
      background-color: var(--gray-100);
      color: var(--gray-800);
      min-height: 100vh;
      display: flex;
      line-height: 1.6;
    }
    .nav-menu li a {
      color: inherit;
      text-decoration: none;
      display: flex;
      align-items: center;
      width: 100%;
    }
    
    .nav-menu li a:hover {
      color: inherit;
    }
    
    .user-profile-link {
      color: inherit;
      text-decoration: none;
    }
    
    .user-profile-link:hover {
      color: inherit;
    }
    
    .main-content a {
      color: inherit;
      text-decoration: none;
    }
    
    .main-content a:hover {
      color: inherit;
    }
    
    .nav-menu li.active a {
      color: inherit;
    }
    /* Sidebar Navigation - Enhanced */
    .sidebar {
      background-color: var(--caramel-ultra-light);
      color: var(--caramel-text);
      width: 280px;
      height: 100vh;
      position: fixed;
      top: 0;
      left: 0;
      box-shadow: 4px 0 20px rgba(0, 0, 0, 0.08);
      display: flex;
      flex-direction: column;
      z-index: 1000;
      padding: 30px 0;
      transition: all 0.3s ease;
    }
    
    .logo {
      font-size: 24px;
      font-weight: 700;
      letter-spacing: 1px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px 30px;
      margin-bottom: 20px;
      border-bottom: 1px solid rgba(139, 115, 88, 0.1);
      color: var(--caramel-dark);
    }
    
    .logo i {
      margin-right: 12px;
      font-size: 22px;
      color: var(--caramel-dark);
    }
    
    .nav-menu {
      display: flex;
      flex-direction: column;
      list-style: none;
      gap: 8px;
      margin: 0;
      padding: 20px;
      flex-grow: 1;
    }
    
    .nav-menu li {
      padding: 14px 20px;
      cursor: pointer;
      transition: all 0.3s;
      border-radius: 10px;
      font-size: 15px;
      display: flex;
      align-items: center;
    }
    
    .nav-menu li.active {
      background-color: rgba(139, 115, 88, 0.15);
      color: var(--caramel-dark);
      font-weight: 600;
      box-shadow: 0 2px 8px rgba(139, 115, 88, 0.1);
    }
    
    .nav-menu li:hover:not(.active) {
      background-color: rgba(139, 115, 88, 0.08);
    }
    
    .nav-menu li i {
      margin-right: 12px;
      font-size: 16px;
      width: 20px;
      text-align: center;
    }
    
    .user-avatar {
      padding: 20px;
      border-top: 1px solid rgba(139, 115, 88, 0.1);
      display: flex;
      flex-direction: column;
      gap: 12px;
    }
    
    .avatar-container {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    
    .avatar {
      width: 42px;
      height: 42px;
      background-color: rgba(139, 115, 88, 0.1);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      font-size: 16px;
      color: var(--caramel-dark);
      border: 1px solid rgba(139, 115, 88, 0.2);
    }
    
    .avatar-name {
      font-weight: 500;
      font-size: 14px;
      color: var(--caramel-text);
    }
    
    .logout-btn {
      background-color: rgba(139, 115, 88, 0.1);
      border: none;
      color: var(--caramel-dark);
      padding: 10px 20px;
      border-radius: 20px;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 10px;
      transition: all 0.3s;
      font-size: 14px;
      width: 100%;
      justify-content: center;
      margin-top: 10px;
    }
    
    .logout-btn:hover {
      background-color: rgba(139, 115, 88, 0.2);
    }
    
    /* Main Content - Enhanced */
    .main-content {
      padding: 30px;
      margin-left: 280px;
      width: calc(100% - 280px);
      transition: margin-left 0.3s ease;
    }
    
    /* Page Header - Enhanced */
    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 25px;
      background-color: var(--white);
      border-radius: 12px;
      padding: 18px 25px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
      border-left: 4px solid var(--caramel-dark);
    }
    
    .page-header h1 {
      font-size: 22px;
      color: var(--caramel-text);
      font-weight: 600;
    }
    
    .header-icon {
      width: 44px;
      height: 44px;
      background-color: rgba(139, 115, 88, 0.1);
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      color: var(--caramel-dark);
    }
    
    /* Action Bar - Enhanced */
    .action-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      background-color: var(--white);
      border-radius: 12px;
      padding: 16px 20px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }
    
    .search-container {
      position: relative;
      width: 300px;
    }
    
    .search-container input {
      width: 100%;
      padding: 10px 15px 10px 38px;
      border: 1px solid var(--gray-300);
      border-radius: 20px;
      transition: all 0.3s;
      font-size: 14px;
      background-color: var(--gray-100);
    }
    
    .search-container input:focus {
      border-color: var(--caramel-main);
      box-shadow: 0 0 0 2px rgba(139, 115, 88, 0.15);
      outline: none;
      background-color: var(--white);
    }
    
    .search-icon {
      position: absolute;
      left: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--gray-500);
      font-size: 14px;
    }
    
    /* Buttons - Enhanced */
    .btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      padding: 10px 18px;
      font-weight: 500;
      border: none;
      font-size: 14px;
      border-radius: 20px;
      transition: all 0.2s ease;
      cursor: pointer;
      gap: 8px;
    }
    
    .btn-primary {
      background-color: var(--caramel-dark);
      color: var(--white);
    }
    
    .btn-primary:hover {
      background-color: #7a6248;
      transform: translateY(-1px);
      box-shadow: 0 3px 8px rgba(139, 115, 88, 0.2);
    }
    
    /* Table Styling - Enhanced */
    .table-container {
      overflow-x: auto;
      border-radius: 12px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
      background-color: var(--white);
    }
    
    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      min-width: 800px;
    }
    
    thead {
      background-color: var(--caramel-light);
      color: var(--caramel-text);
      position: sticky;
      top: 0;
    }
    
    th, td {
      padding: 14px 18px;
      text-align: left;
      border-bottom: 1px solid var(--gray-200);
    }
    
    th {
      font-weight: 600;
      font-size: 13px;
      letter-spacing: 0.3px;
      text-transform: uppercase;
    }
    
    tbody tr {
      transition: background-color 0.2s ease;
    }
    
    tbody tr:last-child td {
      border-bottom: none;
    }
    
    tbody tr:hover {
      background-color: var(--caramel-ultra-light);
    }
    
    /* Product Image - Enhanced */
    .product-image {
      width: 50px;
      height: 50px;
      border-radius: 8px;
      overflow: hidden;
      background-color: var(--gray-200);
      display: flex;
      align-items: center;
      justify-content: center;
      border: 1px solid var(--gray-300);
    }
    
    .product-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    
    .product-info {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    
    .product-name {
      font-weight: 600;
      color: var(--caramel-text);
      margin-bottom: 2px;
      font-size: 15px;
    }
    
    .product-description {
      font-size: 13px;
      color: var(--gray-600);
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
      text-overflow: ellipsis;
      line-height: 1.4;
    }
    
    /* Category Badge - Enhanced */
    .category-badge {
      background-color: rgba(139, 115, 88, 0.1);
      color: var(--caramel-text);
      padding: 4px 10px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 500;
      display: inline-block;
    }
    
    /* Price - Enhanced */
    .price {
      font-weight: 600;
      color: var(--caramel-dark);
      font-size: 15px;
    }
    
    /* Actions - Enhanced */
    .action-buttons {
      display: flex;
      gap: 8px;
    }
    
    .btn-sm {
      padding: 6px 12px;
      font-size: 13px;
      border-radius: 16px;
    }
    
    .btn-edit {
      background-color: var(--caramel-light);
      color: var(--caramel-text);
    }
    
    .btn-edit:hover {
      background-color: #b8a18c;
      color: var(--white);
    }
    
    .btn-delete {
      background-color: var(--danger);
      color: var(--white);
    }
    
    .btn-delete:hover {
      background-color: #c82333;
    }
    
    /* Debug Info - Hidden by default */
    .debug-info {
      display: none;
      color: var(--danger);
      font-size: 12px;
      margin-top: 4px;
    }
    
    /* Responsive Adjustments */
    @media (max-width: 1200px) {
      .sidebar {
        width: 240px;
      }
      .main-content {
        margin-left: 240px;
        width: calc(100% - 240px);
      }
    }
    
    @media (max-width: 992px) {
      .sidebar {
        width: 80px;
        padding: 20px 0;
      }
      
      .logo {
        font-size: 0;
        padding: 15px;
      }
      
      .logo i {
        margin-right: 0;
        font-size: 20px;
      }
      
      .nav-menu li span,
      .avatar-name,
      .logout-btn span {
        display: none;
      }
      
      .nav-menu li {
        padding: 12px;
        justify-content: center;
      }
      
      .nav-menu li i {
        margin-right: 0;
        font-size: 18px;
      }
      
      .logout-btn {
        justify-content: center;
        padding: 10px;
      }
      
      .main-content {
        margin-left: 80px;
        width: calc(100% - 80px);
        padding: 20px;
      }
      
      .action-bar {
        flex-direction: column;
        gap: 12px;
        align-items: stretch;
      }
      
      .search-container {
        width: 100%;
      }
    }
    
    @media (max-width: 768px) {
      .page-header {
        flex-direction: column;
        gap: 12px;
        align-items: flex-start;
      }
      
      .header-icon {
        display: none;
      }
      
      th, td {
        padding: 10px 12px;
      }
    }
    
    /* Utility Classes */
    .text-nowrap {
      white-space: nowrap;
    }
    
    .text-truncate {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    
    .text-center {
      text-align: center;
    }
    
    .w-100 {
      width: 100%;
    }
    
    /* Animation */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }
    
    .table-container {
      animation: fadeIn 0.3s ease-out;
    }
  </style>
</head>
<body>

  <!-- Sidebar Navigation -->
  <nav class="sidebar">
    <div class="logo"><i class="fas fa-clock"></i> WatchX</div>
    <ul class="nav-menu">
      <li><a href="${contextPath}/admin/dashboard"><i class="fas fa-chart-pie"></i> <span>Dashboard</span></a></li>
      <li class="active"><a href="${contextPath}/admin/dashboard/products"><i class="fas fa-box-open"></i> <span>Products</span></a></li>
      <li><a href="#"><i class="fas fa-users"></i> <span>Customers</span></a></li>
      <li><a href="#"><i class="fas fa-file-alt"></i> <span>Reports</span></a></li>
    </ul>
    <div class="user-avatar">
      <div class="avatar-container">
        <div class="avatar">${not empty currentUser ? currentUser.charAt(0) : 'A'}</div>
        <div class="avatar-name">
          <a href="${contextPath}/update" class="user-profile-link">
            ${not empty currentUser ? currentUser : 'Admin User'}
          </a>
        </div>
      </div>
      <form action="${contextPath}/logout" method="post" class="logout-form">
        <button type="submit" class="logout-btn">
          <i class="fas fa-sign-out-alt"></i> <span>Log out</span>
        </button>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      </form>
    </div>
  </nav>
  <!-- Main Content -->
  <div class="main-content">
    <div class="page-header">
      <h1>Product Management</h1>
      <div class="header-icon"><i class="fas fa-box-open"></i></div>
    </div>

    <div class="action-bar">
      <div class="search-container">
        <i class="fas fa-search search-icon"></i>
        <input type="text" placeholder="Search products..." />
      </div>
      <a href="${contextPath}/admin/addProduct" class="btn btn-primary">
        <i class="fas fa-plus"></i>&nbsp;Add Product
      </a>
    </div>

    <div class="table-container">
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Product Name</th>
            <th>Description</th>
            <th>Category</th>
            <th>Price</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="product" items="${products}">
            <tr>
              <td><c:out value="${product.productNo}" /></td>
              <td>
    <img src="${contextPath}/${product.image_path}" alt="Product Image" class="product-image" />
    
</td>
              <td><c:out value="${product.productName}" /></td>
              <td class="description-cell" title="${product.description}"><c:out value="${product.description}" /></td>
              <td><span class="category-badge"><c:out value="${product.category}" /></span></td>
              <td>$<fmt:formatNumber value="${product.unitPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
              <td>
                <div class="action-buttons">
                  <a href="${contextPath}/admin/updateProduct?id=${product.productNo}" class="btn btn-sm btn-edit">
                    <i class="fas fa-edit"></i> Edit
                  </a>
                  <a href="${contextPath}/delete-product?id=${product.productNo}" class="btn btn-sm btn-delete" onclick="return confirm('Are you sure you want to delete this product?');">
                    <i class="fas fa-trash"></i> Delete
                  </a>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

</body>
</html>