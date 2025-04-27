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
<title>WatchX - Registration</title>
<!-- Set contextPath variable for reuse -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${contextPath}/css/register.css" />

</head>
<body>
	<div class="container">
		<div class="left-panel">
			<h1>WatchX</h1>
			<img src="${contextPath}/resources/images/WX logo.png"
				class="watch-image">
			<h3 class="tagline">"Your Wrist Deserves the Best"</h3>
			<p class="subtitle">Premium watches from worldwide luxury brands,
				all in one place.</p>
			<div class="dots">
				<span class="dot active"></span> <span class="dot"></span> <span
					class="dot"></span> <span class="dot"></span>
			</div>
		</div>

		<div class="right-panel">
			<h2>Register</h2>
			<p class="tagline-text">Create your WatchX account now</p>

			<!-- Hidden popup messages -->
			<c:if test="${not empty error}">
				<div id="errorPopup" class="popup-message popup-error">
					<div class="popup-content">
						<div class="popup-icon">
							<div class="icon-circle error">
								<span class="exclamation">!</span>
							</div>
						</div>
						<div class="popup-text">
							<h3>Oh no!</h3>
							<p>${error}</p>
						</div>
						<button class="close-btn">&times;</button>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty success}">
				<div id="successPopup" class="popup-message popup-success">
					<div class="popup-content">
						<div class="popup-icon">
							<div class="icon-circle success">
								<span class="checkmark">✓</span>
							</div>
						</div>
						<div class="popup-text">
							<h3>Congratulations!</h3>
							<p>${success}</p>
						</div>
						<button class="close-btn">&times;</button>
					</div>
				</div>
			</c:if>


			<form id="registration-form" action="${contextPath}/register"
				method="post">
				<div class="form-row">
					<div class="form-col">
						<div class="form-group">
							<label for="firstName">First Name</label> <input type="text"
								id="firstName" name="firstName" value="${firstName}" required>
						</div>
					</div>
					<div class="form-col">
						<div class="form-group">
							<label for="lastName">Last Name</label> <input type="text"
								id="lastName" name="lastName" value="${lastName}" required>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label for="username">Username</label> <input type="text"
						id="username" name="username" value="${username}" required>
				</div>

				<div class="form-group">
					<label for="email">Email</label> <input type="email" id="email"
						name="email" value="${email}" required>
				</div>

				<div class="form-group">
					<label for="contact">Contact No</label> <input type="tel"
						id="contact" name="contact" value="${contact}" required>
				</div>

				<div class="form-group">
					<label for="address">Address</label> <input type="text"
						id="address" name="address" value="${address}" required>
				</div>

				<div class="form-group">
					<label for="password">Password</label> <input type="password"
						id="password" name="password" required>
				</div>

				<button type="submit" class="btn">Create Account</button>

				<div class="login-link">
					Already have an account? <a href="${contextPath}/login">Sign in</a>
				</div>
			</form>
		</div>
	</div>

	<script>
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

</body>
</html>