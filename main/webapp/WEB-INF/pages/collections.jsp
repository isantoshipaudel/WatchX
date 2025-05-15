<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${not empty searchQuery}">
    <h2>Search Results for: "${searchQuery}"</h2>
</c:if>

<c:if test="${not empty message}">
    <div class="alert alert-info">${message}</div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WatchX - Collections</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Helvetica Neue', Arial, sans-serif;
}

body {
    background-color: #f5f1ea;
    color: #333;
}

.container {
    max-width: 1400px; /* Increased from 1200px */
    width: 95%; /* Added to ensure some margin on larger screens */
    margin: 0 auto;
    padding: 20px;
}

.collection-header {
    text-align: center;
    padding: 40px 0 30px;
    position: relative;
    margin-bottom: 40px;
}

.collection-header:after {
    content: "";
    position: absolute;
    width: 80px;
    height: 3px;
    background: #6b563d;
    bottom: 15px;
    left: 50%;
    transform: translateX(-50%);
}

.collection-title {
    font-size: 36px;
    color: #6b563d;
    letter-spacing: 4px;
    text-transform: uppercase;
    font-weight: 500;
}

/* Wider product grid with better spacing */
.product-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 40px; /* Increased from 30px */
    margin: 0 auto;
}

.product-card {
    background: white;
    border: none;
    border-radius: 8px;
    overflow: hidden;
    transition: transform 0.3s, box-shadow 0.3s;
    position: relative;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
    height: 100%;
    display: flex;
    flex-direction: column;
}

.product-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
}

/* Improved image container */
.product-image {
    position: relative;
    padding-top: 75%; /* Changed to 4:3 aspect ratio for better product display */
    overflow: hidden;
    background-color: #f9f9f9; /* Light background for images that don't fully cover */
}

.product-image img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: contain; /* Changed from cover to contain to show full product */
    transition: transform 0.6s ease;
    padding: 15px; /* Added padding around the image */
}

.product-card:hover .product-image img {
    transform: scale(1.08);
}

.product-info {
    padding: 25px; /* Increased from 22px */
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.product-name {
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 6px;
    color: #222;
    letter-spacing: 0.5px;
}

.product-category {
    font-size: 14px;
    color: #777;
    margin-bottom: 12px;
    font-weight: 500;
    letter-spacing: 1px;
    text-transform: uppercase;
}

.product-description {
    font-size: 14px;
    line-height: 1.6;
    color: #555;
    margin-bottom: 15px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.see-more {
    color: #6b563d;
    font-size: 13px;
    text-decoration: none;
    cursor: pointer;
    font-weight: 600;
    display: inline-block;
    margin-bottom: 15px;
    transition: all 0.2s;
}

.see-more:hover {
    color: #8b765d;
    text-decoration: underline;
}

.product-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: auto;
    padding-top: 15px;
    border-top: 1px solid #f0ece6;
}

.product-rating {
    display: flex;
    align-items: center;
}

.stars {
    color: #f8ce0b;
    letter-spacing: 2px;
    margin-right: 5px;
}

.review-count {
    font-size: 12px;
    color: #888;
}

.product-price {
    font-size: 20px;
    font-weight: 600;
    color: #6b563d;
}

.shop-now-btn {
    display: block;
    width: 100%;
    padding: 14px 0;
    background: #2d2d2d;
    color: white;
    text-align: center;
    border: none;
    margin-top: 20px;
    cursor: pointer;
    text-transform: uppercase;
    font-size: 14px;
    letter-spacing: 1.5px;
    font-weight: 500;
    transition: all 0.3s;
    border-radius: 4px;
}

.shop-now-btn:hover {
    background: #6b563d;
    letter-spacing: 2px;
}

/* Modal Styles */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
    z-index: 1000;
    align-items: center;
    justify-content: center;
    backdrop-filter: blur(5px);
}

.modal-content {
    background-color: white;
    width: 650px;
    max-width: 90%;
    border-radius: 10px;
    box-shadow: 0 8px 40px rgba(0, 0, 0, 0.3);
    padding: 40px;
    position: relative;
    max-height: 80vh;
    overflow-y: auto;
    animation: modalFade 0.3s ease-in-out;
}

