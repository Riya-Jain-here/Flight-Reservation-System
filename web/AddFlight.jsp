<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Flights Details</title>
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
               margin-left: 80%;
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
    <div class="condiv">
    <form action="AddFlightServlet" method="post" class="form-container"> 
    Flight No:<input type="text" name="flightNo" class="form-control" required>
    Flight Name: <input type="text" name="flightName" class="form-control" required>
    From City: <input type="text" name="fromCity" class="form-control" required>
    Destination: <input type="text" name="destination" class="form-control" required>
    Date:<input type="date" name="date" class="form-control" required>
    Departure Time: <input type="time" name="departure_time" class="form-control" required>
    Arrival Time: <input type="time" name="arrival_time" class="form-control" required>
    Ticket Price: <input type="number" name="ticket_price" class="form-control" step="0.01" required>
    No of Seats: <input type="number" name="no_of_seats" class="form-control" required><br>
    <button type="submit" class="btn-form"> Add Flight</button>
    </form>
    </div>
         <script>
               function logout() {
                  sessionStorage.clear(); 
                  localStorage.clear();   
                  window.location.href = "Logout.jsp"; 
                }
         </script>
    </body>
</html>
