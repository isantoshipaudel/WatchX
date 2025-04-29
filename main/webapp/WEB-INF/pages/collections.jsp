<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WatchX - Collections</title>
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
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.collection-header {
	text-align: center;
	padding: 30px 0;
	position: relative;
}

.collection-title {
	font-size: 32px;
	color: #6b563d;
	letter-spacing: 3px;
	text-transform: uppercase;
	font-weight: 400;
}

.collection-filter {
	display: flex;
	justify-content: center;
	margin: 30px 0;
	gap: 20px;
}

.filter-button {
	padding: 10px 15px;
	background: white;
	border: 1px solid #ddd;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: all 0.3s;
	position: relative;
}

.filter-button img {
	width: 60px;
	height: 60px;
	object-fit: cover;
	display: block;
	margin: 0 auto 10px;
}

.filter-button.active {
	border-color: #6b563d;
}

.filter-button:hover {
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.filter-name {
	font-size: 12px;
	font-weight: 500;
	text-align: center;
}

.sort-section {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	margin: 20px 0;
	font-size: 14px;
	color: #666;
}

.sort-label {
	margin-right: 10px;
	text-transform: uppercase;
	letter-spacing: 1px;
	font-size: 12px;
}

.best-sellers {
	background: #e6e6e6;
	padding: 4px 10px;
	border-radius: 2px;
	font-size: 12px;
	font-weight: 500;
}

.product-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 30px;
	margin-top: 30px;
}

.product-card {
	background: white;
	border: 1px solid #eee;
	border-radius: 4px;
	overflow: hidden;
	transition: transform 0.3s, box-shadow 0.3s;
	position: relative;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.product-image {
	position: relative;
	height: 300px;
	overflow: hidden;
}

.product-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.5s;
}

.product-card:hover .product-image img {
	transform: scale(1.05);
}

.product-info {
	padding: 20px;
}

.product-name {
	font-size: 16px;
	font-weight: 600;
	margin-bottom: 5px;
	color: #333;
}

.product-category {
	font-size: 14px;
	color: #888;
	margin-bottom: 10px;
}

.product-description {
	font-size: 14px;
	line-height: 1.5;
	color: #666;
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
	font-weight: 500;
}

.see-more:hover {
	text-decoration: underline;
}

.product-meta {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 15px;
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
	font-size: 18px;
	font-weight: 600;
	color: #6b563d;
}

.shop-now-btn {
	display: block;
	width: 100%;
	padding: 12px 0;
	background: #2d2d2d;
	color: white;
	text-align: center;
	border: none;
	margin-top: 15px;
	cursor: pointer;
	text-transform: uppercase;
	font-size: 14px;
	letter-spacing: 1px;
	transition: background 0.3s;
}

.shop-now-btn:hover {
	background: #6b563d;
}

/* Modal Styles */
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 1000;
	align-items: center;
	justify-content: center;
}

.modal-content {
	background-color: white;
	width: 600px;
	max-width: 90%;
	border-radius: 8px;
	box-shadow: 0 5px 30px rgba(0, 0, 0, 0.3);
	padding: 30px;
	position: relative;
	max-height: 80vh;
	overflow-y: auto;
}

.close-modal {
	position: absolute;
	top: 15px;
	right: 15px;
	font-size: 24px;
	cursor: pointer;
	color: #666;
}

.modal-title {
	font-size: 20px;
	margin-bottom: 15px;
	color: #333;
	font-weight: 600;
}

.modal-description {
	font-size: 15px;
	line-height: 1.7;
	color: #555;
	margin-bottom: 20px;
}

.modal-specs {
	margin-top: 20px;
}

.spec-title {
	font-weight: 600;
	margin-bottom: 10px;
	font-size: 16px;
	color: #333;
}

.spec-list {
	list-style: none;
}

.spec-list li {
	display: flex;
	margin-bottom: 8px;
	font-size: 14px;
}

.spec-label {
	width: 140px;
	font-weight: 500;
	color: #666;
}

.spec-value {
	flex: 1;
	color: #333;
}

