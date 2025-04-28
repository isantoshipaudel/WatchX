<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" type="text/css"
	href="${contextPath}/css/message_hanlder.css" />
<meta charset="UTF-8">
<title>WatchX- messageHandler</title>

</head>
<body>
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