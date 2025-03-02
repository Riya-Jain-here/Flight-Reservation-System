<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Ticket</title>
        
        <script>
        function calculatePrice() {
        let ticketPrice = parseFloat(document.getElementById("ticketPrice").value);
        let no_of_seats = parseInt( document.getElementById("no_of_seats").value) || 0;
        let totalPrice = no_of_seats * ticketPrice;
        document.getElementById("totalPrice").value =totalPrice.toFixed(2);
        }
       </script>
        
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
        
        .condiv{
                position: absolute;
                background-color: lightskyblue;
                border-radius: 30px;
                width:80%;
                height:80%;
                margin-top:2%;
                margin-left: 10%;
                font-weight:bold;
                font-family:inherit;
                font-size: 20px;
                box-shadow:  4px 4px 8px lightskyblue;
            }
            
            .form-container{
                display:grid;
                grid-template-columns: auto auto auto auto;
                align-items: center;
                gap: 60px;
                padding:30px;
            }
           
            input{
               border-radius: 30px;
               width:100%;
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
               margin-left: 42%;
               top:87%;
               width:130px;
               height:50px;
               border-radius: 5px;
               font-size: 100%;
               color: white;
               background-color:grey;
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
     HttpSession sess = request.getSession();
    
    // Fetch user details from session (assuming the user is logged in)
    Integer user_id = (session != null) ? (Integer) session.getAttribute("user_id"): null;

    if (user_id == null) {
        response.sendRedirect("Login.jsp?error=PleaseLogin"); 
        return;
    }
    
    String userName = "", email = "";
    String flight_id = request.getParameter("flight_id");
    String flightName = request.getParameter("flightName");
    String date=request.getParameter("date");
    String passengerName=request.getParameter("passengerName");
    //String ticketPrice=request.getParameter("ticketPrice");
   // String totalPrice=request.getParameter("totalPrice");
    
    double ticketPrice = 0.0;
try{ 
    Class.forName("com.mysql.cj.jdbc.Driver");  
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/frs", "root", "your_password");
    PreparedStatement ps = con.prepareStatement("SELECT userName, email FROM signup WHERE user_id=?");
    ps.setInt(1, user_id);
    ResultSet rs = ps.executeQuery();

    
    if (rs.next()) {
        userName = rs.getString("userName");
        email = rs.getString("email");
    }
    
    PreparedStatement ps1 = con.prepareStatement("SELECT ticketPrice FROM flightList WHERE flight_id=?");
    ps1.setString(1, flight_id);
    ResultSet rs1 = ps1.executeQuery();
    
    if (rs1.next()) {
            ticketPrice = rs1.getDouble("ticketPrice");
    }
    
    con.close();
    }
    catch (Exception e) {
        e.printStackTrace();
    }
    %>

        
    <div class="condiv">
    <form action="BookTicketServlet" method="post" class="form-container"> 
    user Id: <input type="number" name="user_id" class="form-control" value="<%= user_id %>" readonly>
    Flight Id: <input type="number" name="flight_id" class="form-control" value="<%= flight_id %>" readonly >
    Flight Name:<input type="text" name="flightName" class="form-control" value="<%= flightName %>" readonly>
    Passenger Name: <input type="text" name="passengerName" class="form-control" value="<%= userName %>" readonly>
    Passenger Email:<input type="email" name="email" class="form-control" value="<%= email %>" readonly>
    Departure Date: <input type="dateTime" name="date" class="form-control" value="<%= date %>" readonly>
    No of Seats:<input type="number" name="no_of_seats" class="form-control" min="1" id="no_of_seats" oninput="calculatePrice()"  required>
    <input type="hidden" name="ticketPrice" id="ticketPrice" value="<%= ticketPrice %>">
    Total Price: <input type="text" name="totalPrice" class="form-control" id="totalPrice" readonly><br>
    
    <input type="hidden" name="ticket_id"  value="<%= request.getParameter("ticket_id") %>">
    <input type="hidden" name="totalPrice" id="hiddenTotalPrice" value="<%= request.getParameter("totalPrice") %>">
    <input type="hidden" name="ticketPrice" id="hiddenTicketPrice" value="<%= ticketPrice %>">
    <button type="submit" class="btn-form">Book Now</button>

    </form>
    </div>
        
    <script>
    function validateAndSetPrice() {
    let no_of_seats = document.getElementById("no_of_seats").value;
    let ticketPrice = document.getElementById("hiddenTicketPrice").value;
    
    if (!no_of_seats || no_of_seats <= 0) {
        alert("Please enter the number of seats.");
        return false;
    }

    let totalPrice = no_of_seats * ticketPrice;
    document.getElementById("hiddenTotalPrice").value = totalPrice.toFixed(2);
    return true;
}
   </script>

        <script>
               function logout() {
                  sessionStorage.clear(); 
                  localStorage.clear();   
                  window.location.href = "Logout.jsp"; 
                }
         </script>
         
      </body>
</html>
