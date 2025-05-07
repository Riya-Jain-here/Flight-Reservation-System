<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="MyPack.DatabaseConnection" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment</title>
         <link rel="icon" href="./logo_flight.jpg">
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
         <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
         <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
         
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
                background: blue;
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
            .condiv{
                font-family:'Poppins', sans-serif;
                background-color: lightgreen;
                border-radius: 30px;
                width:80%;
                height:80%;
                margin: 70px auto 50px auto;
                font-weight:bold;
                font-size: 20px;
                box-shadow:  4px 4px 8px lightgreen;
            }

            .form-container{
                display:grid;
                grid-template-columns: auto auto auto auto;
                align-items: center;
                gap: 40px;
                padding:30px;
            }

            input{
                border-radius: 30px;
                width:80%;
                height:35px;
                display: block;
                padding-left: 25px;
                font-size: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                border: 1px solid #ccc;
                outline: none;
            }

            .btn-form{
                margin-left: 80%;
                top:80%;
                width:130px;
                height:50px;
                border-radius: 10px;
                font-size: 100%;
                color: white;
                background-color:green;
                border: 1px solid green;
                cursor: pointer;
            }
            
            .btn-form:hover {
                  background-color: limegreen;
                  color: white;
                  border-color: limegreen;
              }

              .logout-btn {
                  margin-right: 40px;
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
           <img src="logo_flight.jpg" alt="Logo" class="logo-img">
          Fly Now</span>
       <button onclick="logout()"  class="logout-btn">Logout</button>
  </div>
</nav> 
        
        <div class="container text-center mt-5">
            <br>
            <h3 class="display-5 fw-bold text-white">Proceed with Payment</h3>
        </div>
        
          <%
            HttpSession sess = request.getSession(false);
             if (sess == null || sess.getAttribute("user_id") == null) {
                response.sendRedirect("Login.jsp?error=PleaseLogin");
                return;
            }
            Integer user_id = (Integer) sess.getAttribute("user_id");
            String email = (String) sess.getAttribute("email");
            
            if (email == null) {
                response.sendRedirect("Login.jsp?error=EmailMissing");
                return;
            }
    
            if (user_id == null) {
            response.sendRedirect("Login.jsp?error=PleaseLogin"); 
            return;
            }
    
            int ticket_id = -1;
            double ticketPrice = 0;

            String totalPrice = request.getParameter("totalPrice");
            
        try {
            Connection connection = DatabaseConnection.initializeDatabase();
 
            PreparedStatement ps = connection.prepareStatement("SELECT ticket_id,ticketPrice FROM bookedList WHERE passenger_email=? AND payment_status='Pending' LIMIT 1");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ticket_id = rs.getInt("ticket_id");
                ticketPrice = rs.getDouble("ticketPrice");
            }
            connection.close();
        } 
           catch (Exception e) {
                e.printStackTrace();
            }
     
        if (ticket_id == -1) {
             response.sendRedirect("userDashboard.jsp?error=NoPendingPayments");
             return;
        }
   
%>
        
        <div class="condiv">
            <% 
            // Display success message if available from request
            String bookingMessage = (String) request.getAttribute("bookingMessage");
            if (bookingMessage != null) {
                out.println("<div class='successMessage'>" + bookingMessage + "</div>");
            }
        %>

        <form class= "form-container" action="paymentupdate" method="post" >
        <input type="hidden" name="ticket_id" value="<%= ticket_id %>">
        Full Name: <input type="text" name="name" required><br>
        Email: <input type="email" name="email"  value="<%= email %>" readonly><br>
        Card Number: <input type="text" name="cardNumber" required><br>
        Expiry Date: <input type="text" name="expiryDate" required><br>
        CVV: <input type="password" name="cvv" required><br>
        Amount: <input type="text" name="amount" value="<%= ticketPrice %>" ><br>
        <button type="submit" class="btn-form">Pay Now</button>
    </form>
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

            <!-- useful links -->
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
