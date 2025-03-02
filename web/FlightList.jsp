<%@ page import="java.sql.*, java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Flights Details</title>
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
        <a class="nav-link active" aria-current="page" href="index.html">Home</a>
        <a class="nav-link" href="FlightList.jsp">Flight List</a>
        <a class="nav-link" href="Login.jsp">Login</a>
        <a class="nav-link" href="Signup.jsp">Signup</a>
      </div>
  </div>
</nav> 
    <center> <h2>View Flight Details</h2></center><br><br><br>
    
    <div class="condiv">
    <form action="AddFlightServlet" method="GET" class="searchcontain">
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
            //HttpSession sess = request.getSession(false);
            //boolean loggedIn = (sess != null && sess.getAttribute("user_id") != null);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/frs?useSSL=false&serverTimezone=UTC", "root", "your_password");
            String sql = "SELECT * FROM flightList where no_of_seats>0";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            
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
            connection.close();
        %>
    </table>
    <br><br>
        
    </body>
</html>
