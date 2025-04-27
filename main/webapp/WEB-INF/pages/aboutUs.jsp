<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About WatchX</title>
<link rel="stylesheet" type="text/css"
 href="${pageContext.request.contextPath}/css/aboutUs.css" />
</head>
<body>
  <jsp:include page= "header.jsp" />
  <main class="about-main">
    <div class="about-container">
      <h1>About WatchX</h1>
      <p class="tagline">"Precision. Prestige. Performance."</p>

      <div class="about-content">
        <p>
          Founded in <strong>2018</strong>, WatchX has been redefining luxury timekeeping for <strong>6 years</strong>. We don't just sell timepieces — we deliver experiences. Each watch in our collection is a fusion of master craftsmanship, innovative design, and enduring elegance. Whether it's for a bold impression or subtle sophistication, WatchX caters to every moment of style.
        </p>
        
        <div class="highlight-box">
          <div class="highlight-item">
            <div class="highlight-number">6+</div>
            <div class="highlight-label">Years of Excellence</div>
          </div>
          <div class="highlight-item">
            <div class="highlight-number">5K+</div>
            <div class="highlight-label">Delighted Clients</div>
          </div>
          <div class="highlight-item">
            <div class="highlight-number">50+</div>
            <div class="highlight-label">Brand Collections</div>
          </div>
        </div>

        <p>
          We proudly collaborate with iconic brands including <em>Omega, Blancpain, IWC, Hamilton, Citizen, Bremont</em>, and more, bringing world-class quality to your wrist. Every piece is handpicked by our expert horologists to ensure it meets the exacting standards of our discerning clientele.
        </p>
        
        <div class="founder-quote">
          "A watch should tell more than time - it should tell your story. At WatchX, we curate timepieces that become heirlooms, marking life's most precious moments."
          <span class="founder-name">— Santoshi Paudel, Founder & CEO</span>
        </div>
        
        <p>
          Our flagship showroom in <strong>Durbar Marg, Kathmandu</strong> and online boutique serve collectors across Nepal and beyond, offering personalized consultations and exceptional after-sales service. When you choose WatchX, you're not just buying a timepiece - you're investing in a legacy.
        </p>
      </div>
    </div>
  </main>
  <jsp:include page= "footer.jsp" />
</body>
</html>