@media ( max-width : 992px) {
	.product-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 576px) {
	.product-grid {
		grid-template-columns: 1fr;
	}
	.collection-filter {
		flex-wrap: wrap;
	}
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="container">
		<div class="collection-header">
			<h1 class="collection-title">All Collections</h1>
		</div>

		<div class="collection-filter">
			<div class="filter-button active">
				<img src="" alt="Shop All"> <span
					class="filter-name">Shop All</span>
			</div>
			<div class="filter-button">
				<img src="" alt="Luxury"> <span
					class="filter-name">Luxury</span>
			</div>
			<div class="filter-button">
				<img src="" alt="Sports"> <span
					class="filter-name">Sports</span>
			</div>
			<div class="filter-button">
				<img src="" alt="Smart"> <span
					class="filter-name">Smart</span>
			</div>
		</div>

		<div class="sort-section">
			<span class="sort-label">Sort by</span> <span class="best-sellers">Best
				Sellers</span>
		</div>

		<div class="product-grid">
			<!-- Product 1 -->
			<div class="product-card">
				<div class="product-image">
					<img src="" alt="Chronograph Elite">
				</div>
				<div class="product-info">
					<h3 class="product-name">CHRONOGRAPH ELITE</h3>
					<p class="product-category">Luxury Watch</p>
					<p class="product-description">Premium stainless steel
						chronograph watch with Swiss movement, water resistance up to
						100m, and sapphire crystal glass.</p>
					<a class="see-more" data-id="product1">See more</a>
					<div class="product-meta">
						<div class="product-rating">
							<span class="stars">★★★★★</span> <span class="review-count">124
								reviews</span>
						</div>
						<div class="product-price">$599</div>
					</div>
					<button class="shop-now-btn">Shop Now</button>
				</div>
			</div>

			<!-- Product 2 -->
			<div class="product-card">
				<div class="product-image">
					<img src="" alt="Diver Pro">
				</div>
				<div class="product-info">
					<h3 class="product-name">DIVER PRO</h3>
					<p class="product-category">Sports Watch</p>
					<p class="product-description">Professional diving watch with
						300m water resistance, unidirectional rotating bezel, and luminous
						hour markers.</p>
					<a class="see-more" data-id="product2">See more</a>
					<div class="product-meta">
						<div class="product-rating">
							<span class="stars">★★★★☆</span> <span class="review-count">98
								reviews</span>
						</div>
						<div class="product-price">$349</div>
					</div>
					<button class="shop-now-btn">Shop Now</button>
				</div>
			</div>

			<!-- Product 3 -->
			<div class="product-card">
				<div class="product-image">
					<img src="" alt="Minimalist Ultra">
				</div>
				<div class="product-info">
					<h3 class="product-name">MINIMALIST ULTRA</h3>
					<p class="product-category">Dress Watch</p>
					<p class="product-description">Ultra-thin dress watch with
						minimalist design, Japanese quartz movement, and genuine leather
						strap.</p>
					<a class="see-more" data-id="product3">See more</a>
					<div class="product-meta">
						<div class="product-rating">
							<span class="stars">★★★★★</span> <span class="review-count">156
								reviews</span>
						</div>
						<div class="product-price">$249</div>
					</div>
					<button class="shop-now-btn">Shop Now</button>
				</div>
			</div>

			<!-- Product 4 -->
			<div class="product-card">
				<div class="product-image">
					<img src="" alt="Smart Fitness">
				</div>
				<div class="product-info">
					<h3 class="product-name">SMART FITNESS</h3>
					<p class="product-category">Smart Watch</p>
					<p class="product-description">Advanced fitness tracking
						smartwatch with heart rate monitor, GPS, and 7-day battery life.</p>
					<a class="see-more" data-id="product4">See more</a>
					<div class="product-meta">
						<div class="product-rating">
							<span class="stars">★★★★☆</span> <span class="review-count">87
								reviews</span>
						</div>
						<div class="product-price">$199</div>
					</div>
					<button class="shop-now-btn">Shop Now</button>
				</div>
			</div>

			<!-- Product 5 -->
			<div class="product-card">
				<div class="product-image">
					<img src="" alt="Classic Automatic">
				</div>
				<div class="product-info">
					<h3 class="product-name">CLASSIC AUTOMATIC</h3>
					<p class="product-category">Luxury Watch</p>
					<p class="product-description">Self-winding automatic watch
						with exhibition case back, 41mm case, and alligator leather strap.</p>
					<a class="see-more" data-id="product5">See more</a>
					<div class="product-meta">
						<div class="product-rating">
							<span class="stars">★★★★★</span> <span class="review-count">112
								reviews</span>
						</div>
						<div class="product-price">$475</div>
					</div>
					<button class="shop-now-btn">Shop Now</button>
				</div>
			</div>

			<!-- Product 6 -->
			<div class="product-card">
				<div class="product-image">
					<img src="" alt="Adventure GMT">
				</div>
				<div class="product-info">
					<h3 class="product-name">ADVENTURE GMT</h3>
					<p class="product-category">Sports Watch</p>
					<p class="product-description">Travel-ready GMT watch with dual
						time zone display, scratch-resistant ceramic bezel, and stainless
						steel bracelet.</p>
					<a class="see-more" data-id="product6">See more</a>
					<div class="product-meta">
						<div class="product-rating">
							<span class="stars">★★★★☆</span> <span class="review-count">74
								reviews</span>
						</div>
						<div class="product-price">$399</div>
					</div>
					<button class="shop-now-btn">Shop Now</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal for Product 1 -->
	<div id="modal-product1" class="modal">
		<div class="modal-content">
			<span class="close-modal">&times;</span>
			<h2 class="modal-title">CHRONOGRAPH ELITE</h2>
			<div class="modal-description">
				<p>The Chronograph Elite represents the pinnacle of luxury
					timepieces, combining precision engineering with sophisticated
					design. This premium stainless steel chronograph watch features
					Swiss-made automatic movement, water resistance up to 100m, and
					scratch-resistant sapphire crystal glass.</p>
				<p>The elegant 42mm case houses a meticulously crafted dial with
					three subdials for seconds, minutes, and hours. The tachymeter
					bezel allows for speed calculations, while the applied hour markers
					ensure excellent readability in all conditions.</p>
			</div>
			<div class="modal-specs">
				<h3 class="spec-title">Specifications</h3>
				<ul class="spec-list">
					<li><span class="spec-label">Movement:</span> <span
						class="spec-value">Swiss Automatic</span></li>
					<li><span class="spec-label">Case Material:</span> <span
						class="spec-value">316L Stainless Steel</span></li>
					<li><span class="spec-label">Case Size:</span> <span
						class="spec-value">42mm</span></li>
					<li><span class="spec-label">Crystal:</span> <span
						class="spec-value">Sapphire with anti-reflective coating</span></li>
					<li><span class="spec-label">Water Resistance:</span> <span
						class="spec-value">100m (330ft)</span></li>
					<li><span class="spec-label">Strap:</span> <span
						class="spec-value">Stainless Steel Bracelet with butterfly
							clasp</span></li>
					<li><span class="spec-label">Functions:</span> <span
						class="spec-value">Hours, Minutes, Seconds, Date,
							Chronograph</span></li>
					<li><span class="spec-label">Warranty:</span> <span
						class="spec-value">2 Years International</span></li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Modal for Product 2 -->
	<div id="modal-product2" class="modal">
		<div class="modal-content">
			<span class="close-modal">&times;</span>
			<h2 class="modal-title">DIVER PRO</h2>
			<div class="modal-description">
				<p>The Diver Pro is engineered for underwater adventures,
					meeting ISO 6425 standards for professional diving watches. With
					300m water resistance, a unidirectional rotating bezel, and
					SuperLuminova-coated hands and markers, this timepiece is built to
					perform in the most challenging environments.</p>
				<p>The corrosion-resistant 316L stainless steel case and
					screw-down crown ensure watertight integrity, while the helium
					escape valve allows for decompression during professional
					saturation diving. The Diver Pro combines rugged functionality with
					sporty aesthetics for a watch that performs as good as it looks.</p>
			</div>
			<div class="modal-specs">
				<h3 class="spec-title">Specifications</h3>
				<ul class="spec-list">
					<li><span class="spec-label">Movement:</span> <span
						class="spec-value">Japanese Automatic</span></li>
					<li><span class="spec-label">Case Material:</span> <span
						class="spec-value">316L Stainless Steel</span></li>
					<li><span class="spec-label">Case Size:</span> <span
						class="spec-value">43.5mm</span></li>
					<li><span class="spec-label">Crystal:</span> <span
						class="spec-value">Sapphire</span></li>
					<li><span class="spec-label">Water Resistance:</span> <span
						class="spec-value">300m (1000ft)</span></li>
					<li><span class="spec-label">Bezel:</span> <span
						class="spec-value">Unidirectional 120-click with ceramic
							insert</span></li>
					<li><span class="spec-label">Strap:</span> <span
						class="spec-value">Rubber with deployant clasp</span></li>
					<li><span class="spec-label">Warranty:</span> <span
						class="spec-value">2 Years International</span></li>
				</ul>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
	<!-- More modals for other products would go here -->

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