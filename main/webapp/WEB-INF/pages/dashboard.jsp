<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
HttpSession userSession = request.getSession(false);
String currentUser = (String) (userSession != null ? userSession.getAttribute("username") : null);
String firstName = (String) (userSession != null ? userSession.getAttribute("firstName") : null);
pageContext.setAttribute("currentUser", currentUser);
pageContext.setAttribute("firstName", firstName);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>WatchX - Dashboard</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    @charset "UTF-8";
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Helvetica Neue', Arial, sans-serif;
    }
    
    body {
      background-color: #f8f9fa;
      color: #333;
      min-height: 100vh;
      background-image: linear-gradient(to bottom right, #f8f9fa, #ecedef);
      display: flex;
    }
    
    /* Sidebar Navigation */
    .sidebar {
      background-color: #f9f7f5; 
      color: #8b7358; 
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
    }
    
    .logo {
      font-size: 32px;
      font-weight: bold;
      letter-spacing: 2px;
      text-shadow: 1px 1px 2px rgba(139, 115, 88, 0.2);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px 30px;
      margin-bottom: 20px;
      border-bottom: 1px solid rgba(139, 115, 88, 0.1);
    }
    
    .logo::before {
      content: "\f017"; /* Watch icon */
      font-family: "Font Awesome 6 Free";
      font-weight: 900;
      margin-right: 12px;
      font-size: 28px;
    }
    
    .nav-menu {
      display: flex;
      flex-direction: column;
      list-style: none;
      gap: 10px;
      margin: 0;
      padding: 20px;
      flex-grow: 1;
    }
    
    .nav-menu li {
      padding: 16px 24px;
      cursor: pointer;
      transition: all 0.3s;
      border-radius: 12px;
      font-size: 17px;
      display: flex;
      align-items: center;
    }
    
    .nav-menu li.active {
      background-color: rgba(139, 115, 88, 0.15);
      color: #8b7358;
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(139, 115, 88, 0.1);
    }
    
    .nav-menu li:hover {
      background-color: rgba(139, 115, 88, 0.1);
      transform: translateX(5px);
    }
    
    .nav-menu li i {
      margin-right: 15px;
      font-size: 18px;
      width: 24px;
      text-align: center;
    }
    
    .user-avatar {
      padding: 20px 30px;
      border-top: 1px solid rgba(139, 115, 88, 0.1);
      display: flex;
      flex-direction: column;
      gap: 15px;
      align-items: center;
    }
    
    .avatar-container {
      display: flex;
      align-items: center;
      gap: 12px;
      width: 100%;
      padding: 10px 0;
    }
    
    .avatar {
      width: 48px;
      height: 48px;
      background-color: rgba(139, 115, 88, 0.1);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: bold;
      font-size: 20px;
      box-shadow: 0 4px 8px rgba(139, 115, 88, 0.1);
      border: 2px solid rgba(139, 115, 88, 0.2);
      color: #8b7358;
    }
    
    .avatar-name {
      font-weight: 500;
      font-size: 16px;
    }
    
    .logout-btn {
      background-color: rgba(139, 115, 88, 0.1);
      border: none;
      color: #8b7358;
      padding: 12px 24px;
      border-radius: 24px;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 12px;
      transition: all 0.3s;
      font-size: 16px;
      width: 100%;
      justify-content: center;
    }
    
    .logout-btn:hover {
      background-color: rgba(139, 115, 88, 0.2);
      transform: translateY(-2px);
    }
    
    /* Main content - adjusted for sidebar */
    .main-content {
      padding: 40px;
      margin-left: 280px; /* Match sidebar width */
      width: calc(100% - 280px);
    }
    
    .welcome-card {
      background-color: white;
      border-radius: 16px;
      padding: 30px;
      margin-bottom: 40px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
      border-top: 5px solid #8b7358;
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-image: linear-gradient(to right, white, #f9f7f5);
    }
    
    .welcome-card h1 {
      font-size: 28px;
      font-weight: 600;
      color: #3a3a3a;
    }
    
    .welcome-message {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }
    
    .welcome-card p {
      color: #666;
      font-size: 16px;
    }
    
    .welcome-decoration {
      width: 60px;
      height: 60px;
      background-color: rgba(139, 115, 88, 0.1);
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 28px;
      color: #8b7358;
    }
    
    /* Dashboard title */
    .dashboard-container h1 {
      margin-bottom: 30px;
      font-size: 24px;
      color: #3a3a3a;
      position: relative;
      padding-left: 15px;
    }
    
    .dashboard-container h1:before {
      content: '';
      position: absolute;
      left: 0;
      top: 50%;
      transform: translateY(-50%);
      height: 24px;
      width: 5px;
      background-color: #8b7358;
      border-radius: 3px;
    }
    
    /* Stats cards */
    .stats-container {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 30px;
      margin-bottom: 40px;
    }
    
    .stat-card {
      background-color: white;
      border-radius: 16px;
      padding: 30px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
      display: flex;
      flex-direction: column;
      transition: transform 0.3s, box-shadow 0.3s;
      border-top: 5px solid #8b7358;
      max-width: 600px;
      margin: 0 auto;
      width: 100%;
      background-image: linear-gradient(to bottom right, white, #f9f7f5);
      position: relative;
      overflow: hidden;
    }
    
    .stat-card:after {
      content: '';
      position: absolute;
      bottom: 0;
      right: 0;
      width: 100px;
      height: 100px;
      background: linear-gradient(135deg, transparent 50%, rgba(139, 115, 88, 0.05) 50%);
      border-radius: 0 0 16px 0;
    }
    
    .stat-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
    }
    
    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 20px;
      font-size: 24px;
      box-shadow: 0 6px 15px rgba(139, 115, 88, 0.15);
      background-color: rgba(139, 115, 88, 0.15);
      color: #8b7358;
      margin-left: 5px;
    }
    
    .stat-value {
      font-size: 40px;
      font-weight: 700;
      margin: 12px 0 8px;
      color: #333;
      text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.05);
    }
    
    .stat-title {
      font-size: 18px;
      font-weight: 500;
      color: #666;
      margin-top: 5px;
      position: relative;
      display: inline-block;
    }
    
    .stat-title:after {
      content: '';
      position: absolute;
      bottom: -8px;
      left: 0;
      width: 40px;
      height: 3px;
      background-color: rgba(139, 115, 88, 0.3);
      border-radius: 2px;
    }
    
    /* Additional links styling */
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
    
    /* Responsive adjustments */
    @media (max-width: 1200px) {
      .stats-container {
        grid-template-columns: 1fr;
      }
      
      .stat-card {
        max-width: 100%;
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
        justify-content: center;
      }
      
      .logo::before {
        margin-right: 0;
        font-size: 24px;
      }
      
      .nav-menu li span,
      .avatar-name,
      .logout-btn span {
        display: none;
      }
      
      .nav-menu li {
        padding: 15px;
        justify-content: center;
      }
      
      .nav-menu li i {
        margin-right: 0;
        font-size: 20px;
      }
      
      .logout-btn {
        justify-content: center;
        padding: 12px;
      }
      
      .logout-btn i {
        margin-right: 0;
      }
      
      .main-content {
        margin-left: 80px;
        width: calc(100% - 80px);
        padding: 30px 20px;
      }
    }
    
    @media (max-width: 768px) {
      .table-responsive {
        overflow-x: auto;
      }
      
      .welcome-card {
        flex-direction: column;
        gap: 20px;
        text-align: center;
      }
    }
  </style>
