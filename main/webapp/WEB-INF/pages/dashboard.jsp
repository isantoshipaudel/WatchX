<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WatchX - Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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
        
        /* Converted to Sidebar Navigation */
        .sidebar {
            background-color: #f9f7f5; /* Swapped - was brown, now light */
            color: #8b7358; /* Swapped - was white, now brown */
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
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
        }
        
        .stat-header {
            display: flex;
            align-items: center;
            margin-bottom: 24px;
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 24px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
        }
        
        .icon-selling {
            background-color: rgba(139, 115, 88, 0.15);
            color: #8b7358;
        }
        
        .icon-top {
            background-color: rgba(139, 115, 88, 0.2);
            color: #8b7358;
        }
        
        .icon-reorder {
            background-color: rgba(139, 115, 88, 0.25);
            color: #8b7358;
        }
        
        .icon-highest {
            background-color: rgba(139, 115, 88, 0.3);
            color: #8b7358;
        }
        
        .stat-title {
            font-size: 20px;
            font-weight: 500;
            color: #444;
        }
        
        .stat-value {
            font-size: 36px;
            font-weight: 700;
            margin: 12px 0;
            color: #333;
            text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.05);
        }
        
        .stat-change {
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 14px;
            border-radius: 20px;
            width: fit-content;
        }
        
        .positive {
            color: #28a745;
            background-color: rgba(40, 167, 69, 0.1);
        }
        
        .negative {
            color: #dc3545;
            background-color: rgba(220, 53, 69, 0.1);
        }
        
        /* Products table */
        .table-card {
            background-color: white;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
            padding: 30px;
            margin-top: 30px;
            border-top: 5px solid #8b7358;
            background-image: linear-gradient(to bottom, white, #f9f7f5);
        }
        
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .table-header h2 {
            font-size: 22px;
            font-weight: 600;
            color: #3a3a3a;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .table-header h2::before {
            content: "\f201"; /* Chart icon */
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            color: #8b7358;
        }
        
        .more-options {
            width: 42px;
            height: 42px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: #f5f5f5;
            transition: all 0.2s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }
        
        .more-options:hover {
            background-color: #e9ecef;
            transform: rotate(90deg);
        }
        
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        th {
            text-align: left;
            padding: 18px;
            border-bottom: 2px solid #e9ecef;
            font-weight: 600;
            color: #5a5a5a;
            font-size: 15px;
        }
        
        td {
            padding: 18px;
            border-bottom: 1px solid #e9ecef;
        }
        
        tbody tr {
            transition: all 0.2s;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
            transform: translateX(5px);
        }
        
        .product-cell {
            display: flex;
            align-items: center;
        }
        
        .product-image {
            width: 54px;
            height: 54px;
            background-color: rgba(139, 115, 88, 0.1);
            border-radius: 12px;
            margin-right: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #8b7358;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }
        
        .product-name {
            font-weight: 600;
            color: #333;
            font-size: 16px;
        }
        
        .product-subtitle {
            font-size: 14px;
            color: #6c757d;
            margin-top: 4px;
        }
        
        .status-badge {
            padding: 10px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            display: inline-block;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
        }
        
        .status-stock {
            background-color: rgba(40, 167, 69, 0.15);
            color: #28a745;
        }
        
        .status-reorder {
            background-color: rgba(255, 193, 7, 0.2);
            color: #d39e00;
        }
        
        .status-low {
            background-color: rgba(220, 53, 69, 0.15);
            color: #dc3545;
        }
        
        .rating {
            color: #ffc107;
            font-size: 18px;
            letter-spacing: 2px;
        }
        
        .rating-value {
            margin-left: 8px;
            color: #5a5a5a;
            font-size: 14px;
            font-weight: 500;
        }

        /* Additional table styling */
        td:nth-child(4), td:nth-child(5) {
            font-weight: 600;
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
    <!-- Converted to Sidebar Navigation -->
    <nav class="sidebar">
        <div class="logo">WatchX</div>
        <ul class="nav-menu">
            <li class="active"><i class="fas fa-chart-pie"></i> <span>Dashboard</span></li>
            <li><i class="fas fa-clock"></i> <span><a href="${contextPath}/admin/products">Products</a></span></li>
            <li><i class="fas fa-users"></i> <span>Customers</span></li>
            <li><i class="fas fa-file-alt"></i> <span>Reports</span></li>
        </ul>
        <div class="user-avatar">
            <div class="avatar-container">
                <div class="avatar">A</div>
                <div class="avatar-name">Admin User</div>
            </div>
            <button class="logout-btn"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></button>
        </div>
    </nav>
    
    <!-- Main Content - Adjusted for sidebar -->
    <div class="main-content">
        <div class="welcome-card">
            <div class="welcome-message">
                <h1>Welcome to Your Admin Dashboard!</h1>
                <p>Here's your watch business overview for today</p>
            </div>
            <div class="welcome-decoration">
                <i class="fas fa-chart-line"></i>
            </div>
        </div>
        
        <!-- Stats Cards -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon icon-selling">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="stat-title">Total Users</div>
                </div>
                <div class="stat-value">2,456</div>
                <div class="stat-change positive">
                    +2.79% <i class="fas fa-arrow-up"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon icon-top">
                        <i class="fas fa-trophy"></i>
                    </div>
                    <div class="stat-title">Top Products</div>
                </div>
                <div class="stat-value">1,238</div>
                <div class="stat-change negative">
                    -2.10% <i class="fas fa-arrow-down"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon icon-reorder">
                        <i class="fas fa-sync"></i>
                    </div>
                    <div class="stat-title">Selling Products</div>
                </div>
                <div class="stat-value">3,132</div>
                <div class="stat-change positive">
                    +4.23% <i class="fas fa-arrow-up"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon icon-highest">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="stat-title">Total Customers</div>
                </div>
                <div class="stat-value">4,345</div>
                <div class="stat-change positive">
                    +5.23% <i class="fas fa-arrow-up"></i>
                </div>
            </div>
        </div>
        
        <!-- Products Table -->
        <div class="table-card">
            <div class="table-header">
                <h2>Top 5 Best-Selling Products</h2>
                <div class="more-options">
                    <i class="fas fa-ellipsis-h"></i>
                </div>
            </div>
            
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Total Revenue</th>
                            <th>Product Price</th>
                            <th>Customer Rating</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="product-cell">
                                    <div class="product-image">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div>
                                        <div class="product-name">Rolex Submariner</div>
                                        <div class="product-subtitle">Classic Diver</div>
                                    </div>
                                </div>
                            </td>
                            <td>Luxury</td>
                            <td><span class="status-badge status-stock">Stock OK</span></td>
                            <td>$350,000</td>
                            <td>$12,999</td>
                            <td>
                                <span class="rating">★★★★★</span>
                                <span class="rating-value">(4.8)</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="product-cell">
                                    <div class="product-image">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div>
                                        <div class="product-name">Omega Speedmaster</div>
                                        <div class="product-subtitle">Moonwatch</div>
                                    </div>
                                </div>
                            </td>
                            <td>Luxury</td>
                            <td><span class="status-badge status-reorder">Reorder</span></td>
                            <td>$280,000</td>
                            <td>$6,299</td>
                            <td>
                                <span class="rating">★★★★☆</span>
                                <span class="rating-value">(4.7)</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="product-cell">
                                    <div class="product-image">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div>
                                        <div class="product-name">Seiko Prospex</div>
                                        <div class="product-subtitle">Automatic Diver</div>
                                    </div>
                                </div>
                            </td>
                            <td>Sport</td>
                            <td><span class="status-badge status-low">5 Stock</span></td>
                            <td>$150,000</td>
                            <td>$499</td>
                            <td>
                                <span class="rating">★★★★☆</span>
                                <span class="rating-value">(4.6)</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="product-cell">
                                    <div class="product-image">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div>
                                        <div class="product-name">Audemars Piguet</div>
                                        <div class="product-subtitle">Royal Oak</div>
                                    </div>
                                </div>
                            </td>
                            <td>Luxury</td>
                            <td><span class="status-badge status-stock">Stock OK</span></td>
                            <td>$120,000</td>
                            <td>$29,500</td>
                            <td>
                                <span class="rating">★★★★★</span>
                                <span class="rating-value">(4.9)</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="product-cell">
                                    <div class="product-image">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div>
                                        <div class="product-name">Tag Heuer Carrera</div>
                                        <div class="product-subtitle">Chronograph</div>
                                    </div>
                                </div>
                            </td>
                            <td>Sport</td>
                            <td><span class="status-badge status-reorder">Reorder</span></td>
                            <td>$110,000</td>
                            <td>$5,450</td>
                            <td>
                                <span class="rating">★★★★☆</span>
                                <span class="rating-value">(4.5)</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>