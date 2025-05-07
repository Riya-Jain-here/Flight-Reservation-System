<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="MyPack.DatabaseConnection" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booked List</title>
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

            footer {
                position: relative;
                bottom: 0;
                width: 100%;
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


            .content-wrapper {
                background-color: rgba(255, 255, 255, 0.6); /*white opacity*/
                padding: 20px;
                border-radius: 10px;
                margin-top: -1%;
            }


            table{
                border:2px solid skyblue;
                height:auto;
                width:100%;
                margin-top:20px;
                margin-left: auto;
                margin-right: auto;
                border-collapse: collapse;
                 font-family: sans-serif;
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
            
            .filter-form {
                margin-bottom: 20px;
                display: flex;
                gap: 20px;
                justify-content: center;
                align-items: center;
            }
            .filter-form input {
                padding: 6px 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
                font-size: 16px;
            }
            .filter-form button {
                padding: 6px 15px;
                font-size: 16px;
                border-radius: 6px;
                border: none;
                background-color: #007bff;
                color: white;
                cursor: pointer;
            }
            .filter-form button:hover {
                background-color: #0056b3;
            }
            .no-results {
                text-align: center;
                font-weight: bold;
                color: red;
            }

        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <span class="navbar-brand mb-0 h1">
                    <img src="logo_flight.jpg" alt="Logo" class="logo-img">
                    Fly Now</span>
                <button onclick="logout()" class="logout-btn">Logout</button>
            </div>
        </nav>

        <div class="content-wrapper">
            <br><br><br>
            <center> <h2>Booking List</h2></center><br>

             <form class="filter-form" method="get">
            <input type="text" name="passengerName" placeholder="Passenger Name" value="<%= request.getParameter("passengerName") != null ? request.getParameter("passengerName") : "" %>">
            <input type="date" name="departureDate" value="<%= request.getParameter("departureDate") != null ? request.getParameter("departureDate") : "" %>">
            <button type="submit">Search</button>
        </form>

            <table border="1">
                <tr>
                    <th>Ticket Id</th>
                    <th>User Id</th>
                    <th>Flight Id</th>
                    <th>Flight Name</th>
                    <th>Passenger Name</th>
                    <th>Passenger Email</th>
                    <th>Booking Date</th>
                    <th>Departure Date</th>
                    <th>No Of Seats Booked</th>
                    <th>Ticket Price</th>
                    <th>Paid Amount</th>
                    <th>Payment Status</th>
                    <th>Paid At</th>

                </tr>

                <% 
                    Connection connection = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    boolean found = false;
                    String filterName = request.getParameter("passengerName");
                    String filterDate = request.getParameter("departureDate");

                    try {
                   
                    connection = DatabaseConnection.initializeDatabase();
                    String sql = "SELECT b.ticket_id,b.user_id, b.flight_id,b.flightName,b.passengerName,b.passenger_email,b.booking_date,b.departureDate,b.no_of_seats,b.ticketPrice,p.ticket_id, p.amount,p.payment_status,p.paid_at FROM bookedList b LEFT JOIN payment p ON b.ticket_id = p.ticket_id WHERE 1=1";
                    
                    if (filterName != null && !filterName.trim().isEmpty()) {
                        sql += " AND LOWER(b.passengerName) LIKE ?";
                    }
                    if (filterDate != null && !filterDate.trim().isEmpty()) {
                        sql += " AND DATE(b.departureDate) = ?";
                    }
                    ps = connection.prepareStatement(sql);
                    
                    int paramIndex = 1;
                    if (filterName != null && !filterName.trim().isEmpty()) {
                        ps.setString(paramIndex++, "%" + filterName.trim().toLowerCase() + "%");
                    }
                    if (filterDate != null && !filterDate.trim().isEmpty()) {
                        ps.setString(paramIndex++, filterDate.trim());
                    }
                    
                    rs = ps.executeQuery();
            
                    while (rs.next()) {
                        found = true; 
                %>
                <tr>
                    <td><%= rs.getInt("ticket_id") %></td>
                    <td><%= rs.getInt("user_id") %></td>
                    <td><%= rs.getInt("flight_id") %></td>
                    <td><%= rs.getString("flightName") %></td>
                    
                    <td><%= rs.getString("passengerName") %></td>
                    <td><%= rs.getString("passenger_email") %></td>
                    <td><%= rs.getString("booking_date") %></td>
                    
                    <td><%= rs.getString("departureDate") %></td>
                    <td><%= rs.getInt("no_of_seats") %></td>
                    <td><%= rs.getString("ticketPrice") %></td>
                    <td><%= rs.getString("amount") %></td>
                    <td><%= rs.getString("payment_status") %></td>
                    <td><%= rs.getTimestamp("paid_at") %></td>

                </tr>
                <%
                }
                
                  if (!found) {
            
                %>
               <tr>
                    <td colspan="13" class="no-results">No matching results found</td>
               </tr>
               
               <%
                    }
                } 
                catch (Exception e) {
                    e.printStackTrace();
               %>
               
                <tr><td colspan="13" class="no-results">Error fetching data.</td></tr>

                <%
                     } finally {
                            if (rs != null) rs.close();
                                if (ps != null) ps.close();
                                    if (connection != null) connection.close();
                        }
                %>
            </table>
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
