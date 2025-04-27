<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WatchX - Login</title>
<!-- Set contextPath variable for reuse -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${contextPath}/css/loginpage.css" />
<!-- <style>
/* Popup message styles */
</style> -->
</head>
<body>
<jsp:include page="message_handler.jsp"/>
	<div class="container">
		<div class="left-panel">
			<div class="logo">WatchX</div>
			<div class="image-container">
				<img src="${contextPath}/resources/images/WX logo.png">
			</div>
			<h1 class="tagline">"Your Wrist Deserves the Best"</h1>
			<p class="description">Premium watches from worldwide luxury
				brands, all in one place.</p>
			<div class="dots">
				<div class="dot active"></div>
				<div class="dot"></div>
				<div class="dot"></div>
				<div class="dot"></div>
			</div>
		</div>

		<div class="right-panel">
			<div class="login-header">
				<h2>Login</h2>
			</div>
			<p class="welcome-text">Welcome to WatchX</p>

			

			<form id="loginForm" action="${contextPath}/login" method="post">
				<div class="form-group">
					<label for="username">Username </label> <input type="text"
						id="username" name="username" required>
				</div>
				<div class="form-group">
					<label for="password">Password</label> <input type="password"
						id="password" name="password" required>
				</div>
				<div class="forgot-password">
					<a href="#">Forgot password?</a>
				</div>
				<button type="submit" class="login-btn">Sign in</button>
			</form>

			<div class="divider">
				<span>or</span>
			</div>

			<div class="signup-link">
				New to WatchX? <a href="${contextPath}/register">Register</a>
			</div>
		</div>
	</div>

	<!-- <script>
		document.addEventListener('DOMContentLoaded', function() {
			// Handle error popup
			const errorPopup = document.getElementById('errorPopup');
			if (errorPopup) {
				// Handle close button click
				const closeBtn = errorPopup.querySelector('.close-btn');
				closeBtn.addEventListener('click', function() {
					errorPopup.style.opacity = '0';
					setTimeout(function() {
						errorPopup.style.display = 'none';
					}, 500);
				});

				// Auto-hide after 5 seconds
				setTimeout(function() {
					errorPopup.style.opacity = '0';
					setTimeout(function() {
						errorPopup.style.display = 'none';
					}, 500);
				}, 5000);
			}

			// Handle success popup
			const successPopup = document.getElementById('successPopup');
			if (successPopup) {
				// Handle close button click
				const closeBtn = successPopup.querySelector('.close-btn');
				closeBtn.addEventListener('click', function() {
					successPopup.style.opacity = '0';
					setTimeout(function() {
						successPopup.style.display = 'none';
					}, 500);
				});

				// Auto-hide after 5 seconds
				setTimeout(function() {
					successPopup.style.opacity = '0';
					setTimeout(function() {
						successPopup.style.display = 'none';
					}, 500);
				}, 5000);
			}
		});
	</script>
 -->
</body>
</html>