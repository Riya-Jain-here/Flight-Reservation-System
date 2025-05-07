<% 
    String username = (String) session.getAttribute("userName"); 
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact Us</title>
        <link rel="icon" href="./logo_flight.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        
        <style>
            body{
                background-image: url("Backg.webp");
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: 100% 100%;
            }

            .container-fluid{
                background-color:#3399ff;
                margin-top:-1%;
                height:75px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .nav-link{
                margin-left:5px;
                font-size: 23px;
                margin-right: 30px;
            }

            .mb-0{
                margin-left:60px;
                font-family:monospace;
                font-style:italic;
                font-size:30px;
                font-weight:bold;
            }

            .navbar-nav{
                margin-right: 30px;
            }

            .logo-img {
                height: 60px;
                width: 60px;
                margin-right: 10px;
                vertical-align: middle;
                background: lightskyblue;
                mix-blend-mode:multiply;
                opacity: 0.9;
                border-radius: 100%;
                object-fit: cover;
            }

            footer {
                position: relative;
                bottom: 0;
                width: 100%;
            }

            .contact-section {
                background-color: rgba(255, 255, 255, 0.85);
                border-radius: 12px;
                max-width: 800px;
                margin: 100px auto 50px auto;
                padding: 30px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .contact-section h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #0056b3;
            }

            .contact-info {
                margin-top: 20px;
            }

            .contact-info i {
                margin-right: 10px;
                color: #0d6efd;
            }

            .social-icons a {
                font-size: 24px;
                margin-right: 15px;
                color: #0d6efd;
                text-decoration: none;
            }

            .social-icons a:hover {
                color: #0056b3;
            }

            .logout-btn {
                margin-right: 40px;
                margin-top: 5px;
                width:80px;
                height:40px;
                padding: 6px 15px;
                font-size: 16px;
                background-color: #0056b3;
                border: none;
                border-radius: 4px;
                color: white;
                cursor: pointer;
            }

            .logout-btn:hover {
                background-color: #004494;
            }

    </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg fixed-top">
      <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">
          <img src="logo_flight.jpg" alt="Logo" class="logo-img">Fly Now
      </span>
      <div class="navbar-nav">
        <a class="nav-link" href="index.html">Home</a>
         <a class="nav-link active" aria-current="page" href="ContactUs.jsp">Contact Us</a>
        
        <% if (username == null) { %>
                        <a class="nav-link" href="FlightList.jsp">Flights</a>
                        <a class="nav-link" href="Login.jsp">Login</a>
                        <a class="nav-link" href="Signup.jsp">Signup</a>
                    <% } else { %>
                        <a class="nav-link" href="UserLogin.jsp">You</a>
                        <button onclick="logout()"  class="logout-btn">Logout</button>
                    <% } %>
                    
      
      </div>
  </div>
</nav>
        
    <div class="contact-section">
        <h2>Contact Us</h2>
        <form action="ContactServlet" method="post">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <input type="text" class="form-control" name="name" placeholder="Your Name" required>
                </div>
                <div class="col-md-6 mb-3">
                    <input type="email" class="form-control"  name="email" placeholder="Your Email" required>
                </div>
            </div>
            <div class="mb-3">
                <textarea class="form-control" rows="4"  name="message" placeholder="Your Message" required></textarea>
            </div>
            <div class="text-center">
                <button class="btn btn-primary" type="submit">Send Message</button>
            </div>
        </form>
        
        <%
    String successMessage = (String) request.getAttribute("successMessage");
    if (successMessage != null) {
        %>
        <div class="alert alert-success mt-3 text-center" role="alert">
            <%= successMessage %>
        </div>
        <%
            }
        %>

        <div class="contact-info mt-4">
            <p><i class="bi bi-envelope"></i> support@flynow.com</p>
            <p><i class="bi bi-telephone"></i> +91 98765 43210</p>
            <div class="social-icons">
                <a href="#"><i class="bi bi-facebook"></i></a>
                <a href="#"><i class="bi bi-twitter"></i></a>
                <a href="#"><i class="bi bi-linkedin"></i></a>
            </div>
        </div>
    </div>
        
         <footer class="bg-light text-center text-lg-start mt-5">
            <div class="container p-4">
                <div class="row">
                    <!-- About -->
                    <div class="col-lg-4 col-md-6 mb-4 mb-md-0">
                        <h5 class="text-uppercase">Fly Now</h5>
                        <p>
                            Your trusted partner for safe and affordable flight bookings across India and beyond.
                        </p>
                    </div>

                    <!-- Useful Links -->
                    <div class="col-lg-4 col-md-6 mb-4 mb-md-0">
                        <h5 class="text-uppercase">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Quick Links</h5>
                        <ul class="list-unstyled mb-0">
                            <li><a href="index.html" class="text-primary text-decoration-none fw-normal">Home</a></li>
                            <li><a href="FlightList.jsp" class="text-primary text-decoration-none fw-normal">Flights</a></li>
                            <li><a href="Login.jsp" class="text-primary text-decoration-none fw-normal">Login</a></li>
                            <li><a href="Signup.jsp" class="text-primary text-decoration-none fw-normal">Signup</a></li>
                            <li><a href="ContactUs.jsp" class="text-primary text-decoration-none fw-normal">Contact Us</a></li>
                        </ul>
                    </div>

                    <!-- Contact Info -->
                    <div class="col-lg-4 col-md-12 mb-4 mb-md-0">
                        <h5 class="text-uppercase">Contact</h5>
                        <p><i class="bi bi-envelope"></i> support@flynow.com</p>
                        <p><i class="bi bi-phone"></i> +91 99999xxxxx</p>
                        <p><i class="bi bi-geo-alt"></i> Delhi, India</p>
                    </div>
                </div>
            </div>

            <div class="text-center p-3 bg-primary text-white">
                © 2025 Fly Now | All rights reserved
            </div>
        </footer>
        
        <script>
            function logout() {
                sessionStorage.clear();
                localStorage.clear();
                window.location.href = "LogoutServlet";
            }
        </script>

    </body>
</html>