@keyframes modalFade {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.close-modal {
    position: absolute;
    top: 20px;
    right: 20px;
    font-size: 28px;
    cursor: pointer;
    color: #666;
    transition: all 0.2s;
    width: 30px;
    height: 30px;
    line-height: 30px;
    text-align: center;
    border-radius: 50%;
}

.close-modal:hover {
    color: #333;
    background-color: #f5f5f5;
}

.modal-title {
    font-size: 24px;
    margin-bottom: 20px;
    color: #333;
    font-weight: 600;
    padding-bottom: 15px;
    border-bottom: 2px solid #f0ece6;
}

.modal-description {
    font-size: 16px;
    line-height: 1.8;
    color: #444;
    margin-bottom: 30px;
}

.modal-specs {
    margin-top: 25px;
    background-color: #faf7f2;
    padding: 20px;
    border-radius: 8px;
}

.spec-title {
    font-weight: 600;
    margin-bottom: 15px;
    font-size: 18px;
    color: #333;
}

.spec-list {
    list-style: none;
}

.spec-list li {
    display: flex;
    margin-bottom: 12px;
    font-size: 15px;
    padding-bottom: 12px;
    border-bottom: 1px dashed #e6e0d6;
}

.spec-list li:last-child {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
}

.spec-label {
    width: 160px;
    font-weight: 500;
    color: #555;
}

.spec-value {
    flex: 1;
    color: #333;
    font-weight: 500;
}

/* Enhanced responsive styles */
@media (min-width: 1400px) {
    .product-grid {
        grid-template-columns: repeat(4, 1fr); /* Show 4 items per row on very large screens */
    }
}

@media (max-width: 1200px) {
    .product-grid {
        grid-template-columns: repeat(3, 1fr);
        gap: 30px;
    }
}

@media (max-width: 992px) {
    .product-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 25px;
    }
    
    .collection-filter {
        gap: 15px;
    }
}

@media (max-width: 768px) {
    .collection-title {
        font-size: 28px;
    }
    
    .modal-content {
        padding: 30px;
    }
    
    .product-image {
        padding-top: 80%; /* Slightly taller on tablets */
    }
}

@media (max-width: 576px) {
    .product-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    .container {
        width: 90%;
        padding: 15px;
    }
    
    .product-image {
        padding-top: 70%; /* Shorter on mobile for better viewing */
    }
    
    .collection-title {
        font-size: 24px;
    }
    
    .product-info {
        padding: 20px;
    }
}

.search-results-count {
    color: #666;
    margin-top: 10px;
    font-size: 16px;
}

.back-to-all {
    display: inline-block;
    margin-top: 15px;
    padding: 8px 16px;
    background: #6b563d;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-size: 14px;
    transition: background 0.3s;
}

.back-to-all:hover {
    background: #574632;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="container">
		<div class="collection-header">
			<h1 class="collection-title">
				<c:choose>
					<c:when test="${not empty searchQuery}">
						Search Results for "${searchQuery}"
					</c:when>
					<c:otherwise>
						All Collections
					</c:otherwise>
				</c:choose>
			</h1>
			<c:if test="${not empty searchQuery}">
				<p class="search-results-count">${products.size()} product(s) found</p>
				<a href="${pageContext.request.contextPath}/collections" class="back-to-all">View All Products</a>
			</c:if>
		</div>

		<div class="product-grid">
			<c:forEach var="product" items="${products}">
				<div class="product-card" data-category="${product.category}">
					<div class="product-image">
						<img src="${pageContext.request.contextPath}/${product.image_path}" 
							 alt="${product.productName}">
					</div>
					<div class="product-info">
						<h3 class="product-name">${product.productName}</h3>
						<p class="product-category">${product.category}</p>
						<p class="product-description">${product.description}</p>
						<a class="see-more" data-id="product${product.productNo}">See more</a>
						<div class="product-meta">
							<div class="product-rating">
								<span class="stars">★★★★★</span>
								<span class="review-count">0 reviews</span>
							</div>
							<div class="product-price">$${product.unitPrice}</div>
						</div>
						<button class="shop-now-btn">Shop Now</button>
					</div>
				</div>

				<!-- Modal for each product -->
				<div id="modal-product${product.productNo}" class="modal">
					<div class="modal-content">
						<span class="close-modal">&times;</span>
						<h2 class="modal-title">${product.productName}</h2>
						<div class="modal-description">
							<p>${product.description}</p>
						</div>
						<div class="modal-specs">
							<h3 class="spec-title">Specifications</h3>
							<ul class="spec-list">
								<li>
									<span class="spec-label">Category:</span>
									<span class="spec-value">${product.category}</span>
								</li>
								<li>
									<span class="spec-label">Price:</span>
									<span class="spec-value">$${product.unitPrice}</span>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

	<script>
		// Get all "See more" links
		const seeMoreLinks = document.querySelectorAll('.see-more');
		
		// Add click event to each link
		seeMoreLinks.forEach(link => {
			link.addEventListener('click', function() {
				const productId = this.getAttribute('data-id');
				const modal = document.getElementById('modal-' + productId);
				modal.style.display = 'flex';
			});
		});
		
		// Get all close buttons
		const closeButtons = document.querySelectorAll('.close-modal');
		
		// Add click event to each close button
		closeButtons.forEach(button => {
			button.addEventListener('click', function() {
				const modal = this.closest('.modal');
				modal.style.display = 'none';
			});
		});
		
		// Close modal when clicking outside content
		window.addEventListener('click', function(event) {
			const modals = document.querySelectorAll('.modal');
			modals.forEach(modal => {
				if (event.target === modal) {
					modal.style.display = 'none';
				}
			});
		});

		
	</script>
</body>
</html>