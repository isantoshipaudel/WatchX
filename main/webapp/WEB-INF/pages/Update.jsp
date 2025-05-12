
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
<title>WatchX - Update Profile</title>
<!-- Set contextPath variable for reuse -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>

body {
    font-family: 'Helvetica Neue', Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f1ea;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.container {
    display: flex;
    width: 1100px;
    height: 1300px;
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.left-panel {
    flex: 1.1;
    background-color: #6b563d;
    padding: 40px 50px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    position: relative;
    color: #e6d9c2;
}

.right-panel {
    flex: 1;
    padding: 60px 50px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.left-panel h1 {
    font-size: 46px;
    font-weight: 700;
    margin-bottom: 30px;
    color: #ffffff;
    letter-spacing: 1.5px;
}

.watch-image {
    width: 95%;
    height: auto;
}

.tagline {
    font-size: 26px;
    margin-bottom: 5px;
    color: #ffffff;
    font-weight: 300;
    font-style: bold;
}

.subtitle {
    font-size: 16px;
    line-height: 1.6;
    margin-bottom: 10px;
    color: #e6d9c2;
}

.dots {
    position: absolute;
    bottom: 40px;
    display: flex;
    justify-content: center;
    width: 100%;
}

.dot {
    height: 10px;
    width: 10px;
    margin: 0 5px;
    background-color: rgba(255, 255, 255, 0.3);
    border-radius: 50%;
    display: inline-block;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.dot.active {
    background-color: #ffffff;
}

.right-panel h2 {
    font-size: 36px;
    margin-top: 130px;  
    margin-bottom: 10px;
    color: #333;
    font-weight: 600;
    text-align: center;
}

.tagline-text {
    font-size: 18px;
    margin-bottom: 40px;
    color: #6b563d;
    font-weight: 500;
    text-align: center;
}

#update-form {
    width: 100%;
    max-width: 400px;
}

.form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 25px;
}

.form-col {
    flex: 1;
}

.form-group {
    margin-bottom: 25px;
    width: 100%;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #444;
    font-size: 15px;
    font-weight: 500;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 14px 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 15px;
    box-sizing: border-box;
    transition: all 0.3s ease;
}

.form-group select {
    height: 48px;
    padding: 12px 15px;
}

.form-group input:focus,
.form-group select:focus {
    outline: none;
    border-color: #6b563d;
    box-shadow: 0 0 0 2px rgba(107, 86, 61, 0.1);
}

.btn {
    width: 100%;
    background-color: #6b563d;
    color: white;
    border: none;
    padding: 20px 25px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 20px;
    font-weight: 600;
    transition: all 0.3s;
    margin-top: 20px;
    letter-spacing: 0.5px;
}

.btn:hover {
    background-color: #5a4732;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.cancel-link {
    width: 100%;
    text-align: center;
    font-size: 15px;
    color: #555;
    margin-top: 25px;
}

.cancel-link a {
    color: #6b563d;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s ease;
}

.cancel-link a:hover {
    color: #5a4732;
    text-decoration: underline;
}

.popup-message {
    position: fixed;
    top: 20px;
    left: 50%;
    transform: translateX(-50%);
    min-width: 320px;
    max-width: 400px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 9999;
    animation: fadeIn 0.5s, fadeOut 0.5s 4.5s;
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
    width: 48px;
    height: 48px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    font-size: 24px;
}

.icon-circle.success {
    background-color: #4CAF50;
}

.icon-circle.error {
    background-color: #f44336;
}

.checkmark, .exclamation {
    font-size: 24px;
}

.popup-text {
    flex: 1;
}

.popup-text h3 {
    font-size: 20px;
    margin: 0 0 5px 0;
    color: #333;
}

.popup-text p {
    margin: 0;
    color: #666;
    font-size: 16px;
}

.close-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    background: none;
    border: none;
    font-size: 24px;
    color: #999;
    cursor: pointer;
    padding: 0;
    line-height: 1;
}

.popup-success {
    border-bottom: 4px solid #4CAF50;
}

.popup-error {
    border-bottom: 4px solid #f44336;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translate(-50%, -20px);
    }
    to {
        opacity: 1;
        transform: translate(-50%, 0);
    }
}

