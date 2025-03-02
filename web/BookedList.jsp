<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booked List</title>
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
        
        <style>
        
        table{
            border:2px solid green;
            height:auto;
            width:auto;
            margin-top: 2%;
            margin-left:1px;
        }

        
        th{
            border:2px solid green;
            padding: 6px;
            font-size: 20px;
        }
        
        td{
            padding: 10px;
            border: 2px solid green;
        }
        
        
        .container-fluid{
                background-color:lightskyblue;
                margin-top:-1%;
                height:58px;
        }
        
        .mb-0{
             margin-left:15px;
             font-family:monospace;
             font-style:italic;
             font-size:25px;
             font-weight:bold;
        }
        
        a{
            font-style:italic;
            font-size:25px;
            color:darkgreen;
        }
        
        </style>
    </head>
    <body>
        
        <nav class="navbar bg-body-tertiary">
           <div class="container-fluid">
               <span class="navbar-brand mb-0 h1">Welcome to Fly Now</span>
               <button onclick="logout()" >Logout</button>
           </div>
        </nav>
    <center> <h2>View Booked Tickets </h2></center>
    
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
        
        <%  Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/frs?useSSL=false&serverTimezone=UTC", "root", "your_password");
            String sql = "SELECT b.ticket_id,b.user_id, b.flight_id,b.flightName,b.passengerName,b.passenger_email,b.booking_date,b.departureDate,b.no_of_seats,b.ticketPrice,p.ticket_id, p.amount,p.payment_status,p.paid_at FROM bookedList b LEFT JOIN payment p ON b.ticket_id = p.ticket_id";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
            
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
            connection.close();
        %>
    </table>
    
     <script>
               function logout() {
                  sessionStorage.clear(); 
                  localStorage.clear();   
                  window.location.href = "Logout.jsp"; 
                }
         </script>
        
    </body>
</html>
