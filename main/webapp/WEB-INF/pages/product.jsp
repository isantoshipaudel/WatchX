<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<title>Product Management | WatchX</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" 
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<style>
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
	color: var(--secondary-light);
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
	background-color: var(--secondary-light);
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
	color: var(--secondary-light);
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

.user-profile-link {
	color: inherit;
	text-decoration: none;
}

.user-profile-link:hover {
	color: inherit;
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

/* Main Content */
.main-content {
	padding: 30px;
	margin-left: 280px;
	width: calc(100% - 280px);
	transition: var(--transition);
}

.main-content a {
	color: inherit;
	text-decoration: none;
}

.main-content a:hover {
	color: inherit;
}

/* Page Header */
.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
	background-color: var(--bg-white);
	border-radius: var(--radius-md);
	padding: 25px;
	box-shadow: var(--shadow-sm);
	border-left: 4px solid var(--primary);
	animation: fadeIn 0.8s ease;
	position: relative;
	overflow: hidden;
}

.page-header::after {
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

.page-header h1 {
	font-size: 24px;
	color: var(--primary-dark);
	font-weight: 600;
	position: relative;
	z-index: 1;
}

.header-icon {
	width: 60px;
	height: 60px;
	background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
	border-radius: var(--radius-md);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	color: var(--bg-white);
	box-shadow: var(--shadow-md);
	position: relative;
	z-index: 1;
}

/* Action Bar */
.action-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	animation: fadeIn 1s ease;
}

.search-container {
	position: relative;
	width: 500px;
	max-width: 100%;
}

.search-container form {
	display: flex;
	width: 100%;
	position: relative;
}

.search-icon {
	position: absolute;
	left: 16px;
	top: 50%;
	transform: translateY(-50%);
	color: var(--text-secondary);
	font-size: 16px;
	z-index: 1;
}

.search-container input[type="text"] {
	flex: 1;
	padding: 12px 16px 12px 45px;
	border: 1px solid rgba(139, 115, 88, 0.2);
	border-radius: var(--radius-md) 0 0 var(--radius-md);
	background-color: var(--bg-white);
	font-size: 14px;
	transition: var(--transition);
	box-shadow: var(--shadow-sm);
	height: 48px;
}

.search-container input[type="text"]:focus {
	outline: none;
	border-color: var(--primary);
	box-shadow: 0 0 0 3px rgba(139, 115, 88, 0.1);
}

.btn-search {
	background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
	color: var(--bg-white);
	border: none;
	border-radius: 0 var(--radius-md) var(--radius-md) 0;
	padding: 0 20px;
	font-size: 14px;
	cursor: pointer;
	transition: var(--transition);
	height: 48px;
	box-shadow: var(--shadow-sm);
}

.btn-search:hover {
	background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-dark) 100%);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* Buttons */
.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 12px 24px;
	font-weight: 500;
	border: none;
	font-size: 14px;
	border-radius: var(--radius-md);
	transition: var(--transition);
	cursor: pointer;
	gap: 8px;
}

.btn-primary {
	background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
	color: var(--bg-white);
	box-shadow: 0 4px 10px rgba(139, 115, 88, 0.2);
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 15px rgba(139, 115, 88, 0.3);
}

/* Table Styling */
.table-container {
	background-color: var(--bg-white);
	border-radius: var(--radius-md);
	box-shadow: var(--shadow-md);
	overflow: hidden;
	margin-bottom: 30px;
	animation: fadeIn 1.2s ease;
	position: relative;
}

.table-container::after {
	content: '';
	position: absolute;
	bottom: 0;
	right: 0;
	width: 100px;
	height: 100px;
	background: linear-gradient(135deg, transparent 50%, rgba(139, 115, 88, 0.03) 50%);
	border-radius: 0 0 var(--radius-md) 0;
}

table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	min-width: 800px;
}

thead {
	background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
	color: var(--bg-white);
	position: sticky;
	top: 0;
}

th, td {
	padding: 16px 20px;
	text-align: left;
	border-bottom: 1px solid rgba(139, 115, 88, 0.1);
}

th {
	font-weight: 600;
	font-size: 13px;
	letter-spacing: 0.3px;
	text-transform: uppercase;
}

tbody tr {
	transition: var(--transition);
}

tbody tr:last-child td {
	border-bottom: none;
}

tbody tr:hover {
	background-color: rgba(139, 115, 88, 0.05);
}

/* Product Image */
.product-image {
	width: 60px;
	height: 60px;
	border-radius: var(--radius-sm);
	overflow: hidden;
	background-color: var(--bg-light);
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid rgba(139, 115, 88, 0.1);
	box-shadow: var(--shadow-sm);
}

.product-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.product-info {
	display: flex;
	align-items: center;
	gap: 15px;
}

.product-name {
	font-weight: 600;
	color: var(--primary-dark);
	margin-bottom: 3px;
	font-size: 15px;
}

.product-description {
	font-size: 13px;
	color: var(--text-secondary);
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	line-height: 1.4;
}

/* Category Badge */
.category-badge {
	background-color: rgba(139, 115, 88, 0.1);
	color: var(--primary-dark);
	padding: 6px 12px;
	border-radius: var(--radius-sm);
	font-size: 12px;
	font-weight: 500;
	display: inline-block;
	box-shadow: 0 2px 4px rgba(139, 115, 88, 0.1);
}