</head>
<body>

  <!-- Sidebar Navigation -->
  <nav class="sidebar">
    <div class="logo">WatchX</div>
    <ul class="nav-menu">
      <li class="active"><a href="#"><i class="fas fa-chart-pie"></i> <span>Dashboard</span></a></li>
      <li><a href="${contextPath}/admin/dashboard/products"><i class="fas fa-clock"></i> <span>Products</span></a></li>
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
    <div class="welcome-card">
      <div class="welcome-message">
        <h1>Welcome ${not empty currentUser ? currentUser : 'Admin'}!</h1>
        <p>Here's your watch business overview for today</p>
      </div>
      <div class="welcome-decoration">
        <i class="fas fa-chart-line"></i>
      </div>
    </div>

    <div class="dashboard-container">
      <h1>Dashboard Overview</h1>
      
      <div class="stats-container">
        <div class="stat-card">
          <div class="stat-icon"><i class="fas fa-users"></i></div>
          <div class="stat-value">${totalUsers}</div>
          <div class="stat-title">Total Users</div>
        </div>
        
        <div class="stat-card">
          <div class="stat-icon"><i class="fas fa-user-tie"></i></div>
          <div class="stat-value">${totalCustomers}</div>
          <div class="stat-title">Total Customers</div>
        </div>
        
        <div class="stat-card">
          <div class="stat-icon"><i class="fas fa-box"></i></div>
          <div class="stat-value">${totalProducts}</div>
          <div class="stat-title">Total Products</div>
        </div>
        
        <div class="stat-card">
          <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
          <div class="stat-value">${totalOrders}</div>
          <div class="stat-title">Total Orders</div>
        </div>
      </div>
    </div>
  </div>

</body>
</html>