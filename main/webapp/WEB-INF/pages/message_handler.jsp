<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
.popup-message {
    position: fixed;
    top: 20px;
    right: 20px;
    min-width: 300px;
    max-width: 400px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 9999;
    opacity: 1;
    transition: opacity 0.3s ease-in-out;
}

.popup-content {
    display: flex;
    padding: 16px;
    align-items: center;
}

.popup-icon {
    margin-right: 12px;
}

.icon-circle {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.icon-circle.success {
    background-color: #4CAF50;
    color: white;
}

.icon-circle.error {
    background-color: #f44336;
    color: white;
}

.popup-text {
    flex: 1;
}

.popup-text h3 {
    margin: 0 0 4px 0;
    font-size: 16px;
    font-weight: 600;
}

.popup-text p {
    margin: 0;
    font-size: 14px;
    color: #666;
}

.close-btn {
    background: none;
    border: none;
    font-size: 20px;
    color: #999;
    cursor: pointer;
    padding: 4px;
}

.popup-success {
    border-left: 4px solid #4CAF50;
}

.popup-error {
    border-left: 4px solid #f44336;
}
</style>

<!-- Success Message -->
<c:if test="${not empty successMessage}">
    <div id="successPopup" class="popup-message popup-success">
        <div class="popup-content">
            <div class="popup-icon">
                <div class="icon-circle success">
                    <span class="checkmark">✓</span>
                </div>
            </div>
            <div class="popup-text">
                <h3>Success!</h3>
                <p>${successMessage}</p>
            </div>
            <button class="close-btn" onclick="closePopup('successPopup')">&times;</button>
        </div>
    </div>
</c:if>

<!-- Error Message -->
<c:if test="${not empty errorMessage}">
    <div id="errorPopup" class="popup-message popup-error">
        <div class="popup-content">
            <div class="popup-icon">
                <div class="icon-circle error">
                    <span class="exclamation">!</span>
                </div>
            </div>
            <div class="popup-text">
                <h3>Error</h3>
                <p>${errorMessage}</p>
            </div>
            <button class="close-btn" onclick="closePopup('errorPopup')">&times;</button>
        </div>
    </div>
</c:if>

<script>
function closePopup(popupId) {
    const popup = document.getElementById(popupId);
    if (popup) {
        popup.style.opacity = '0';
        setTimeout(() => popup.remove(), 300);
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const popups = document.querySelectorAll('.popup-message');
    popups.forEach(popup => {
        setTimeout(() => {
            popup.style.opacity = '0';
            setTimeout(() => popup.remove(), 300);
        }, 5000);
    });
});
</script>