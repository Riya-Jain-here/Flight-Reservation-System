<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="MyPack.DatabaseConnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="./logo_flight.jpg">
        <title>Flights Details</title>
         <link rel="icon" href="./logo_flight.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
    <style>
        .container-fluid{
                background-color:lightskyblue;
                margin-top:-1%;
                height:58px;
        }
        
        .nav-link{
                margin-left:20px;
                font-size: 20px;
                margin-right: 25px;
        }
        
        .mb-0{
             margin-left:15px;
             font-family:monospace;
             font-style:italic;
             font-size:25px;
             font-weight:bold;
        }
        
        table{
            border:2px solid skyblue;
            height:auto;
            width:auto;
            margin-top:20%;
            margin-left:20px;
        }

        
        th{
            border:2px solid skyblue;
            padding: 6px;
            font-size: 20px;
        }
        
        td{
            padding: 10px;
            border: 2px  solid skyblue;
        }
        
        button{
               width:100px;
               height:60px;
               border-radius: 5px;
               font-size: 100%;
               color: white;
               background-color:grey;
               border: none;
               outline: none;
               cursor: pointer;
        }
        
        .searchcontain{
            display:grid;
            grid-template-columns: repeat(4,1fr);
            align-items: center;
            column-gap: 40px;
            row-gap: 10px;
            padding:20px;
            flex-direction: column;
        }
        
        .condiv{
                display:flex;
                position: absolute;
                width:95%;
                height:30%;
                margin-top:1%;
                margin-left: 3%;
                font-weight:bold;
                font-family:inherit;
                font-size: 20px;
                box-shadow:  4px 4px 8px lightskyblue;
            }
            
            input{
               border-radius: 30px;
               width:85%;
               height:35px;
               display:block;
               padding-left: 20px;
               font-size: 20px;
               box-shadow: 4px 4px 8px black;
               border: none;
               outline: none;
            }
            
            .search{
                margin-left: 125%;
                width:70%;
            }
            
        
    </style>
    </head>
    <body>
        
      <nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">Fly Now</span>
      <div class="navbar-nav">
        <a class="nav-link"  href="index.html">Home</a>
        <a class="nav-link active" aria-current="page" href="FlightList.jsp">Flight List</a>
        <a class="nav-link" href="Login.jsp">Login</a>
        <a class="nav-link" href="Signup.jsp">Signup</a>
      </div>
  </div>
</nav> 
    <center> <h2>View Flight Details</h2></center><br><br><br>
    
    <div class="condiv">
    <form action="FlightList.jsp" method="GET" class="searchcontain">
       From City:<input type="text" name="fromCity" required> 
       Destination:<input type="text" name="toCity" required> 
       Date of Travel:<input type="date" name="travelDate" required>
       <button type="submit" class="search">Search Flight</button>
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
        
    </body>
</html>