@keyframes fadeOut {
    from {
        opacity: 1;
        transform: translate(-50%, 0);
    }
    to {
        opacity: 0;
        transform: translate(-50%, -20px);
    }
}

@media (max-width: 992px) {
    .container {
        width: 95%;
        height: auto;
        flex-direction: column;
    }

    .left-panel, .right-panel {
        width: 100%;
        padding: 40px 30px;
    }

    .left-panel {
        padding-bottom: 60px;
    }

    .right-panel {
        padding: 50px 30px;
    }

    .form-row {
        flex-direction: column;
        gap: 0;
    }
}
</style>
</head>
<body>
    <jsp:include page="message_handler.jsp" />
    <div class="container">
        <div class="left-panel">
            <h1>WatchX</h1>
            <div style="background-color: #fff; width: 250px; height: 250px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 20px 0;">
                <div style="font-size: 80px; font-weight: bold; color: #6b563d;">WX</div>
            </div>
            <h3 class="tagline">"Your Wrist Deserves the Best"</h3>
            <p class="subtitle">Premium watches from worldwide luxury brands,
                all in one place.</p>
            <div class="dots">
                <span class="dot"></span>
                <span class="dot active"></span>
                <span class="dot"></span>
                <span class="dot"></span>
            </div>
        </div>

        <div class="right-panel">
            <h2>Update Profile</h2>
            <p class="tagline-text">Keep your WatchX account information up to date</p>

            <!-- Error/Success Messages -->
            <c:if test="${not empty error}">
                <div id="errorPopup" class="popup-message popup-error">
                    <div class="popup-content">
                        <div class="popup-icon">
                            <div class="icon-circle error">
                                <span class="exclamation">!</span>
                            </div>
                        </div>
                        <div class="popup-text">
                            <h3>Error!</h3>
                            <p>${error}</p>
                        </div>
                        <button class="close-btn">&times;</button>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div id="successPopup" class="popup-message popup-success">
                    <div class="popup-content">
                        <div class="popup-icon">
                            <div class="icon-circle success">
                                <span class="checkmark">✓</span>
                            </div>
                        </div>
                        <div class="popup-text">
                            <h3>Success!</h3>
                            <p>${message}</p>
                        </div>
                        <button class="close-btn">&times;</button>
                    </div>
                </div>
            </c:if>

            <form id="update-form" action="${contextPath}/update" method="post">
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" 
                                value="${user.firstName}" required>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" 
                                value="${user.lastName}" required>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" 
                        value="${user.userName}" required>
                </div>

                <div class="form-group">
                    <label for="Email">Email</label>
                    <input type="email" id="Email" name="Email" 
                        value="${user.email}" required>
                </div>

                <div class="form-group">
                    <label for="contactNo">Contact No</label>
                    <input type="tel" id="contactNo" name="contactNo" 
                        value="${user.contactNumber}" required>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" 
                        value="${user.address}" required>
                </div>

                <!-- Password Update Section -->
                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" required>
                </div>

                <div class="form-group">
                    <label for="newPassword">New Password (leave blank to keep current)</label>
                    <input type="password" id="newPassword" name="newPassword">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword">
                </div>

                <button type="submit" class="btn">Save Changes</button>

                <div class="cancel-link">
                    <a href="${contextPath}/home">Cancel and Return</a>
                </div>
            </form>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Handle popup close buttons
            document.querySelectorAll('.close-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    this.closest('.popup-message').style.display = 'none';
                });
            });

            // Auto-hide popups after 5 seconds
            setTimeout(() => {
                document.querySelectorAll('.popup-message').forEach(popup => {
                    popup.style.display = 'none';
                });
            }, 5000);

            // Password validation
            const form = document.getElementById('update-form');
            form.addEventListener('submit', function(e) {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
                if (newPassword && newPassword !== confirmPassword) {
                    e.preventDefault();
                    alert('New password and confirmation do not match');
                }
            });
        });
    </script>
</body>
</html>