/* Price */
.price {
	font-weight: 600;
	color: var(--primary-dark);
	font-size: 16px;
}

/* Actions */
.action-buttons {
	display: flex;
	gap: 10px;
}

.btn-sm {
	padding: 8px 14px;
	font-size: 12px;
	border-radius: var(--radius-sm);
}

.btn-edit {
	background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
	color: var(--bg-white);
}

.btn-edit:hover {
	background: linear-gradient(135deg, var(--primary) 0%, var(--primary) 100%);
	transform: translateY(-2px);
	box-shadow: 0 4px 8px rgba(139, 115, 88, 0.2);
}

.btn-delete {
	background-color: #dc3545;
	color: var(--bg-white);
}

.btn-delete:hover {
	background-color: #c82333;
	transform: translateY(-2px);
	box-shadow: 0 4px 8px rgba(220, 53, 69, 0.2);
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
		justify-content: center;
	}
	.logo::before {
		margin-right: 0;
		font-size: 24px;
	}
	.nav-menu li span, .avatar-name, .logout-btn span {
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
	.main-content {
		margin-left: 80px;
		width: calc(100% - 80px);
		padding: 20px;
	}
	.action-bar {
		flex-direction: column;
		gap: 15px;
		align-items: stretch;
	}
	.search-container {
		width: 100%;
	}
}

@media (max-width: 768px) {
	.page-header {
		flex-direction: column;
		gap: 15px;
		align-items: flex-start;
	}
	.header-icon {
		display: none;
	}
	th, td {
		padding: 12px 15px;
	}
}

/* Animations */
@keyframes fadeIn {
	from {
		opacity: 0;
		transform: translateY(10px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

/* Debug Info - Hidden by default */
.debug-info {
	display: none;
	color: #dc3545;
	font-size: 12px;
	margin-top: 4px;
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

.description-cell {
	max-width: 300px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>
</head>
<body>
	
	<jsp:include page="message_handler.jsp" />

	<!-- Sidebar Navigation -->
	<nav class="sidebar">
		<div class="logo">WatchX</div>
		<ul class="nav-menu">
			<li><a href="${contextPath}/admin/dashboard"><i
					class="fas fa-chart-pie"></i> <span>Dashboard</span></a></li>
			<li class="active"><a
				href="${contextPath}/admin/dashboard/products"><i
					class="fas fa-box-open"></i> <span>Products</span></a></li>
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
						${not empty currentUser ? currentUser : 'Admin User'} </a>
				</div>
			</div>
			<form action="${contextPath}/logout" method="post"
				class="logout-form">
				<button type="submit" class="logout-btn">
					<i class="fas fa-sign-out-alt"></i> <span>Log out</span>
				</button>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</nav>
	
	<!-- Main Content -->
	<div class="main-content">
		<div class="page-header">
			<h1>Product Management</h1>
			<div class="header-icon">
				<i class="fas fa-box-open"></i>
			</div>
		</div>

		<div class="action-bar">
			<div class="search-container">
				<form action="${pageContext.request.contextPath}/search"
					method="get">
					<i class="fas fa-search search-icon"></i> 
					<input type="text" name="query" placeholder="Search products..." required />
					<button type="submit" class="btn-search">Search</button>
				</form>
			</div>
			<a href="${contextPath}/admin/addProduct" class="btn btn-primary">
				<i class="fas fa-plus"></i> Add Product
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
							<td><img
								src="${pageContext.request.contextPath}/${product.image_path}"
								alt="${product.productName}" width="200"></td>
							<td><c:out value="${product.productName}" /></td>
							<td class="description-cell" title="${product.description}"><c:out
									value="${product.description}" /></td>
							<td><span class="category-badge"><c:out
										value="${product.category}" /></span></td>
							<td>$<fmt:formatNumber value="${product.unitPrice}"
									type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
							<td>
								<div class="action-buttons">
									<a
										href="${pageContext.request.contextPath}/admin/updateProduct?productNo=${product.productNo}"
										class="btn btn-sm btn-edit"
										aria-label="Edit ${product.productNo}"> <i
										class="fas fa-edit"></i> Edit
									</a>
									<form
										action="${pageContext.request.contextPath}/admin/deleteProduct"
										method="post" style="display: inline;">
										<input type="hidden" name="productNo"
											value="${product.productNo}">
										<button type="submit" class="btn btn-sm btn-delete"
											onclick="return confirm('Are you sure you want to delete this product?');">
											<i class="fas fa-trash"></i> Delete
										</button>
									</form>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<script>
		// Add subtle animation to table rows on load
		document.addEventListener('DOMContentLoaded', function() {
			const tableRows = document.querySelectorAll('tbody tr');
			
			tableRows.forEach((row, index) => {
				row.style.opacity = '0';
				row.style.transform = 'translateY(10px)';
				
				setTimeout(() => {
					row.style.transition = 'all 0.3s ease';
					row.style.opacity = '1';
					row.style.transform = 'translateY(0)';
				}, 100 + (index * 50));
			});
		});
	</script>

</body>
</html>