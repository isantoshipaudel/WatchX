<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WatchX - Modern Timepieces</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/home.css" />
	
</head>
<body>
	<jsp:include page="header.jsp" />
	<section class="main">
		<div class="main-text">
			<h1>Explore The</h1>
			<p>
				<strong>High-Precision Timepieces that Blend elegance with
					Exceptional Accuracy.</strong>
			</p>
			<p>High range of designer watches for both men and women.</p>
			<button>Shop Now</button>
		</div>
		<div class="main-image">
			<img src="resources/images/WX (2).png">
		</div>
	</section>
	<section class="brand-section">
		<h2 class="brand-title">Our Prestigious Partners</h2>
		<p class="brand-subtitle">WatchX proudly presents timepieces from
			the world's most renowned watchmakers, each offering unparalleled
			craftsmanship and heritage.</p>
		<div class="brand-container">
			<div class="brand-a">BLANCPAIN</div>
			<div class="brand-a">IWC</div>
			<div class="brand-a">CITIZEN</div>
			<div class="brand-a">HAMILTON</div>
			<div class="brand-a">BREMONT</div>
			<div class="brand-a">OMEGA</div>
		</div>
	</section>
	<section class="new-arrival">
	<h2 class="section-title">New Arrival</h2>
	<div class="cards">
		<div class="watch-card">
			<img src="resources/images/Watch1.jpg" alt="Rolex Submariner Date" class="watch-img">
			<h3 class="watch-title">Rolex Submariner Date</h3>
			<p class="watch-model">Model Code: 126610LN</p>
			<p class="watch-desc">Stainless Golden Steel</p>
		</div>

		<div class="watch-card">
			<img src="resources/images/image3.jpg" alt="Edifice Neon Illuminator"
				class="watch-img">
			<h3 class="watch-title">Edifice Neon Illuminator</h3>
			<p class="watch-model">Model : EFR-539BK-1AVUEF</p>
			<p class="watch-desc">Stainless Brown Steel</p>
		</div>

		<div class="watch-card">
			<img src="resources/images/Watch3.jpg"  alt="Omega Seamaster Planet" class="watch-img">
			<h3 class="watch-title">Omega Seamaster Planet</h3>
			<p class="watch-model">Ocean 600M</p>
			<p class="watch-desc">Stainless White Steel</p>
		</div>
	</div>
	</section>
	<section class="best-seller">
  <h2 class="section-title">Best Seller Watches</h2>
  <div class="carousel">
    <div class="watch-slide">
      <div class="watch-card">
        <img src="resources/images/Watch4.jpg" alt="Best Seller 1" class="watch-img">
        <div class="date-circle">
          <span class="day">29</span><br><span class="month">Aug</span>
        </div>
      </div>
     <a href="${contextPath}/collections" class="arrow-btn">➜</a>
    </div>
    <div class="watch-slide">
      <div class="watch-card">
        <img src="resources/images/Watch5.jpg" alt="Best Seller 2" class="watch-img">
        <div class="date-circle">
          <span class="day">28</span><br><span class="month">Aug</span>
        </div>
      </div>
    </div>
    <div class="watch-slide">
      <div class="watch-card">
        <img src="resources/images/Watch6.jpg" alt="Best Seller 3" class="watch-img">
        <div class="date-circle">
          <span class="day">26</span><br><span class="month">Aug</span>
        </div>
      </div>
    </div>
  </div>

  <div class="carousel-dots">
    <span class="dot active"></span>
    <span class="dot"></span>
    <span class="dot"></span>
  </div>
</section>

	<jsp:include page="footer.jsp" />
</body>
</html>
