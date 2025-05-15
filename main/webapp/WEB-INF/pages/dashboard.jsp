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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
    
    :root {
      --primary: #8b7358;
      --primary-light: #a18b73;
      --primary-dark: #6a563e;
      --secondary: #8b7358;
      --secondary-light: #a18b73;
      --text-primary: #212121;
      --text-secondary: #616161;
      --bg-light: #f5f7fa;
      --bg-white: #ffffff;
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
    
    /* Sidebar Navigation */
    .sidebar {
      background: linear-gradient(180deg, var(--primary-dark) 0%, var(--primary) 100%);
      color: var(--bg-white);
      width: 280px;
      height: 100vh;
      position: fixed;
      top: 0;
      left: 0;
      box-shadow: var(--shadow-md);
      display: flex;
      flex-direction: column;
      z-index: 1000;
      padding: 20px 0;
      transition: var(--transition);
    }
    
    .logo {
      font-size: 26px;
      font-weight: 700;
      letter-spacing: 2px;
      text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 24px 30px;
      margin-bottom: 10px;
      color: var(--bg-white);
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
    
    .nav-menu {
      display: flex;
      flex-direction: column;
      list-style: none;
      gap: 5px;
      margin: 0;
      padding: 10px 15px;
      flex-grow: 1;
    }
    
    .nav-menu li {
      padding: 14px 20px;
      cursor: pointer;
      transition: var(--transition);
      border-radius: var(--radius-sm);
      font-size: 15px;
      display: flex;
      align-items: center;
      margin: 2px 0;
    }
    
    .nav-menu li.active {
      background-color: rgba(255, 255, 255, 0.2);
      color: var(--bg-white);
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      position: relative;
    }
    
    .nav-menu li.active::before {
      content: '';
      position: absolute;
      left: 0;
      top: 0;
      height: 100%;
      width: 4px;
      background-color: var(--secondary);
      border-radius: 0 4px 4px 0;
    }
    
    .nav-menu li:hover {
      background-color: rgba(255, 255, 255, 0.15);
      transform: translateX(3px);
    }
    
    .nav-menu li i {
      margin-right: 15px;
      font-size: 18px;
      width: 24px;
      text-align: center;
      color: rgba(255, 255, 255, 0.85);
    }
    
    .nav-menu li.active i {
      color: var(--secondary);
    }
    
    .user-avatar {
      padding: 15px;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      display: flex;
      flex-direction: column;
      gap: 15px;
      align-items: center;
      margin-top: auto;
    }
    
    .avatar-container {
      display: flex;
      align-items: center;
      gap: 12px;
      width: 100%;
      padding: 10px;
      background-color: rgba(255, 255, 255, 0.1);
      border-radius: var(--radius-sm);
      transition: var(--transition);
    }
    
    .avatar-container:hover {
      background-color: rgba(255, 255, 255, 0.15);
      transform: translateY(-2px);
    }
    
    .avatar {
      width: 45px;
      height: 45px;
      background-color: var(--secondary);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: bold;
      font-size: 18px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
      border: 2px solid rgba(255, 255, 255, 0.2);
      color: var(--bg-white);
      text-transform: uppercase;
    }
    
    .avatar-name {
      font-weight: 500;
      font-size: 14px;
      color: var(--bg-white);
    }
    
    .logout-btn {
      background-color: rgba(255, 255, 255, 0.1);
      border: none;
      color: var(--bg-white);
      padding: 12px;
      border-radius: var(--radius-md);
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 12px;
      transition: var(--transition);
      font-size: 14px;
      width: 100%;
      justify-content: center;
    }
    
    .logout-btn:hover {
      background-color: rgba(255, 255, 255, 0.2);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
    }
    
    /* Main content - adjusted for sidebar */
    .main-content {
      padding: 30px;
      margin-left: 280px; /* Match sidebar width */
      width: calc(100% - 280px);
      transition: var(--transition);
    }
    
    .welcome-card {
      background: linear-gradient(135deg, var(--bg-white) 0%, #f1f4f9 100%);
      border-radius: var(--radius-md);
      padding: 30px 40px;
      margin-bottom: 40px;
      box-shadow: var(--shadow-sm);
      display: flex;
      align-items: center;
      justify-content: space-between;
      position: relative;
      overflow: hidden;
      border-left: 5px solid var(--primary);
      animation: fadeIn 0.8s ease;
    }
    
    .welcome-card::after {
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
    
    .welcome-card::before {
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
    
    .welcome-card h1 {
      font-size: 28px;
      font-weight: 700;
      color: var(--primary);
      margin-bottom: 8px;
      position: relative;
    }
    
    .welcome-message {
      display: flex;
      flex-direction: column;
      gap: 8px;
      position: relative;
      z-index: 1;
    }
    
    .welcome-card p {
      color: var(--text-secondary);
      font-size: 16px;
      font-weight: 400;
      position: relative;
    }
    
    .welcome-decoration {
      width: 70px;
      height: 70px;
      background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
      border-radius: var(--radius-md);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 30px;
      color: var(--bg-white);
      box-shadow: var(--shadow-md);
      position: relative;
      z-index: 1;
      transform: rotate(10deg);
    }
    
    /* Dashboard title */
    .dashboard-container h1 {
      margin-bottom: 30px;
      font-size: 24px;
      color: var(--primary-dark);
      position: relative;
      padding-left: 20px;
      font-weight: 600;
      animation: fadeIn 1s ease;
    }
    
    .dashboard-container h1:before {
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
    
    /* Stats cards */
    .stats-container {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 30px;
      margin-bottom: 40px;
      animation: fadeIn 1.2s ease;
    }
    
    .stat-card {
      background: var(--bg-white);
      border-radius: var(--radius-md);
      padding: 30px;
      box-shadow: var(--shadow-sm);
      display: flex;
      flex-direction: column;
      transition: var(--transition);
      border: 1px solid rgba(139, 115, 88, 0.05);
      max-width: 600px;
      margin: 0 auto;
      width: 100%;
      position: relative;
      overflow: hidden;
    }
    
    .stat-card::after {
      content: '';
      position: absolute;
      bottom: 0;
      right: 0;
      width: 100px;
      height: 100px;
      background: linear-gradient(135deg, transparent 50%, rgba(139, 115, 88, 0.04) 50%);
      border-radius: 0 0 var(--radius-md) 0;
    }
    
    .stat-card:hover {
      transform: translateY(-8px);
      box-shadow: var(--shadow-md);
      border-top: 3px solid var(--primary);
    }
    
    .stat-icon {
      width: 65px;
      height: 65px;
      border-radius: var(--radius-sm);
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 25px;
      font-size: 26px;
      background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
      color: var(--bg-white);
      box-shadow: 0 8px 15px rgba(139, 115, 88, 0.2);
      position: relative;
      z-index: 1;
    }
    
    .stat-icon::before {
      content: '';
      position: absolute;
      width: 100%;
      height: 100%;
      background: rgba(139, 115, 88, 0.1);
      border-radius: inherit;
      left: 5px;
      top: 5px;
      z-index: -1;
    }
    
    .stat-value {
      font-size: 42px;
      font-weight: 700;
      margin: 5px 0;
      color: var(--primary-dark);
      position: relative;
      display: inline-block;
    }
    
    .stat-value::after {
      content: '';
      position: absolute;
      width: 30px;
      height: 4px;
      background: var(--secondary);
      border-radius: 10px;
      bottom: -5px;
      left: 2px;
    }
    
    .stat-title {
      font-size: 16px;
      font-weight: 500;
      color: var(--text-secondary);
      margin-top: 12px;
      letter-spacing: 0.5px;
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
    
    /* Popup message styling */
    .popup-message {
      position: fixed;
      top: 20px;
      left: 50%;
      transform: translateX(-50%);
      min-width: 320px;
      max-width: 400px;
      background-color: var(--bg-white);
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
        padding: 25px;
      }
      
      .welcome-decoration {
        margin-top: 10px;
      }
    }
  </style>
</head>
<body>
  <jsp:include page="message_handler.jsp"/>
  
  <!-- Sidebar Navigation -->
  <nav class="sidebar">
    <div class="logo">WatchX</div>
    <ul class="nav-menu">
      <li class="active"><a href="#"><i class="fas fa-chart-pie"></i> <span>Dashboard</span></a></li>
      <li><a href="${contextPath}/admin/dashboard/products"><i class="fas fa-clock"></i> <span>Products</span></a></li>
      <li><a href="#"><i class="fas fa-users"></i> <span>Customers</span></a></li>
      <li><a href="#"><i class="fas fa-file-alt"></i> <span>Reports</span></a></li>
      <li><a href="#"><i class="fas fa-cog"></i> <span>Settings</span></a></li>
      <li><a href="#"><i class="fas fa-headset"></i> <span>Support</span></a></li>
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
        <h1>Welcome back, ${not empty firstName ? firstName : (not empty currentUser ? currentUser : 'Admin')}!</h1>
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

  <script>
    // Add subtle animation to stat cards on scroll
    document.addEventListener('DOMContentLoaded', function() {
      const statCards = document.querySelectorAll('.stat-card');
      
      const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.style.opacity = 1;
            entry.target.style.transform = 'translateY(0)';
          }
        });
      }, { threshold: 0.1 });
      
      statCards.forEach((card, index) => {
        card.style.opacity = 0;
        card.style.transform = 'translateY(20px)';
        card.style.transitionDelay = `${index * 0.1}s`;
        observer.observe(card);
      });
    });
  </script>
</body>
</html>