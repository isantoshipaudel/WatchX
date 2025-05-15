<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>

<%
HttpSession userSession = request.getSession(false);
String currentUser = (String) (userSession != null ? userSession.getAttribute("username") : null);
// Get the first name to display in the header
String firstName = (String) (userSession != null ? userSession.getAttribute("firstName") : null);
pageContext.setAttribute("currentUser", currentUser);
pageContext.setAttribute("firstName", firstName);
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<style>
.header-right {
	font-size: 28px;
	display: flex;
	align-items: center;
	gap: 15px;
}

.profile-icon {
	color: #6b563d;
	text-decoration: none;
	display: flex;
	align-items: center;
	gap: 8px;
}

.profile-icon:hover {
	color: #666;
}

.username-display {
	font-size: 16px;
	font-weight: 500;
}
</style>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WatchX - Premium Watches</title>
<link rel="stylesheet" type="text/css"
	href="${contextPath}/css/header.css" />
<!-- Font Awesome for icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
	<header class="header-main">
		<div class="brand">WatchX</div>

		<nav>
			<ul class="nav-menu">
				<li><a href="${contextPath}/home">HOME</a></li>
				<li><a href="${contextPath}/collections">COLLECTIONS</a></li>
				<li><a href="${contextPath}/aboutUs">ABOUT US</a></li>
				<li><a href="${contextPath}/contact">CONTACT</a></li>
			</ul>
		</nav>

		<div class="header-right">
			<div class="search-container">
				<form class="search-form" action="${contextPath}/search"
					method="get">
					<input type="text" class="search-input" name="query"
						placeholder="Search watches..." required>
					<button type="submit" class="search-button">Search</button>
				</form>
			</div>

			<!-- Profile Icon with username (only visible when logged in) -->
			<c:if test="${not empty currentUser}">
				<a href="${contextPath}/update" class="profile-icon"
					title="Update Profile"> <i class="fas fa-user-circle fa-lg"></i>
					<span class="username-display">${firstName != null ? firstName : currentUser}</span>
				</a>
			</c:if>

			<!-- Login/Logout Link -->
			<c:choose>
				<c:when test="${not empty currentUser}">
					<form action="${contextPath}/logout" method="post">
						<input type="submit" class="login-link" value="Logout" />
					</form>
				</c:when>
				<c:otherwise>
					<a href="${contextPath}/login" class="login-link">Log in</a>
				</c:otherwise>
			</c:choose>
		</div>
	</header>
</body>
</html>