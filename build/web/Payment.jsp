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
        <style>
            
        .container-fluid{
                background-color:lightskyblue;
               margin-top: -1%;
                height:58px;
        }
        
        .mb-0{
             margin-left:15px;
             font-family:monospace;
             font-style:italic;
             font-size:25px;
             font-weight:bold;
        }
           
            .condiv{
                position: absolute;
                background-color: lightgreen;
                border-radius: 30px;
                width:70%;
                height:70%;
                margin-top:3%;
                margin-left: 15%;
                font-weight:bold;
                font-family:inherit;
                font-size: 20px;
                box-shadow:  4px 4px 8px lightgreen;
            }
            
            .form-container{
                display:grid;
                grid-template-columns: auto auto auto auto;
                gap:10px;
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
               box-shadow: 4px 4px 8px black;
               border: none;
               outline: none;
            }
            
            .btn-form{
               position: absolute;
               margin-left: 40%;
               top:80%;
               width:130px;
               height:50px;
               border-radius: 5px;
               font-size: 100%;
               color: white;
               background-color:green;
               border: none;
               outline: none;
               cursor: pointer;
            }
            
        </style>
    </head>
    
    <body>
        
         <nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">Fly Now</span>
       <button onclick="logout()">Logout</button>
  </div>
</nav> 
        
        
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
        
       
        <h2>Enter Payment Details</h2>
        <div class="condiv">
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
        
        
         <script>
               function logout() {
                  sessionStorage.clear(); 
                  localStorage.clear();   
                  window.location.href = "LogoutServlet"; 
                }
         </script>
       
    </body>
</html>
