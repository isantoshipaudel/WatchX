<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact WatchX</title>
<link rel="stylesheet" type="text/css"
 href="${pageContext.request.contextPath}/css/contact.css" />
</head>
<body>
  <jsp:include page="header.jsp" />
  
  <main class="contact-main">
    <div class="contact-header">
      <h1>Contact WatchX</h1>
      <p>We'd love to hear from you. Whether you have questions about our timepieces or need assistance, our team is ready to help.</p>
    </div>
    
    <div class="contact-container">
      <div class="contact-info">
        <h2>Our Information</h2>
        
        <div class="contact-detail">
          <div class="contact-icon">📍</div>
          <div class="contact-text">
            <h3>Visit Us</h3>
            <p>Durbar Marg, Kathmandu<br>Nepal</p>
          </div>
        </div>
        
        <div class="contact-detail">
          <div class="contact-icon">📞</div>
          <div class="contact-text">
            <h3>Call Us</h3>
            <p>+977 1-4223456<br>Sunday-Friday: 10AM - 6PM</p>
          </div>
        </div>
        
        <div class="contact-detail">
          <div class="contact-icon">✉️</div>
          <div class="contact-text">
            <h3>Email Us</h3>
            <p>info@watchx.com<br>support@watchx.com</p>
          </div>
        </div>
      </div>
      
      <div class="contact-form">
        <h2>Send Us a Message</h2>
        <form action="/contact" method="post">
          <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" class="form-control" required>
          </div>
          
          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" class="form-control" required>
          </div>
          
          <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" class="form-control">
          </div>
          
          <div class="form-group">
            <label for="message">Your Message</label>
            <textarea id="message" name="message" class="form-control" required></textarea>
          </div>
          
          <button type="submit" class="submit-btn">Send Message</button>
        </form>
      </div>
    </div>
   
  </main>
  <jsp:include page="footer.jsp" />
</body>
</html>