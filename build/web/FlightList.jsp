<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="MyPack.DatabaseConnection" %>
<% 
    String username = (String) session.getAttribute("userName"); 
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="./logo_flight.jpg">
        <title>Available Flights</title>
         <link rel="icon" href="./logo_flight.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
         <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>

        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body{
            background-image: url("Backg.webp");
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }


        .content-wrapper {
            background-color: rgba(255, 255, 255, 0.6); /*white opacity*/
            padding: 20px;
            border-radius: 5px;
            margin-top: -1%;
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
                background: blue;
                mix-blend-mode:multiply;
                opacity: 0.9;
                border-radius: 100%;
                object-fit: cover;
            }

        table{
            border:2px solid skyblue;
            height:auto;
            width:100%;
            margin-top:20px;
            margin-left: auto;
            margin-right: auto;
            border-collapse: collapse;
        }


        th{
            border:2px solid skyblue;
            padding: 6px;
            font-size: 20px;
            text-align: center;
        }

        td{
            padding: 10px;
            border: 2px  solid skyblue;
            text-align: center;
        }

        button{
            width:100px;
            height:60px;
            border-radius: 5px;
            font-size: 100%;
            cursor: pointer;
            color: blue;
            background-color:white;
            border: 1px solid blue;
        }

        button:hover {
                background-color: #3399ff;   
                color: white;               
                border-color: #3399ff;
            }
        
        .searchcontain {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 45px;
            padding: 35px;
            margin-left: 10px;
        }

        .field-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .condiv{
            display:flex;
            position: relative;
            width:95%;
            height:auto;
            margin-left: 5%;
            font-weight:bold;
            font-family:inherit;
            font-size: 18px;

        }

        input{
            border-radius: 30px;
            width:100%;
            height:40px;
            display:block;
            padding-left: 20px;
            font-size: 18px;
            box-shadow: 4px 4px 8px black;
            border: none;
            outline: none;
        }

        .search{
            border-radius: 35px;
            width:100%;
            padding: 10px;
            margin-left: 30px;
            margin-top: 30px;
        }
        
        footer {
            position: relative;
            bottom: 0;
            width: 100%;
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
          <img src="logo_flight.jpg" alt="Logo" class="logo-img">
          Fly Now</span>
      <div class="navbar-nav">
        <a class="nav-link"  href="index.html">Home</a>
        <a class="nav-link" href="ContactUs.jsp">Contact Us</a>
        
        <% if (username == null) { %>
                        <a class="nav-link active" aria-current="page" href="FlightList.jsp">Flights</a>
                        <a class="nav-link" href="Login.jsp">Login</a>
                        <a class="nav-link" href="Signup.jsp">Signup</a>
                    <% } else { %>
                        <a class="nav-link" href="UserLogin.jsp">You</a>
                        <button onclick="logout()"  class="logout-btn">Logout</button>
                      
                    <% } %>      
        
      </div>
  </div>
</nav> 
        
    <div class="content-wrapper">
        <br><br><br><br>
    <center> <h2>Find the best flights and book in seconds</h2></center><br><br>
    
    <div class="condiv">
    <form action="FlightList.jsp" method="GET" class="searchcontain">
        <div class="field-group">
       Departure:<input type="text" name="fromCity" >
        </div>
         <div class="field-group">
       Destination:<input type="text" name="toCity" > 
         </div>
        <div class="field-group">
       Date of Travel:<input type="date" name="travelDate" required>
        </div>
         <div class="field-group">
       <button type="submit" class="search">Search Flight</button>
         </div>
    </form>
    </div>
    
        <table border="1">
        <tr>
            <th>Flight ID</th>
            <th>Flight No</th>
            <th>Flight Name</th>
            <th>From City</th>
            <th>Destination</th>
            <th>Date</th>
            <th>Departure Time</th>
            <th>Arrival Time</th>
            <th>Ticket Price</th> 
            <th>No of Seats</th> 
            <th></th>
        </tr>
       
        <%
            String fromCity = request.getParameter("fromCity");
            String toCity = request.getParameter("toCity");
            String travelDate = request.getParameter("travelDate");
            
            Connection connection = DatabaseConnection.initializeDatabase();
            
            String sql = "SELECT * FROM flightList where no_of_seats>0";
            
             // Add conditions if search filters are provided
            if (fromCity != null && !fromCity.isEmpty()) {
            sql += " AND fromCity = ?";
            }
            if (toCity != null && !toCity.isEmpty()) {
            sql += " AND toCity = ?";
            }
            if (travelDate != null && !travelDate.isEmpty()) {
            sql += " AND date = ?";
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            
            //Set parameters dynamically
            int index = 1;
            if (fromCity != null && !fromCity.isEmpty()) {
            ps.setString(index++, fromCity);
            }
            if (toCity != null && !toCity.isEmpty()) {
            ps.setString(index++, toCity);
            }
            if (travelDate != null && !travelDate.isEmpty()) {
            ps.setString(index++, travelDate);
            }
            
            ResultSet rs = ps.executeQuery();
            boolean found = false;
            while (rs.next()) {
            found=true;
        %>
        <tr>
            <td><%= rs.getInt("flight_id") %></td>
            <td><%= rs.getString("flight_No") %></td>
            <td><%= rs.getString("flightName") %></td>
            <td><%= rs.getString("fromCity") %></td>
            <td><%= rs.getString("toCity") %></td>
            <td><%= rs.getString("date") %></td>
            <td><%= rs.getString("departureTime") %></td>
            <td><%= rs.getString("arrivalTime") %></td>
            <td><%= rs.getBigDecimal("ticketPrice") %></td>
            <td><%= rs.getInt("no_of_seats") %></td>
            <td> <form action="BookTicketServlet" method="Get">
                <input type="hidden" name="flight_id" value="<%= rs.getInt("flight_id") %>">
                <input type="hidden" name="flightName" value="<%= rs.getString("flightName") %>">
                <input type="hidden" name="date" value="<%= rs.getString("date") %>">
                <input type="hidden" name="ticketPrice" value="<%= rs.getBigDecimal("ticketPrice") %>">
                 <input type="hidden" name="no_of_seats" value="<%= rs.getInt("no_of_seats") %>">
                <button type="submit">Book Now</button>
            </form>
            </td>
        </tr>
        <%
            }
            if (!found) {
            out.println("<tr><td colspan='11'>No flights found matching your criteria.</td></tr>");
            }
            rs.close();
            ps.close();
            connection.close();
        %>
    </table>

    <br><br>
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
