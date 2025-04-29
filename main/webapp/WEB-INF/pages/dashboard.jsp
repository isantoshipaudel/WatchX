<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WatchX - Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css"
	 href="${pageContext.request.contextPath}/css/dashboard.css" />
    <style>
        
    </style>
</head>
<body>
    <!-- Converted to Sidebar Navigation -->
    <nav class="sidebar">
        <div class="logo">WatchX</div>
        <ul class="nav-menu">
            <li class="active"><i class="fas fa-chart-pie"></i> <span>Dashboard</span></li>
            <li><i class="fas fa-clock"></i> <span><a href="${contextPath}/admin/dashboard/products">Products</a></span></li>
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